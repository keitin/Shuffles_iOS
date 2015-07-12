//
//  Extension+UIAlertController.swift
//  StirApp
//
//  Created by 松下慶大 on 2015/07/13.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    
    class func showAlert(title: String, message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(OKAction)
        return alertController
    }
    
}
