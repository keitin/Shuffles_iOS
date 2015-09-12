//
//  LoginViewController.swift
//  StirApp
//
//  Created by 松下慶大 on 2015/06/13.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var siginUpButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var confirmPassTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextFiled.delegate = self
        confirmPassTextFiled.delegate = self
        passwordTextFiled.delegate = self
        emailTextField.delegate = self
        
        setSignupButton()
        
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        errorMessageLabel.text = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log in?", style: UIBarButtonItemStyle.Plain, target: self, action: "showLoginPage")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        // NSNotificationCenterの解除処理
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    

    @IBAction func tapLoginButton(sender: UIButton) {
        
        let user = User()
        user.name = nameTextFiled.text
        user.email = emailTextField.text
        user.password = passwordTextFiled.text
        user.confirmPassword = confirmPassTextFiled.text
        
        var callback = { (params: Dictionary<String, AnyObject>) -> Void in
            
            var errorMessages = params["error_message"] as! Array<AnyObject>
            
            if errorMessages.isEmpty {
                self.performSegueWithIdentifier("segueToTimeLineTabBarController", sender: nil)
            } else {
                var str = ""
                for messaege in errorMessages {
                    str += messaege as! String
                }
    
                self.errorMessageLabel.text = str
                self.showAlert(str)
    
            }
        }
        
        SessionUser.signUp(user, callBackClosure: callback)

    }
    
    
    func showLoginPage() {
        self.tabBarController?.selectedIndex = 0
    }
    
    //キーボードのreturnが押された際にキーボードを閉じる処理
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        nameTextFiled.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextFiled.resignFirstResponder()
        confirmPassTextFiled.resignFirstResponder()
        //        itemMemo.resignFirstResponder()
        return true
    }
    
    func setSignupButton() {
        siginUpButton.layer.cornerRadius = 5
        siginUpButton.layer.masksToBounds = true
        siginUpButton.backgroundColor = UIColor.subColor()
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
