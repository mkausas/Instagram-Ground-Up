//
//  LoginViewController.swift
//  Instagram
//
//  Created by Martynas Kausas on 2/23/16.
//  Copyright © 2016 martykausas. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var errorAlertController: UIAlertController?
    var alertOkAction: UIAlertAction?
    
    var automaticLogin = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attemptLogin()
        
        alertOkAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)

        // Do any additional setup after loading the view.
    }
    
    func attemptLogin() {
        if automaticLogin {
            let prefs = NSUserDefaults.standardUserDefaults()
            if let userDetails = prefs.objectForKey("user") as? [String] {
                PFUser.logInWithUsernameInBackground(userDetails[0], password: userDetails[1], block: { (user: PFUser?, error: NSError?) -> Void in
                    self.performSegueWithIdentifier("loginSegue", sender: nil)
                    
                })
            }
        } else {
            automaticLogin = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayErrorAlertView(title: String, message: String) {
        errorAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        errorAlertController?.addAction(alertOkAction!)
        
        self.presentViewController(errorAlertController!, animated: true, completion: nil)
        
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: NSError?) -> Void in
            if error == nil {
                print("Successfully logged in!")
                
                let userDetails: [String] = [self.usernameField.text!, self.passwordField.text!]
                
                // save user for immediate login
                let prefs = NSUserDefaults.standardUserDefaults()
                prefs.setObject(userDetails, forKey: "user") //  forKey: PFUser.currentUser()?.password
//                prefs.setObject(PFUser.currentUser()?.password, forKey: "password") //  forKey: PFUser.currentUser()?.password
                NSUserDefaults.standardUserDefaults().synchronize()

                self.performSegueWithIdentifier("loginSegue", sender: nil)

            } else {
                self.displayErrorAlertView("Login Error", message: (error?.description)!)
            }
        }
        
    }
    
    func validateInput() -> Bool {
        return usernameField.text?.isEmpty == false && passwordField.text?.isEmpty == false
    }
    
    
    @IBAction func signUpAction(sender: AnyObject) {
        let user = PFUser()
        
        // check for non-empty strings
        if validateInput() {
        
            user.username = usernameField.text
            user.password = passwordField.text
            
            user.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                if success {
                    print("created account")
                }
                
                else {
                    self.displayErrorAlertView("Signup Error", message: (error?.description)!)
                }
            }
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
