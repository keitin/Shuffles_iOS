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
    class func saveGroup(group: Group, callback: () -> Void) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let auth_token = defaults.objectForKey("authToken") as! String
        
        var params: [String: AnyObject] = [
            "name": group.name,
            "password": group.password,
            "auth_token": auth_token,
        ]
        
                        //Extension
        let httpMethod = Alamofire.Method.POST.rawValue
        let pass = "http://localhost:3001/api/groups/"
        let urlRequest = NSData.urlRequestWithComponents(httpMethod, urlString: pass, parameters: params, image: group.image!)
        
        Alamofire.upload(urlRequest.0, urlRequest.1)
            .progress { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in

            }
            .responseJSON { (request, response, JSON, error) in
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
                
                if error == nil {

                    var groups = JSON?["groups"] as! Array<AnyObject>
                    
                    StockGroup.sharedInstance.myGroups = []
                    for myGroup in groups {
                        var group = Group()
                        group.name = myGroup["name"] as! String
                        group.password = myGroup["password"] as! String
                        group.lastMessage = myGroup["last_message"] as! String
                        let avatar =  myGroup["avatar"]! as! Dictionary<String, AnyObject>
                        let urlKey = avatar["avatar"] as! Dictionary<String, AnyObject>
                        if let imageURL = urlKey["url"] as? String {
                            let imageLink = "http://localhost:3001" + imageURL
                            let url = NSURL(string: imageLink)
                            let imageData = NSData(contentsOfURL: url!)
                            group.image = UIImage(data: imageData!)
                            println(group.name)
                            println(imageLink)
                            println(group.image)
                        }

                        StockGroup.sharedInstance.myGroups.insert(group, atIndex: 0)
                    }
                    
                }
                callback()
        }
    }
    
    
    class func searchGroup(group: Group, callback: (Dictionary<String, AnyObject>) -> Void) {
        
        var params: [String: AnyObject] = [
            "name": group.name,
            "password": group.password
        ]
        
        var returnParams: Dictionary<String, AnyObject> = [:]
        
        Alamofire.request(.GET, "http://localhost:3001/api/groups/search",parameters: params, encoding: .URL)
            .responseJSON { (request, response, JSON, error) in
                
                if error == nil {
                    println(JSON!["group_name"])
                    returnParams["groupName"] = JSON?["group_name"] as! String
                    returnParams["groupPass"] = JSON?["group_pass"] as! String
                }
                
                callback(returnParams)
        }
        
    }

    
    class func addGroup(group: Group, callback: () -> Void) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let auth_token = defaults.objectForKey("authToken") as! String
        
        var params: [String: AnyObject] = [
            "auth_token": auth_token,
            "name": group.name,
            "password": group.password
        ]
     
        Alamofire.request(.GET, "http://localhost:3001/api/groups/add_group",parameters: params, encoding: .URL)
            .responseJSON { (request, response, JSON, error) in
                
            callback()
        }
    }
    
    
    
    
}
