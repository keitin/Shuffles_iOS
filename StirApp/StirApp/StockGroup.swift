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
    
    class func saveGroup(name: String, password: String, callback: () -> Void) {
        
        var params: [String: AnyObject] = [
            "name": name,
            "password": password
            
        ]
        
        Alamofire.request(.POST, "http://localhost:3001/api/groups",parameters: params, encoding: .URL)
            //        Alamofire.request(.POST, "http://matsushitakeidai-no-MacBook-Pro.local:3000/api/users",parameters: params, encoding: .URL)
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
