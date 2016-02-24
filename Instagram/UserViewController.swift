//
//  UserViewController.swift
//  Instagram
//
//  Created by Martynas Kausas on 2/23/16.
//  Copyright © 2016 martykausas. All rights reserved.
//

import UIKit
import Parse

class UserViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignoutAction(sender: AnyObject) {
        PFUser.logOutInBackground()
        performSegueWithIdentifier("logoutSegue", sender: nil)
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let vc = segue.destinationViewController
        
        if let vc = vc as? LoginViewController {
            vc.automaticLogin = false
            print("this shit is happening")
        }
        
    }
    

}
