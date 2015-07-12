//
//  serchedGroupView.swift
//  StirApp
//
//  Created by 松下慶大 on 2015/07/12.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit

@objc protocol SearchedGroupViewDelegate {
    func groupViewTapJoinButton(errorMessage: String)
}

class SearchedGroupView: UIView {

    let infoView = UIView()
    var group: Group!
    weak var customDelegate: SearchedGroupViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpInfoView() {
        setInfoView()
        setHeaderView()
        setHeaderLabel()
        setGroupImageView()
        setGroupLabel()
        setActionButton("Join", tag: 0, x: 10)
        setActionButton("Cancel", tag: 1, x: 130)
    }
    
    func setInfoView() {
        infoView.frame.size = CGSize(width: 250, height: 200)
        infoView.center = self.center
        infoView.backgroundColor = UIColor.whiteColor()
        infoView.layer.cornerRadius = 5
        infoView.layer.masksToBounds = true
        self.addSubview(infoView)
    }

    func setHeaderView() {
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 40)
        headerView.backgroundColor = UIColor.mainColor()
        infoView.addSubview(headerView)
    }
    
    func setHeaderLabel() {
        let headerLabel = UILabel()
        headerLabel.text = "Search results"
        headerLabel.layer.position = CGPoint(x: 10, y: 10)
        headerLabel.sizeToFit()
        headerLabel.textColor = UIColor.whiteColor()
        headerLabel.font = UIFont(name: "Helvetica-none", size: 15)
        infoView.addSubview(headerLabel)
    }
    
    func setGroupImageView() {
        let groupImageView = UIImageView()
        groupImageView.frame = CGRect(x: 10, y: 70, width: 50, height: 50)
        groupImageView.layer.cornerRadius = groupImageView.frame.width / 2
        groupImageView.layer.masksToBounds = true
        groupImageView.image = group.image
        infoView.addSubview(groupImageView)
    }
    
    
    func setGroupLabel() {
        let groupLabel = UILabel()
        groupLabel.frame = CGRect(x: 70, y: 70, width: infoView.frame.width - 90, height: 50)
        groupLabel.text = group.name
        groupLabel.textColor = UIColor.grayColor()
        infoView.addSubview(groupLabel)
    }
    
    func setActionButton(title: String, tag: Int, x: CGFloat) {
        let actionButton = UIButton()
        actionButton.layer.position = CGPoint(x: x, y: 150)
        actionButton.frame.size = CGSize(width: 110, height: 30)
        actionButton.setTitle(title, forState: UIControlState.Normal)
        actionButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        actionButton.backgroundColor = UIColor.subColor()
        actionButton.layer.cornerRadius = 3
        actionButton.tag = tag
        actionButton.addTarget(self, action: "tapActionButton:", forControlEvents: UIControlEvents.TouchUpInside)
        infoView.addSubview(actionButton)
    }
    
    
    //action
    func tapActionButton(sender: UIButton) {
        if sender.tag == 1 {
            removeFromSuperview()
        } else if sender.tag == 0 {
            var callback = { (errorMessage: String) -> Void in
                self.customDelegate?.groupViewTapJoinButton(errorMessage)
            }
            StockGroup.addGroup(group, callback: callback)
        }
    }
    
    
}
