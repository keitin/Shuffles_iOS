//
//  SignUpViewController.swift
//  StirApp
//
//  Created by 松下慶大 on 2015/06/15.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var passTextFiled: UITextField!
    @IBOutlet weak var emailTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        errorMessageLabel.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func tapLoginButton(sender: UIButton) {
        
        var email = emailTextField.text
        var pass = passTextFiled.text
        
        var callbackClosure = { (params: Dictionary<String, AnyObject>) -> Void in
            
//            var errorMessages = params["error_message"] as! Array<AnyObject>
            
            if var errorMessages = params["error_message"] as? Array<AnyObject> {
//                println("登録成功")
//                self.dismissViewControllerAnimated(true, completion: nil)
                println("登録失敗")
                println(errorMessages)
                var str = ""
                for messaege in errorMessages {
                    str += messaege as! String
                }
                self.errorMessageLabel.text = str
            } else {
//                println("登録失敗")
//                println(errorMessages)
//                var str = ""
//                for messaege in errorMessages {
//                    str += messaege as! String
//                }
//                self.errorMessageLabel.text = str
                
                println("登録成功")
                self.dismissViewControllerAnimated(true, completion: nil)

                
            }
        }
        
        SessionUser.login(email, pass: pass, callBackClosure: callbackClosure)
    }
    

    @IBAction func showSignUpViewController(sender: UIButton) {
        self.tabBarController?.selectedIndex = 1
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
