//
//  SnapplesTopicView.swift
//  Snapples
//
//  Created by Michael Johnston on 8/24/17.
//  Copyright © 2017 Snapples. All rights reserved.
//

import UIKit

class SnapplesTopicView: UIViewController, UITableViewDelegate, UITableViewDataSource {
// resources
    @IBOutlet var snapplesTableView: UIView!
    @IBOutlet var snapplesTable: UITableView!

    
//  The Snapples that get loaded into the SnappleTable   per everyone
    let snapplesList = ["Hitler", "Graham's Landing", "Parker", "Jankins", "Tig Ole Bitties", "Twerk What Yo Mama Gave Ya!", "item7", "item8", "Graham's Landing", "Parker", "Jankins", "Tig Ole Bitties", "Twerk What Yo Mama Gave Ya!", "item7", "item8"]
//  Keeps Track of whether a Snapple has been liked or not  per user
    let defaultLikedorNot = ["false","false","false","false","false","false","false","false","false","false","false","false","false","false","false",]
    var mutatedLikedorNot = ["false","false","false","false","false","false","false","false","false","false","false","false","false","false","false",]
    
// Grants Access to CustomSnappleCell
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "SnapplesTopicCell", bundle: nil)
        snapplesTable.register(cellNib, forCellReuseIdentifier: "customSnapplesTopicCell")
        snapplesTable.register(SnapplesTopicCell.self, forCellReuseIdentifier: "customSnapplesTopicCell2")
// Checks to see how long since last login
        var lastLogin: NSDate = NSDate()
        if UserDefaults.standard.object(forKey: "lastLogin") == nil {
            lastLogin = NSDate()
        }
        else {
            lastLogin = UserDefaults.standard.object(forKey: "lastLogin") as! NSDate
        }
        let lastLoginInt = Int(lastLogin.timeIntervalSinceNow)
        if lastLoginInt < -72000 { //72000s for 20 snapples hr/snapple
            mutatedLikedorNot = defaultLikedorNot
            UserDefaults.standard.set(mutatedLikedorNot, forKey: "mutatedLikedorNot")
            print("there's a whole new bunch of snapples for you!")
        }
        else if UserDefaults.standard.array(forKey: "mutatedLikedorNot") == nil {
            mutatedLikedorNot = defaultLikedorNot
            UserDefaults.standard.set(mutatedLikedorNot, forKey: "mutatedLikedorNot")
            print("first time user eh?")
        }
        else {
            mutatedLikedorNot = UserDefaults.standard.array(forKey: "mutatedLikedorNot") as! [String]
            let snapplesPassed = lastLoginInt/(-3600)
            print("\(snapplesPassed) snapples have left us")
            var x = 0
// for every hour the corresponding likedornot is removed and set to default
// **This resets everytime a user logs in,  so it will take an hour from that point
            while (x < 16) && (x < (snapplesPassed)) {
                mutatedLikedorNot.append("false")
                mutatedLikedorNot.remove(at: x)
                x += 1
                UserDefaults.standard.set(mutatedLikedorNot, forKey: "mutatedLikedorNot")
            }
        }
        let currentLogin = Date()
        UserDefaults.standard.set(currentLogin, forKey: "lastLogin")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
// Number of Sections in SnappleTable
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
// Number of Rows in the SnappleTable
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snapplesList.count
    }
// Height of Cells
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = snapplesTableView.frame.height/6
        return(height)
    }
// Makes the scroll view feel paginated
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let height: Float = 79.5 //(477/6)
        targetContentOffset.pointee.y = CGFloat(floorf(Float(targetContentOffset.pointee.y) / height) * height)
    }    
// The Custom Cell Selector,  also Sets Label to what is in the SnappleListArray
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        
        let cell: SnapplesTopicCell = tableView.dequeueReusableCell(withIdentifier: "customSnapplesTopicCell", for: indexPath) as! SnapplesTopicCell
        
// border of the cell
        cell.backgroundContentView.layer.cornerRadius = 5
        cell.backgroundContentView.layer.borderWidth = 1
        cell.backgroundContentView.layer.borderColor = UIColor.lightGray.cgColor
// sets title of snapple
        cell.snappleButtonOutlet.setTitle(snapplesList[indexPath.row], for: UIControlState.normal)
// rotates the smileys
        cell.likeButtonOutlet.transform = CGAffineTransform(a: 3.06161699786838e-16, b: 1.0, c: -1.0, d: 3.06161699786838e-16, tx: 0.0, ty: 0.0)
        cell.dislikeButtonOutlet.transform = CGAffineTransform(a: 3.06161699786838e-16, b: 1.0, c: -1.0, d: 3.06161699786838e-16, tx: 0.0, ty: 0.0)
    
// keeps tracks of elements based on whether user has already liked or not
        cell.dislikeButtonOutlet.tag = indexPath.row
        cell.dislikeButtonOutlet.addTarget(self, action: #selector((dislikeButtonTapped)), for: .touchUpInside)
        cell.likeButtonOutlet.tag = indexPath.row
        cell.likeButtonOutlet.addTarget(self, action: #selector((likeButtonTapped)), for: .touchUpInside)
        
        if mutatedLikedorNot[indexPath.row] == "false" {
            cell.likeButtonOutlet.isHidden = false
            cell.dislikeButtonOutlet.isHidden = false
            cell.cameraButtonOutlet.isHidden = true
            cell.snappleButtonOutlet.isEnabled = false
            cell.likePercentageOutlet.isHidden = true
            let strBase64 = "iVBORw0KGgoAAAANSUhEUgAAAAkAAAADCAYAAABBCiV2AAAAHklEQVQYV2NkIAIw/mdg+M/IwMCIS63BcS6QPGEAAN5tBASbolLVAAAAAElFTkSuQmCC"
            let dataDecoded : Data = Data(base64Encoded: strBase64, options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: dataDecoded)
            cell.backgroundImageView.image = decodedimage
        }
        else {
            cell.likeButtonOutlet.isHidden = true
            cell.dislikeButtonOutlet.isHidden = true
            cell.cameraButtonOutlet.isHidden = false
            cell.snappleButtonOutlet.isEnabled = true
            cell.likePercentageOutlet.isHidden = false
            cell.backgroundImageView.image = nil
            cell.likePercentageOutlet.text = "95%"
        }
// If a snappleTopic is clicked:
        cell.snappleButtonOutlet.addTarget(self, action: #selector((snappleTopicButtonTapped)), for: .touchUpInside)
        
        return cell
    }
    @objc func snappleTopicButtonTapped(sender: UIButton){
        let snapplesUserView : SnapplesUserView = SnapplesUserView(nibName: "SnapplesUserView", bundle: nil)
        self.addChildViewController(snapplesUserView)
        self.snapplesTableView.addSubview(snapplesUserView.view)
        snapplesUserView.snapplesTableView.frame = self.snapplesTableView.frame
    }

    @objc func dislikeButtonTapped(sender: UIButton){
        mutatedLikedorNot[sender.tag] = "true"
        UserDefaults.standard.set(mutatedLikedorNot, forKey: "mutatedLikedorNot")
        
    }
    @objc func likeButtonTapped(sender: UIButton){
        mutatedLikedorNot[sender.tag] = "true"
        UserDefaults.standard.set(mutatedLikedorNot, forKey: "mutatedLikedorNot")
    }
    
}
// A Custom UITableView Cell for Snapple Words
class SnapplesTopicCell: UITableViewCell {
    
    // Variable that will contain background color of cell
    @IBOutlet var backgroundContentView: UIView!
    
    @IBOutlet var backgroundImageView: UIImageView!
    // Has to do with likes and dislikes
    @IBOutlet var likeButtonOutlet: UIButton!
    @IBOutlet var dislikeButtonOutlet: UIButton!
    @IBOutlet var likePercentageOutlet: UILabel!
    @IBAction func likeSnappleWord(_ sender: UIButton) {
        likeButtonOutlet.isHidden = true
        dislikeButtonOutlet.isHidden = true
        cameraButtonOutlet.isHidden = false
        snappleButtonOutlet.isEnabled = true
        likePercentageOutlet.text = "100"
        likePercentageOutlet.isHidden = false
        backgroundImageView.image = nil
        
        //Maybe where I should make my first post to update and snappleword was liked
        //Also maybe where I should use a get so I can show a like percentage
    }
    @IBAction func dislikeSnappleWord(_ sender: UIButton) {
        likeButtonOutlet.isHidden = true
        dislikeButtonOutlet.isHidden = true
        cameraButtonOutlet.isHidden = false
        snappleButtonOutlet.isEnabled = true
        likePercentageOutlet.text = "100%"
        likePercentageOutlet.isHidden = false
        backgroundImageView.image = nil
        
        //Maybe where I should make my first post to update and snappleword was liked
        //Also maybe where I should use a get so I can show a like percentage
    }
    
    // What happens when the snapple button and camera button are enabled
    @IBAction func snappleButton(_ sender: UIButton) {

    }
    @IBAction func cameraButton(_ sender: UIButton) {

    }
    @IBOutlet var snappleButtonOutlet: UIButton!
    @IBOutlet var cameraButtonOutlet: UIButton!
}
