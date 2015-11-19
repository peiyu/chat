//
//  LoginViewViewController.swift
//  chat
//
//  Created by Peiyu Liu on 11/18/15.
//  Copyright © 2015 Peiyu Liu. All rights reserved.
//

import UIKit
import Parse

class LoginViewViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!

    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didPressLogin(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!) { (user: PFUser?   , error: NSError?) -> Void in
            if error == nil{
                self.performSegueWithIdentifier("loginSegue", sender: self)
                print("correct")
            }else{
                print("error: \(error)")}
        }
    }

    @IBAction func didPressSignUp(sender: AnyObject) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackgroundWithBlock { (status: Bool, error: NSError?) -> Void in
            
            if error == nil{
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                print("error:\(error)")
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
