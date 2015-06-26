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
    class func saveGroup(name: String, password: String, image: UIImage, callback: () -> Void) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let auth_token = defaults.objectForKey("authToken") as! String
        
        let imageData = UIImagePNGRepresentation(image)
        var array: NSArray = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)
        
        println(array)
        var cacheDirPath: NSString = array.objectAtIndex(0) as! NSString
        var filePath: String = cacheDirPath.stringByAppendingPathComponent("tmp.png")
        
        var isSaved = imageData.writeToFile(filePath as String, atomically: true)
        
        println(isSaved)
        
        let fileURL = NSURL(fileURLWithPath: filePath)
        println(fileURL)
        
        var params: [String: AnyObject] = [
            "name": name,
            "password": password,
            "auth_token": auth_token
        ]
        
        
        Alamofire.request(.POST, "http://localhost:3001/api/groups", parameters: params, encoding: .URL)
            .responseJSON { (request, response, JSON, error) in
                
                println("========request=============")
                println(request)
                println("========response============")
                println(response)
                println("========JSON===========")
                println(JSON)
                println("========error===========")
                println(error)
                println("=====================")
                
                callback()
        }
        
        
        
//        let imageData = UIImagePNGRepresentation(image)
//        var array: NSArray = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)
//        
//        println(array)
//        var cacheDirPath: NSString = array.objectAtIndex(0) as! NSString
//        var filePath: String = cacheDirPath.stringByAppendingPathComponent("tmp.png")
//
//        var isSaved = imageData.writeToFile(filePath as String, atomically: true)
//        
//        println(isSaved)
//        
////        let fileURL = NSBundle.mainBundle().URLForResource("tmp", withExtension: "png")
//        let fileURL = NSURL(fileURLWithPath: filePath)
//        println(fileURL)
        
//        Alamofire.upload(.POST, "http://localhost:3001/api/groups", fileURL!)
//            .responseJSON { (request, response, JSON, error) in
//
//                println("========request=============")
//                println(request)
//                println("========response============")
//                println(response)
//                println("========JSON===========")
//                println(JSON)
//                println("========error===========")
//                println(error)
//                println("=====================")
//                
//        }

        
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
                        group.password = myGroup["password"] as! String
                        StockGroup.sharedInstance.myGroups.insert(group, atIndex: 0)
                    }
                    
                }
                callback()
        }
    }
    
    
    class func addGroup(groupName: String, groupPass: String, callback: () -> Void) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let auth_token = defaults.objectForKey("authToken") as! String
        
        var params: [String: AnyObject] = [
            "auth_token": auth_token,
            "name": groupName,
            "password": groupPass
        ]
     
        Alamofire.request(.GET, "http://localhost:3001/api/groups/add_group",parameters: params, encoding: .URL)
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
    
    
    
    
}
