//
//  CurrentUser.swift
//  StirApp
//
//  Created by 松下慶大 on 2015/06/14.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit

class CurrentUser: User {
    
    static let sharedInstance = CurrentUser()
    var authToken: AnyObject?
    
    
    func saveAuthToken() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(authToken, forKey: "authToken")
        defaults.synchronize()
    }
    
    func removeAuthToken() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("authToken")
        defaults.synchronize()
    }
    
    
    
   
}
