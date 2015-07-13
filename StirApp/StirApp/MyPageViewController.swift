//
//  MyPageViewController.swift
//  StirApp
//
//  Created by 松下慶大 on 2015/07/13.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController {
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!

    var currentUser = CurrentUser.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
        
        let callBack = { () -> Void in
            self.currentUser = CurrentUser.sharedInstance
            self.myImageView.image = self.currentUser.image
            self.myLabel.text = self.currentUser.name
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
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
