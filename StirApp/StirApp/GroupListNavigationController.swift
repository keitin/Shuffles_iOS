//
//  GroupListNavigationController.swift
//  StirApp
//
//  Created by 松下慶大 on 2015/07/11.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit

class GroupListNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().barTintColor = UIColor.mainColor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
