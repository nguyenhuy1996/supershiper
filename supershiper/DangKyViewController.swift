//
//  DangKyViewController.swift
//  supershiper
//
//  Created by admin on 9/22/16.
//  Copyright © 2016 HITDEV. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
class DangKyViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
   
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var phoneNumber: UITextField!
    
    let Ref = FIRDatabase.database().reference()
    let user = FIRAuth.auth()?.currentUser

   
    override func viewDidLoad() {
        super.viewDidLoad()
       // initField()
    }
    func initField()  {
      
        username.text = ""
        password.text = ""
        repeatPassword.text =  ""
        name.text = ""
        phoneNumber.text = ""
    }

    @IBAction func taotaikhoanAction(sender: AnyObject) {
        let userName = self.username
        let password = self.password
        let repeatPassword = self.repeatPassword
        
        if userName.text! == "" || password.text! == "" || repeatPassword.text! == "" || name.text == "" || phoneNumber.text == ""
        {
            self.displayMyAlertMessage("Vui lòng điền đầy đủ thông tin")
        }
        else
        {
            if password.text != repeatPassword.text {
                self.displayMyAlertMessage("Mật khẩu không đúng")
            }
            else
            {
                
                FIRAuth.auth()?.createUserWithEmail(userName.text!, password: password.text!, completion: { (user, error) in
                    if(error == nil) {
                        let date = NSDate()
                           let currentTime = (date.timeIntervalSince1970*1000).description

                        let userInfo = [
                            "avatarId": "0",
                            "connection": "online",
                            "createdAt": currentTime,
                            "email": (user?.email)!,
                            "name": self.name.text!,
                            "phone": self.phoneNumber.text!,
                            "provider": (user?.providerID)!
                        ]
                          
                        self.Ref.child("users").child((user?.uid)!).setValue(userInfo)
                        self.handleRegister()
                    //    self.SetObjectToKey(userName.text!, currentTime: currentTime)
                        
                        self.displayMyAlertMessage("Dang ky thanh cong")
                        }
                    else
                    {
                        print(error?.description)
                        self.displayMyAlertMessage("Dang ky that bai")
                    }
                })
                
            }
        }
    }
    func  handleRegister()
    {
        
        let revealViewController = self.storyboard?.instantiateViewControllerWithIdentifier("revealVC") as! SWRevealViewController
        self.presentViewController(revealViewController, animated: true, completion: nil)
    }
    func SetObjectToKey(userName: String, currentTime: String )
    {
            NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "userName")
            NSUserDefaults.standardUserDefaults().setObject(password, forKey: "password")
    }
   
    func displayMyAlertMessage(userMessage: String)
        {
            let myAlert = UIAlertController(title: "Thông báo", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            self.presentViewController(myAlert, animated: true, completion: nil)
        }
    }


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    