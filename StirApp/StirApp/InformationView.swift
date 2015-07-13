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
    var fakeUser = User()
    let headerView = UIView()
    var group: Group!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
    
    }
    
    func setUpInfoView() {
        setInfoView()
        setHeaderView()
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
        todayLabel.text = "Today is"
        todayLabel.frame = headerView.frame
        todayLabel.textAlignment = NSTextAlignment.Center
        todayLabel.font = UIFont(name: "HirakakuProN-W6", size: 15)
        todayLabel.textColor = UIColor.whiteColor()
        infoView.addSubview(todayLabel)
    }
    
    func setHeaderView() {
        headerView.frame = CGRect(x: 0, y: 0, width: infoView.frame.width, height: 40)
        headerView.backgroundColor = UIColor.mainColor()
        infoView.addSubview(headerView)
    }
    
    func setFakeUserImageView() {
        let fakeUserImageView = UIImageView()
        fakeUserImageView.frame.size = CGSize(width: 100, height: 100)
        fakeUserImageView.contentMode = UIViewContentMode.ScaleAspectFill
        fakeUserImageView.center = CGPoint(x: infoView.center.x, y: infoView.center.y - 20)
        fakeUserImageView.image = fakeUser.image
        fakeUserImageView.layer.cornerRadius = fakeUserImageView.frame.width / 2
        fakeUserImageView.layer.masksToBounds = true
        self.addSubview(fakeUserImageView)
    }
    
    func setFakeUserNameLabel() {
        let fakeUserNameLabel = UILabel()
        fakeUserNameLabel.text = fakeUser.name
        fakeUserNameLabel.font = UIFont(name: "HirakakuProN-W3", size: 17)
        fakeUserNameLabel.sizeToFit()
        fakeUserNameLabel.center = CGPoint(x: infoView.center.x, y: infoView.center.y + 55)
        self.addSubview(fakeUserNameLabel)
    }
    
    func setOKButton() {
        let OKButton = UIButton()
        OKButton.frame.size = CGSize(width: 230, height: 35)
        OKButton.center = CGPoint(x: infoView.center.x, y: infoView.center.y + 95)
        OKButton.setTitle("O K", forState: UIControlState.Normal)
        OKButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        OKButton.addTarget(self, action: "tapOK:", forControlEvents: UIControlEvents.TouchUpInside)
        OKButton.backgroundColor = UIColor.subColor()
        OKButton.layer.cornerRadius = 3
//        OKButton.layer.borderColor = UIColor.mainColor().CGColor
//        OKButton.layer.borderWidth = 1
        self.addSubview(OKButton)
    }
    
    
    func tapOK(sender: UIButton) {
        let callback = { () -> Void in
            self.removeFromSuperview()
        }
        let currentUser = CurrentUser.sharedInstance
        currentUser.checkedFakeUser(group, callback: callback)
        
    }
    
}
