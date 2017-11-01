//
//  ViewController.swift
//  Snapples
//
//  Created by Michael Johnston on 8/20/16.
//  Copyright © 2016 Snapples. All rights reserved.
//
// IMPORTANT NOTES
// 1) logout button and how to fill and handle it
// 2) What to do if fb id changes or {\"detail\":\"Not found.\"} changes
// 3) If database isnt connected.. app will still load views.. what are the consequences?

import UIKit
//import Alamofire
//import SwiftyJSON

class ViewController:  UIViewController {
    
    @IBOutlet var SnapplesMain: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loggedIn()
    }

    //This function hides the login button view and creates the view of the world.
    func loggedIn(){
        print("LoggedIn: User is logged in,  now displaying world!")
        
        let interfaceView : InterfaceView = InterfaceView(nibName: "InterfaceView", bundle: nil)
        self.addChildViewController(interfaceView)
        self.SnapplesMain.addSubview(interfaceView.view)
        interfaceView.view.frame = SnapplesMain.frame
        
        
        
        //self.SnapplesMain.removeFromSuperview()
        //print("removed")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
