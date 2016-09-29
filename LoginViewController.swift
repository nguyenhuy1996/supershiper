//
//  LoginViewController.swift
//  supershiper
//
//  Created by admin on 9/21/16.
//  Copyright © 2016 HITDEV. All rights reserved.
//

import UIKit
import Firebase


class LoginViewController: UIViewController {

    
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       initField()
        FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            if let user = user {
                print( user.email)
                self.hanleLogin()
            } else {
                // No user is signed in.
            }
        }
        let name =  FIRAuth.auth()?.currentUser?.email
        print()
        print(name)
    }
    func  initField()  {
        userField.text! = ""
        passwordField.text! = ""
    }
    func GetCurrentuser() {
        FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            if let user = user {
              
            } else {
                // No user is signed in.
            }
        }
    }
    @IBAction func dangnhap(sender: AnyObject) {
        hanleLogin()
    }

    @IBAction func quenmatkhau(sender: AnyObject) {
    }
    @IBAction func dangky(sender: AnyObject) {
    }
    
    func loadViewController()
    {
        let revealViewController = self.storyboard?.instantiateViewControllerWithIdentifier("revealVC") as! SWRevealViewController

        
        self.presentViewController(revealViewController, animated: true, completion: nil)
    }
    func  hanleLogin() {
        var revealViewController = self.storyboard?.instantiateViewControllerWithIdentifier("revealVC")
        self.presentViewController(revealViewController!, animated: true, completion: nil)
    }


}
