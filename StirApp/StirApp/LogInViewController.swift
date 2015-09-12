//
//  SignUpViewController.swift
//  StirApp
//
//  Created by 松下慶大 on 2015/06/15.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var passTextFiled: UITextField!
    @IBOutlet weak var emailTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLoginButton()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        errorMessageLabel.text = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign up?", style: UIBarButtonItemStyle.Plain, target: self, action: "showSignUpViewController")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func tapLoginButton(sender: UIButton) {
        
        let user = User()
        user.email = emailTextField.text
        user.password = passTextFiled.text


        
        var callback = { (params: Dictionary<String, AnyObject>) -> Void in
            
            
            if var errorMessages = params["error_message"] as? Array<AnyObject> {
                var str = ""
                for messaege in errorMessages {
                    str += messaege as! String
                }
                self.errorMessageLabel.text = str
                self.showAlert(str)
            } else {
                self.performSegueWithIdentifier("segueToTimeLineTabBarController", sender: nil)
            }
        }

        SessionUser.login(user, callBackClosure: callback)
    }
    

    func showSignUpViewController() {
        self.tabBarController?.selectedIndex = 1
    }
    
    func setLoginButton() {
        loginButton.layer.cornerRadius = 5
        loginButton.layer.masksToBounds = true
        loginButton.backgroundColor = UIColor.subColor()
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
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
