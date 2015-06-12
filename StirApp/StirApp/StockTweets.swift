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
    
    func loadTweets() {
        let url = NSURL(string: "http://localhost:3000/api/chats.json")
        var request = NSMutableURLRequest(URL: url!)
        
        request.HTTPMethod = "GET"
        
        var task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, responce, error) -> Void in
            
            println("============")
            if (error == nil) {
                self.groupTweets.removeAll(keepCapacity: false)
//                var tweets = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! Array<Dictionary<String, AnyObject>>
//                println(tweets)
            }
            
        })
        task.resume()
    }
    
}
