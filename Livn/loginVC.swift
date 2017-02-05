//
//  loginView.swift
//  Livn
//
//  Created by Brylan Donaldson on 2/1/17.
//  Copyright © 2017 LivnInc. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import FirebaseAuth
import Firebase

class loginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Create and position login button. Must add FBSDKCoreKit and FBSDKLoginKit.
        let loginButton = FBSDKLoginButton()
        var position = CGRect(x: 90, y: 500, width: 200, height: 50)
        loginButton.frame = (position)
        view.addSubview(loginButton)
        
        /*Establishes the login button's delegate as the view controller since the FBSDKLoginButtonDelegate is passed to the view controller. Also,
         sets the login button's read permissions, allowing it to access the email of the user.*/
        loginButton.delegate = self
        loginButton.readPermissions = ["email"]
    }
    
    //This method controls whether or not the user is logged in once the button is clicked.
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        //Stores the current user's access token in a variable
        let accessTokenString = FBSDKAccessToken.current().tokenString
        
        //Stores users credentials inside a variable that consists of the access token that was created by Facebook
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessTokenString!)
        
        //This method allows Firebase to authenticate the user and sign the user in
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            
            if error != nil {
                print(error)
                return
            }
        })
        
        if error != nil {
            print(error)
            return
        }
        else {
            self.performSegue(withIdentifier: "goToExpenseView", sender: self)
        }
        
    }
    
    //This method signs the user out using Firebase
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("did log out of Facebook")
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        print("Logged out")
    }
    
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    
}

