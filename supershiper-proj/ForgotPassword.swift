//
//  ForgotPassword.swift
//  supershiper
//
//  Created by admin on 9/28/16.
//  Copyright © 2016 HITDEV. All rights reserved.
//


import UIKit
import Firebase
class ForgotPassword: UIViewController {

     @IBOutlet weak var currentEmail: UITextField!
    @IBAction func verifyUser(sender: AnyObject) {
        let user = FIRAuth.auth()?.currentUser
        
        user?.sendEmailVerificationWithCompletion() { error in
            if let error = error {
                // An error happened.
            } else {
//                user?.sendEmailVerificationWithCompletion(String(currentEmail.text))
            }
        }
    }
   
    
}
