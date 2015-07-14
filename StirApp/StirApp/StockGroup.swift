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
        let path = String.localhost() + "/api/groups"
        let urlRequest = NSData.urlRequestWithComponents(httpMethod, urlString: path, parameters: params, image: group.image!)
        
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
        
        let path = String.localhost() + "/api/groups"
        Alamofire.request(.GET, path, parameters: params, encoding: .URL)
            .responseJSON { (request, response, JSON, error) in
                
                println("=====JSON=========")
                println(JSON)
                println("=====ERROR=========")
                println(error)
                
                
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
                            let imageLink = String.localhost() + imageURL
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
    
    
    class func searchGroup(group: Group, callback: (group: Group?) -> Void) {
        
        var params: [String: AnyObject] = [
            "name": group.name,
            "password": group.password
        ]
        
        let path = String.localhost() + "/api/groups/search"
        Alamofire.request(.GET, path, parameters: params, encoding: .URL)
            .responseJSON { (request, response, JSON, error) in
                
                var group: Group?
                
                if error == nil {
                    group = Group()
                    group!.name = JSON!["group_name"] as! String
                    group!.password = JSON!["group_pass"] as! String
                    let imageString = JSON!["group_image"] as! String
                    let image = UIImage.convertToUIImageFromImagePass(imageString)
                    group!.image = image
                }
                
                callback(group: group)
        }
        
    }

    
    class func addGroup(group: Group, callback: (errorMessage: String) -> Void) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let auth_token = defaults.objectForKey("authToken") as! String
        
        var params: [String: AnyObject] = [
            "auth_token": auth_token,
            "name": group.name,
            "password": group.password
        ]
     
        let path = String.localhost() + "/api/groups/add_group"
        Alamofire.request(.GET, path, parameters: params, encoding: .URL)
            .responseJSON { (request, response, JSON, error) in
                
                var errorMessage = ""
                
                if let error = JSON!["error"] as? String {
                    errorMessage = error
                }
                
                callback(errorMessage: errorMessage)
        }
    }
    
    
    
    
}
