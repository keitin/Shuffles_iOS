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

        let imageData = UIImagePNGRepresentation(group.image)
        
        let urlRequest = urlRequestWithComponents("http://localhost:3001/api/groups/", parameters: params, imageData: imageData)
        
        Alamofire.upload(urlRequest.0, urlRequest.1)
            .progress { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in

            }
            .responseJSON { (request, response, JSON, error) in

        }
        
    }
    
    
    class func urlRequestWithComponents(urlString: String, parameters: Dictionary<String, AnyObject>, imageData: NSData) -> (URLRequestConvertible, NSData) {
    
        // create url request to send
        var mutableURLRequest = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        mutableURLRequest.HTTPMethod = Alamofire.Method.POST.rawValue
        let boundaryConstant = "myRandomBoundary12345"
        let contentType = "multipart/form-data;boundary=" + boundaryConstant
        mutableURLRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        
        // create upload data to send
        let uploadData = NSMutableData()
        
        
        // add image
        uploadData.appendData("\r\n--\(boundaryConstant)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        uploadData.appendData("Content-Disposition: form-data; name=\"avatar\"; filename=\"file.png\"\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        uploadData.appendData("Content-Type: image/png\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        uploadData.appendData(imageData)
        
        
        // add parameters
        for (key, value) in parameters {
            uploadData.appendData("\r\n--\(boundaryConstant)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
            uploadData.appendData("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n\(value)".dataUsingEncoding(NSUTF8StringEncoding)!)
        }
        
        uploadData.appendData("\r\n--\(boundaryConstant)--\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        return (Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: nil).0, uploadData)
        
    }
    
    
    class func fetchGroup(callback: () -> Void) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let auth_token = defaults.objectForKey("authToken") as! String

        var params: [String: AnyObject] = [
            "auth_token": auth_token
        ]
        
        Alamofire.request(.GET, "http://localhost:3001/api/groups",parameters: params, encoding: .URL)
            .responseJSON { (request, response, JSON, error) in
                
                if error == nil {

                    var groups = JSON?["groups"] as! Array<AnyObject>
 
                    StockGroup.sharedInstance.myGroups = []
                    for myGroup in groups {
                        var group = Group()
                        group.name = myGroup["name"] as! String
                        group.password = myGroup["password"] as! String
                        
                        let avatar =  myGroup["avatar"]! as! Dictionary<String, AnyObject>
                        let urlKey = avatar["avatar"] as! Dictionary<String, AnyObject>
                        if let imageURL = urlKey["url"] as? String {
                            let imageLink = "http://localhost:3001" + imageURL
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
    
    
    class func searchGroup(group: Group, callback: (Dictionary<String, AnyObject>) -> Void) {
        
        var params: [String: AnyObject] = [
            "name": group.name,
            "password": group.password
        ]
        
        var returnParams: Dictionary<String, AnyObject> = [:]
        
        Alamofire.request(.GET, "http://localhost:3001/api/groups/search",parameters: params, encoding: .URL)
            .responseJSON { (request, response, JSON, error) in
                
                if error == nil {
                    println(JSON!["group_name"])
                    returnParams["groupName"] = JSON?["group_name"] as! String
                    returnParams["groupPass"] = JSON?["group_pass"] as! String
                }
                
                callback(returnParams)
        }
        
    }

    
    class func addGroup(group: Group, callback: () -> Void) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let auth_token = defaults.objectForKey("authToken") as! String
        
        var params: [String: AnyObject] = [
            "auth_token": auth_token,
            "name": group.name,
            "password": group.password
        ]
     
        Alamofire.request(.GET, "http://localhost:3001/api/groups/add_group",parameters: params, encoding: .URL)
            .responseJSON { (request, response, JSON, error) in
                
            callback()
        }
    }
    
    
    
    
}
