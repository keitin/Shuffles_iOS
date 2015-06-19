//
//  Group.swift
//  StirApp
//
//  Created by 松下慶大 on 2015/06/17.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit
import Alamofire

class Group: NSObject {
    var name = ""
    var password = ""
    
    class func searchGroup(groupNmae: String, groupPass: String, callback: (Dictionary<String, AnyObject>) -> Void) {
        
        var params: [String: AnyObject] = [
            "name": groupNmae,
            "password": groupPass
        ]
        
        var returnParams: Dictionary<String, AnyObject> = [:]
        
        Alamofire.request(.GET, "http://localhost:3001/api/groups/search",parameters: params, encoding: .URL)
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
                    println(JSON!["group_name"])
                    returnParams["groupName"] = JSON?["group_name"] as! String
                    println(returnParams["groupName"])
                }
                
                callback(returnParams)
                
        }
        
    }
    
}
