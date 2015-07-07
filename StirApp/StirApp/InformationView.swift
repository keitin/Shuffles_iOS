//
//  informationView.swift
//  StirApp
//
//  Created by 松下慶大 on 2015/07/07.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit

class InformationView: UIView {

    let infoView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
    
        setInfoView()
        setTodayLabel()
        setFakeUserImageView()
        setFakeUserNameLabel()
        setOKButton()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setInfoView() {
        infoView.frame.size = CGSize(width: 250, height: 250)
        infoView.center = self.center
        infoView.backgroundColor = UIColor.whiteColor()
        infoView.layer.cornerRadius = 5
        infoView.layer.masksToBounds = true
        self.addSubview(infoView)
    }
    
    func setTodayLabel() {
        let todayLabel = UILabel()
        todayLabel.text = "今日のあなたは..."
        todayLabel.font = UIFont(name: "HirakakuProN-W3", size: 15)
        todayLabel.sizeToFit()
        todayLabel.center = CGPoint(x: infoView.center.x, y: infoView.center.y - 100)
        self.addSubview(todayLabel)
    }
    
    func setFakeUserImageView() {
        let fakeUserImageView = UIImageView()
        fakeUserImageView.frame.size = CGSize(width: 100, height: 100)
        fakeUserImageView.center = CGPoint(x: infoView.center.x, y: infoView.center.y - 25)
        fakeUserImageView.image = UIImage(named: "hinako4")
        fakeUserImageView.layer.cornerRadius = fakeUserImageView.frame.width / 2
        fakeUserImageView.layer.masksToBounds = true
        self.addSubview(fakeUserImageView)
    }
    
    func setFakeUserNameLabel() {
        let fakeUserNameLabel = UILabel()
        fakeUserNameLabel.text = "松下 慶大"
        fakeUserNameLabel.font = UIFont(name: "HirakakuProN-W6", size: 17)
        fakeUserNameLabel.sizeToFit()
        fakeUserNameLabel.center = CGPoint(x: infoView.center.x, y: infoView.center.y + 50)
        self.addSubview(fakeUserNameLabel)
    }
    
    func setOKButton() {
        let OKButton = UIButton()
        OKButton.frame.size = CGSize(width: 150, height: 35)
        OKButton.center = CGPoint(x: infoView.center.x, y: infoView.center.y + 90)
        OKButton.setTitle("O K", forState: UIControlState.Normal)
        OKButton.setTitleColor(UIColor.mainColor(), forState: UIControlState.Normal)
        OKButton.addTarget(self, action: "tapOK:", forControlEvents: UIControlEvents.TouchUpInside)
        OKButton.layer.cornerRadius = 3
        OKButton.layer.borderColor = UIColor.mainColor().CGColor
        OKButton.layer.borderWidth = 1
        self.addSubview(OKButton)
    }
    
    func tapOK(sender: UIButton) {
        self.removeFromSuperview()
    }
    
}
