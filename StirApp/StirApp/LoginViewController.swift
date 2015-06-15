//
//  LoginViewController.swift
//  StirApp
//
//  Created by 松下慶大 on 2015/06/13.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var confirmPassTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var emailTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        println("======authToken in NSUserFefaults=========")
        println(defaults.objectForKey("authToken"))
        println("======authToken in NSUserFefaults=========")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func tapLoginButton(sender: UIButton) {
        
        var email = emailTextField.text
        var pass = passwordTextFiled.text
        var confirmPass = confirmPassTextFiled.text
        
        var callbackClosure1 = { (params: Dictionary<String, AnyObject>) -> Void in
            
            var errorMessages = params["error_message"] as! Array<AnyObject>
            
            if errorMessages.isEmpty {
                println("登録成功")
                self.performSegueWithIdentifier("showTimeLineViewController", sender: nil)
            } else {
                println("登録失敗")
                println(errorMessages)
            }
        }
        
        SessionUser.login(email, pass: pass, confirmPass: confirmPass, callBackClosure: callbackClosure1)

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
