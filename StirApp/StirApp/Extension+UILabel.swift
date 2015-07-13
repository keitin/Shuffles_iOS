//
//  Extension+UILabel.swift
//  StirApp
//
//  Created by 松下慶大 on 2015/07/14.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func fixLabelHeight(text: String) {
        let lineHeight:CGFloat = 17.0
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        self.attributedText = attributedText
    }
    
}