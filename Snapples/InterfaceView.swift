//
//  SnapplesMainView.swift
//  Snapples
//
//  Created by Michael Johnston on 8/2/17.
//  Copyright © 2017 Snapples. All rights reserved.
//

import UIKit

class InterfaceView: UIViewController {
// Properties
  // View Sized to fit on the Interface
    @IBOutlet var snapplesView: UIView!
    @IBOutlet var snapplesInterfaceTableView: UIView!

//
    @IBOutlet var snapplesButton: UIButton!
    @IBOutlet var snappleTreeButton: UIButton!
    @IBOutlet var snappleTreeView: UIView!
    @IBOutlet var messagesButton: UIButton!
    @IBOutlet var profileButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
// Customized settings for interface
        let cr = CGFloat(10)
        snapplesButton.layer.cornerRadius = cr
        snapplesButton.layer.borderWidth = 1
        snapplesButton.layer.borderColor = UIColor.white.cgColor
        snappleTreeButton.layer.cornerRadius = cr
        snappleTreeButton.titleLabel?.textAlignment = NSTextAlignment.center
        snappleTreeButton.layer.borderWidth = 1
        snappleTreeButton.layer.borderColor = UIColor.white.cgColor
        messagesButton.layer.cornerRadius = cr
        messagesButton.layer.borderWidth = 1
        messagesButton.layer.borderColor = UIColor.white.cgColor
        profileButton.layer.cornerRadius = cr
        profileButton.layer.borderWidth = 1
        profileButton.layer.borderColor = UIColor.white.cgColor
// Load SnapplesTopicView into interface for default
        let snapplesTopicView : SnapplesTopicView = SnapplesTopicView(nibName: "SnapplesTopicView", bundle: nil)
        self.addChildViewController(snapplesTopicView)
        self.snapplesInterfaceTableView.addSubview(snapplesTopicView.view)
        snapplesTopicView.snapplesTableView.frame = self.snapplesInterfaceTableView.frame
// Load CameraButtonView to replace interface
        var index = 0
        let indexMax = 15
        
        while index < indexMax {
        let indexPath = NSIndexPath(row: index, section: 0)
        let cell = snapplesTopicView.tableView(snapplesTopicView.snapplesTable, cellForRowAt: indexPath as IndexPath) as! SnapplesTopicCell
        cell.cameraButtonOutlet.addTarget(self, action: #selector((cameraButtonTapped)), for: .touchUpInside)
            cell.tag = index
            index += 1
        }
        
        //snapplesTopicView.snapplesTable.cellForRow(at: <#T##IndexPath#>)
        //cameraButtonInstanceinTopicView.addTarget(self, action: #selector((cameraButtonTapped)), for: .touchUpInside)
        
        
    }
    @objc func cameraButtonTapped(sender: UIButton){
        let cameraView : CameraView = CameraView(nibName: "CameraView", bundle: nil)
        self.addChildViewController(cameraView)
        self.snapplesView.addSubview(cameraView.view)
        cameraView.view.frame = snapplesView.frame
    }
    
    @IBAction func snapplesButton(_ sender: UIButton) {
        

    }
    @IBAction func snappleTreeButton(_ sender: UIButton) {
        
        
    }
    @IBAction func messagesButton(_ sender: UIButton) {
        
        
    }
    @IBAction func profileButton(_ sender: UIButton) {
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

    

