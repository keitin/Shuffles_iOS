//
//  CustomTextField.swift
//  StirApp
//
//  Created by 松下慶大 on 2015/07/11.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit

class CustomTextField: UITextField, UITextFieldDelegate {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.placeholder = "hogehoge"
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset( bounds , 10 , 10 )
    }

}
