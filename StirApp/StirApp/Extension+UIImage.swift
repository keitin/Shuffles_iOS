//
//  Extension+UIImage.swift
//  StirApp
//
//  Created by 松下慶大 on 2015/07/09.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func convertToString() -> String {
        let imageData = UIImagePNGRepresentation(self)
        let encodeString = imageData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        return encodeString
    }
    
    class func convertToUIImage(imageString: String) -> UIImage! {
        let decodedData = NSData(base64EncodedString: imageString, options: NSDataBase64DecodingOptions(rawValue: 0))
        var decodeImage = UIImage(data: decodedData!)
        return decodeImage
    }
    
    class func convertToUIImageFromImagePass(imagePath: String) -> UIImage! {
        let imageLink = imagePath
        let url = NSURL(string: imageLink)
        let imageData = NSData(contentsOfURL: url!)
        let image = UIImage(data: imageData!)
        return image
    }
    
    
    
    
}
