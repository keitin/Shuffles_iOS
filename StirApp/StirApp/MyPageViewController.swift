//
//  MyPageViewController.swift
//  StirApp
//
//  Created by 松下慶大 on 2015/07/13.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController {
    @IBOutlet weak var myImageView: UIImageView!

    var currentUser = CurrentUser.sharedInstance
    let nameLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNameLabel()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
        
        let callBack = { () -> Void in
            self.currentUser = CurrentUser.sharedInstance
            self.myImageView.image = self.currentUser.image
            
            self.nameLabel.adjustsFontSizeToFitWidth = true
            self.nameLabel.text = self.currentUser.name
            
        }
        
        currentUser.fetchCurrentUser(callBack)
        currentUser = CurrentUser.fetchCurrentUserInUserDefaults()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    

    @IBAction func tapMenuButton(sender: UIButton) {
        showActionSheet()
    }

    
    
    func showActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        let editProfileAction = UIAlertAction(title: "Edit Profile", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.performSegueWithIdentifier("modalEditProfile", sender: nil)
        }
        let signoutAction = UIAlertAction(title: "Log Out", style: UIAlertActionStyle.Destructive) { (action) -> Void in
            CurrentUser.sharedInstance.removeAuthToken()
            let tabBarController = self.storyboard?.instantiateViewControllerWithIdentifier("LogInTabBarController") as! UITabBarController
            UIApplication.sharedApplication().keyWindow?.rootViewController = tabBarController
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        actionSheet.addAction(editProfileAction)
        actionSheet.addAction(signoutAction)
        actionSheet.addAction(cancelAction)
        presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func setNameLabel() {
        nameLabel.frame.size = CGSize(width: view.frame.width - 10, height: 42)
        nameLabel.center = CGPoint(x: view.center.x, y: view.center.y + 50)
        nameLabel.textAlignment = NSTextAlignment.Center
        nameLabel.font = UIFont(name: "HirakakuProN-W6", size: 42)
        nameLabel.textColor = UIColor.whiteColor()
        self.view.addSubview(nameLabel)
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
