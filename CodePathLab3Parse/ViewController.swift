//
//  ViewController.swift
//  CodePathLab3Parse
//
//  Created by Steffan Chartrand on 2/18/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        PFUser.logInWithUsernameInBackground("jamietsao@gmail.com", password: "123456") {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                NSLog("Login Successful: \(user)")
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                NSLog("Login Failed!")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSignIn(sender: AnyObject) {
        let email = self.emailTextField.text
        let password = self.passwordTextField.text
        PFUser.logInWithUsernameInBackground(email, password: password) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                NSLog("Login Successful: \(user)")
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                NSLog("Login Failed!")
            }
        }
    }
    
    @IBAction func onSignUp(sender: AnyObject) {
        
        var user = PFUser()
        user.username = emailTextField.text
        user.password = passwordTextField.text
        user.email = emailTextField.text
        // other fields can be set just like with PFObject
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            if error == nil {
                NSLog("Sign Up Successful!")
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                let errorString = error.userInfo!["error"] as NSString
                // Show the errorString somewhere and let the user try again.
                NSLog("Sign Up Failed: \(errorString)")
            }
        }
    }
}

