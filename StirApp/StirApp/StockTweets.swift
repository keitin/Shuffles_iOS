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
    var groupTweets: Array<Dictionary<String, AnyObject>> = []
    
    func login() {

        Alamofire.request(.GET, "http://localhost:3000/users/sign_in",parameters: nil, encoding: .JSON)
            .responseJSON { (request, response, JSON, error) in
                println("=====================")
                println(request)
                println("=====================")
                println(response)
                println("=====================")
                println(JSON)
                println("=====================")
                println(error)
                println("=====================")
        }
        
    }
    
}
