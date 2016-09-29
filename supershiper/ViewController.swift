//
//  ViewController.swift
//  supershiper
//
//  Created by admin on 9/20/16.
//  Copyright © 2016 HITDEV. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Firebase

class ViewController: UIViewController {

    let usersRef = FIRAuth.auth()?.currentUser
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var placesClient: GMSPlacesClient?
    
    
    var mAuth: FIRAuth?
    var mCurrentUserId: String?
    var mCurrentUserEmail: String?
    
    var rootRef: FIRDatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        //---------------------------------------------------------------------
        let camera = GMSCameraPosition.cameraWithLatitude(1.285, longitude: 103.848, zoom: 15)
        
        let mapView = GMSMapView.mapWithFrame(CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 50 ), camera: camera)
        mapView.myLocationEnabled = true
        self.view.addSubview(mapView)
        // Do any additional setup after loading the view, typically from a nib.
        
        placesClient = GMSPlacesClient.sharedClient()
        
        placesClient?.currentPlaceWithCallback({
            (placeLikelihoodList: GMSPlaceLikelihoodList?, error: NSError?) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            if let placeLikelihoodList = placeLikelihoodList {
                let place = placeLikelihoodList.likelihoods.first?.place
                if let place = place {
                    let camera = GMSCameraPosition.cameraWithLatitude(place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 15)
                    mapView.camera = camera
                }
            }
        })
        
        FIRAuth.auth()!.addAuthStateDidChangeListener { (auth, user) in
            self.mAuth = auth
            self.mCurrentUserId = user?.uid
            self.mCurrentUserEmail = user?.email
            
            self.rootRef = FIRDatabase.database().reference()
            let connectionStatusRef = self.rootRef?.child("users").child(self.mCurrentUserId!).child("connection")
            
            self.rootRef?.root.child(".info/connected").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                let connected = snapshot.value as? Bool
                if connected == true {
                    connectionStatusRef?.setValue("online")
                    connectionStatusRef?.onDisconnectSetValue("offline")
                    
                    print("Connected to Firebase")
                } else {
                    print("Disconnected from firebase")
                }
            })
        func UpdateStateOnline()
            {
                
        self.rootRef?.child("users").child((user?.uid)!).setValue(["connection": "online"])
            }

            
            self.rootRef?.child("users").observeEventType(.ChildAdded, withBlock: { (snapshot) in
                if snapshot.exists() {
                    let userInfo = snapshot.value as! [String: AnyObject]
                    print(userInfo["email"])
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

