//
//  FakeUsers.swift
//  StirApp
//
//  Created by 松下慶大 on 2015/06/29.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit
import Alamofire

class StockFakeUsers: NSObject {
    
    static let sharedInstance = StockFakeUsers()
    var fakeUsers: Array<Fake> = []
   
    class func addFake(fake: Fake) {
        StockFakeUsers.sharedInstance.fakeUsers.insert(fake, atIndex: 0)
    }
    
    class func fetchFakeUsers(group: Group, callback: () -> Void) {
        
        var params: [String: AnyObject] = [
            "name": group.name,
            "password": group.password
        ]
        
        Alamofire.request(.GET, "http://localhost:3001/api/groups/fake_users",parameters: params, encoding: .URL)
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
                    
                    let fakeUsers = JSON!["fakes"] as! Array<AnyObject>
                    StockFakeUsers.sharedInstance.fakeUsers = []
                    
                    for fake in fakeUsers {

                        let user = User()
                        let fakeUser = User()
                        
                        user.name = fake["user_name"] as! String
                        fakeUser.name = fake["fake_user_name"] as! String
                        
                        let fake = Fake()
                        fake.user = user
                        fake.fakeUser = fakeUser
                        
                        StockFakeUsers.addFake(fake)
                    }
                    
                }
                callback()
        }
    }
    
}
