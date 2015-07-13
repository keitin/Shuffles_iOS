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
    
    class func fetchTweets(group: Group, page: Int, callBack: () -> Void) {
        
        var params: [String: AnyObject] = [
            "name": group.name,
            "password": group.password,
            "page": page
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

                let page = JSON!["page"] as! Int
                if page == 1 {
                    StockTweets.sharedInstance.tweets = []
                }
                let tweets = JSON?["tweets"] as! Array<AnyObject>
                
                for tweet in tweets {
                    var myTweet = Tweet()
                    myTweet.text = tweet["text"] as! String
                    
                    var user = User()
                    user.name = tweet["user_name"] as! String
                    
                    var fakeUser = User()
                    fakeUser.name = tweet["fake_user_name"] as! String
                    
                    let fakeImageDic = tweet["fake_user_avatar"] as! Dictionary<String, AnyObject>
                    let fakeImageAvatar = fakeImageDic["avatar"] as! Dictionary<String, AnyObject>
                    
                    if let fakeImageURL = fakeImageAvatar["url"] as? String {
                        let fakeImage = UIImage.convertToUIImageFromImagePass(fakeImageURL)
                        fakeUser.image = fakeImage
                    }
                    
                    if let imageURL = tweet["avatar"] as? String {
                   
                        let image = UIImage.convertToUIImageFromImagePass(imageURL)
                        user.image = image
                    }
                    
                    let time = tweet["time"] as! String
                    let timeDate = NSDate.convertToNSDate(time)
                    let timeString = timeDate.timeAgoInWords()
                    myTweet.time = timeString

                    user.fakeUser = fakeUser
                    myTweet.user = user
                    StockTweets.sharedInstance.tweets.append(myTweet)
                }
                callBack()
        }
    }
    
    class func saveTweet(tweet: Tweet, group: Group, currentUser: CurrentUser, callBack: () -> Void ){
        
        var params: [String: AnyObject] = [
            "text": tweet.text,
            "name": group.name,
            "password": group.password,
            "auth_token": currentUser.authToken!
        ]
        
        Alamofire.request(.POST, "http://localhost:3001/api/tweets",parameters: params, encoding: .URL)
            .responseJSON { (request, response, JSON, error) in
                
            callBack()
        }
    }
    
}
