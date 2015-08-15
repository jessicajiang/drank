//
//  ViewController.swift
//  Drank
//
//  Created by Jessica Jiang on 8/13/15.
//  Copyright (c) 2015 Jessica Jiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    var fbButton:FBSDKLoginButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newFBButton = FBSDKLoginButton()
        newFBButton.delegate = self
        fbButton = newFBButton
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginPressed(sender: AnyObject) {
        fbButton?.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        println("i'm pressed")
    }

    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
    
        println(result)
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("logout")
    }
}

