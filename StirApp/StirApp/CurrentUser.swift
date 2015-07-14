//
//  CurrentUser.swift
//  StirApp
//
//  Created by 松下慶大 on 2015/06/14.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit
import Alamofire

class CurrentUser: User {
    
    static let sharedInstance = CurrentUser()
    var authToken: AnyObject?
    
    func saveCurrentUserInUserDefault() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(authToken, forKey: "authToken")
        defaults.setObject(name, forKey: "userName")
        if let currentUserImage = self.image {
            let imagePass = currentUserImage.convertToString()
            defaults.setObject("avatar", forKey: imagePass)
        }
        defaults.synchronize()
    }
    
    func removeAuthToken() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("authToken")
        defaults.synchronize()
    }
    
    class func fetchCurrentUserInUserDefaults() -> CurrentUser {
        let defaults = NSUserDefaults.standardUserDefaults()
        var curretUser = CurrentUser.sharedInstance
        curretUser.name = defaults.objectForKey("userName") as! String
        if let imageString = defaults.objectForKey("avatar") as? String {
            curretUser.image = UIImage.convertToUIImage(imageString)
        }
        return curretUser
    }
    
    func fetchCurrentUser(callBack: () -> Void) {
        
        let currentUser = CurrentUser.sharedInstance
        
        var params: [String: AnyObject] = ["auth_token": self.authToken!]
        let path = String.localhost() + "/api/users/fetch_current_user"
        Alamofire.request(.GET, path, parameters: params, encoding: .URL)
            .responseJSON { (request, response, JSON, error) in
                
                if error == nil {
                    let imagePass = JSON!["avatar"]! as! String
                    let image = UIImage.convertToUIImageFromImagePass(imagePass)
                    let name = JSON!["name"]! as! String
                    
                    currentUser.name = name
                    currentUser.image = image
                }
            callBack()
        }
    }
    
    class func editCurrentUser(user: CurrentUser, callback: () -> Void) {
        
        let params: [String: AnyObject] = [
            "name": user.name,
            "auth_token": user.authToken!
        ]

        let pass = String.localhost() +  "/api/users/update"
        let httpMethod = Alamofire.Method.PUT.rawValue

        if user.image == nil {
            Alamofire.request(.PUT, pass, parameters: params, encoding: .URL)
                .responseJSON { (request, response, JSON, error) in
                    
                    if error == nil {
                        let user = JSON!["user"] as! Dictionary<String, AnyObject>
                        let currentUser = CurrentUser.sharedInstance
                        currentUser.name = user["name"] as! String
                        
                        let urlKey = user["avatar"] as! Dictionary<String, AnyObject>
                        if let imageURL = urlKey["url"] as? String {
                            let image = UIImage.convertToUIImageFromImagePass(imageURL)
                            currentUser.image = image
                        }
                        
                        currentUser.saveCurrentUserInUserDefault()
                        callback()
                    }
            }
        } else {
            let urlRequest = NSData.urlRequestWithComponents(httpMethod, urlString: pass, parameters: params, image: user.image!)
            Alamofire.upload(urlRequest.0, urlRequest.1)
                .responseJSON { (request, response, JSON, error) in
                    if error == nil {
                        let user = JSON!["user"] as! Dictionary<String, AnyObject>
                        let currentUser = CurrentUser.sharedInstance
                        currentUser.name = user["name"] as! String
                            
                        let urlKey = user["avatar"] as! Dictionary<String, AnyObject>
                        if let imageURL = urlKey["url"] as? String {
                            let image = UIImage.convertToUIImageFromImagePass(imageURL)
                            currentUser.image = image
                        }
                        currentUser.saveCurrentUserInUserDefault()
                        callback()
                    }
            }
        }
        
    }
    
    
    func fetchCurrentUserInGroup(group: Group, callback: (fakeUser: User, isCheked: Bool) -> Void) -> User! {
        
        var params: [String: AnyObject!] = [
            "auth_token": self.authToken,
            "name": group.name,
            "password": group.password
        ]
        
        let path = String.localhost() + "/api/users/group/curret_user"
        Alamofire.request(.GET, path, parameters: params, encoding: .URL)
            .responseJSON { (request, response, JSON, error) in
                let fakeUser = User()
                var isCheked: Bool!
                if error == nil {
                    let fakeUserName = JSON!["fake_user_name"] as! String
                    let imageString = JSON!["fake_user_avatar"] as! String
                    let image = UIImage.convertToUIImageFromImagePass(imageString)

                    fakeUser.name = fakeUserName
                    fakeUser.image = image
                    
                    isCheked = JSON!["is_checked"] as! Bool
                }

                callback(fakeUser: fakeUser, isCheked: isCheked)
        }
        
        return fakeUser
    }
    
    
    
    func checkedFakeUser(group: Group, callback: () -> Void) {
        
        var params: [String: AnyObject!] = [
            "auth_token": self.authToken,
            "name": group.name,
            "password": group.password
        ]
        
        let path = String.localhost() + "/api/fakes/checked"
        Alamofire.request(.PUT, path, parameters: params, encoding: .URL)
            .responseJSON { (request, response, JSON, error) in
                
        }
        
        callback()
    }
    

    
}
