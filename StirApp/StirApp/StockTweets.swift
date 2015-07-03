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
    
    class func fetchTweets(group: Group, callBack: () -> Void) {
        
        var params: [String: AnyObject] = [
            "name": group.name,
            "password": group.password
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

                StockTweets.sharedInstance.tweets = []
                let tweets = JSON?["tweets"] as! Array<AnyObject>
                
                for tweet in tweets {
                    var myTweet = Tweet()
                    myTweet.text = tweet["text"] as! String
                    
                    var user = User()
                    user.name = tweet["user_name"] as! String
                    var fakeUser = User()
                    fakeUser.name = tweet["fake_user_name"] as! String
                    user.fakeUser = fakeUser
                    myTweet.user = user
                    StockTweets.sharedInstance.tweets.insert(myTweet, atIndex: 0)
                }
                callBack()
        }
    }
    
    class func saveTweet(tweet: Tweet, group: Group, currentUser: CurrentUser, callBack: () -> Void ){
        
        var params: [String: AnyObject] = [
            "text": tweet.text,
            "group_name": group.name,
            "group_pass": group.password,
            "auth_token": currentUser.authToken!
        ]
        
        Alamofire.request(.POST, "http://localhost:3001/api/tweets",parameters: params, encoding: .URL)
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
                
                callBack()
                
        }

        
    }
    
}
