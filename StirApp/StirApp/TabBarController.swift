//
//  TabBarController.swift
//  StirApp
//
//  Created by 松下慶大 on 2015/06/15.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().barTintColor = UIColor.whiteColor()
        UITabBar.appearance().translucent = false
        
        
        let groupImage = UIImage(named: "groupp")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let hiGoupImage = UIImage(named: "grouup")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let homeImage = UIImage(named: "homehome")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let hiHomeImage = UIImage(named: "hihihome")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let font = UIFont(name: "Helvetica", size: 10)!
        
        let firstViewController = self.viewControllers![0] as! UINavigationController
        let secondViewController = self.viewControllers![1] as! UIViewController
        
        firstViewController.tabBarItem = UITabBarItem(title: "Group", image: groupImage, selectedImage: hiGoupImage)
        secondViewController.tabBarItem = UITabBarItem(title: "My Page", image: homeImage, selectedImage: hiHomeImage)
        
        let normalAttributes: Dictionary! = [NSForegroundColorAttributeName: UIColor.originalGray()]
        let selectedAttributes: Dictionary! = [NSForegroundColorAttributeName: UIColor.mainColor()]
        
        UITabBarItem.appearance().setTitleTextAttributes(normalAttributes, forState: UIControlState.Normal)
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, forState: UIControlState.Selected)

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
