//
//  StockTweets.swift
//  StirApp
//
//  Created by 松下慶大 on 2015/06/13.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit
import Alamofire

class StockTweets: NSObject {
   
    static let sharedInstance = StockTweets()
    var tweets: Array<Tweet> = []
    
    class func fetchTweets(currentUser: CurrentUser, group: Group) {
        
        var params: [String: AnyObject] = [
            "group_name": group.name,
            "group_pass": group.password,
            "auth_token": currentUser.authToken!
        ]
    
        Alamofire.request(.GET, "http://localhost:3001/api/tweets",parameters: params, encoding: .URL)
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
                
                
                
        }
    }
    
}
