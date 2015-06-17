//
//  StockGroup.swift
//  StirApp
//
//  Created by 松下慶大 on 2015/06/17.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit
import Alamofire

class StockGroup: NSObject {
    
    static let sharedInstance = StockGroup()
    var myGroups: Array<Group> = []
    
    //HTTP通信
    class func saveGroup(name: String, password: String, callback: () -> Void) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let auth_token = defaults.objectForKey("authToken") as! String
        
        var params: [String: AnyObject] = [
            "name": name,
            "password": password,
            "auth_token": auth_token
        ]
        
        Alamofire.request(.POST, "http://localhost:3001/api/groups",parameters: params, encoding: .URL)
            .responseJSON { (request, response, JSON, error) in
                
                println("========request=============")
                println(request)
                println("=========response============")
                println(response)
                println("==========JSON===========")
                println(JSON)
                println("==========error===========")
                println(error)
                println("=====================")
                
                callback()
        }

    }
    
    class func fetchGroup(callback: () -> Void) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let auth_token = defaults.objectForKey("authToken") as! String

        var params: [String: AnyObject] = [
            "auth_token": auth_token
        ]
        
        Alamofire.request(.GET, "http://localhost:3001/api/groups",parameters: params, encoding: .URL)
            .responseJSON { (request, response, JSON, error) in
                
                println("========request=============")
                println(request)
                println("=========response============")
                println(response)
                println("==========JSON===========")
                println(JSON)
                println("==========error===========")
                println(error)
                println("=====================")
                
                if error == nil {

                    var groups = JSON?["groups"] as! Array<AnyObject>
 
                    StockGroup.sharedInstance.myGroups = []
                    for myGroup in groups {
                        var group = Group()
                        group.name = myGroup["name"] as! String
                        StockGroup.sharedInstance.myGroups.insert(group, atIndex: 0)
                    }
                    
                }
                callback()
        }
    }
    
    
    
    
}
