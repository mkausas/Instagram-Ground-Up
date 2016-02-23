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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertOkAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)

        // Do any additional setup after loading the view.
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
