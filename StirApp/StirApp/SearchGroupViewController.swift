//
//  SearchGroupViewController.swift
//  StirApp
//
//  Created by 松下慶大 on 2015/06/17.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit

class SearchGroupViewController: UIViewController {
    
    @IBOutlet weak var groupPassTextField: UITextField!
    @IBOutlet weak var groupNameTextField: UITextField!

    let backgroundView = UIView()
    let groupView = UIView()
    let groupImageView = UIImageView()
    let groupNameLabel = UILabel()
    var name = ""
    
    let orange = UIColor(red: 244/255, green: 104/255, blue: 95/255, alpha: 1.0)

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    
        

        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapSearchGroupBtn(sender: UIButton) {
        
        backgroundView.frame = self.view.frame
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        backgroundView.addSubview(blurEffectView)
        
        
        let gesture = UITapGestureRecognizer(target: self, action: "tapBackgroundView")
        blurEffectView.addGestureRecognizer(gesture)
        
        
        let groupName = groupNameTextField.text
        let groupPass = groupPassTextField.text
        
        var callback = { (params: Dictionary<String, AnyObject>) -> Void in
            self.name = params["groupName"] as! String!
            self.view.addSubview(self.backgroundView)
            self.setSearchView(blurEffectView)
        }
        
        Group.searchGroup(groupName, groupPass: groupPass, callback: callback)
        
    }
    
    func setSearchView(blurEffectView: UIVisualEffectView) {
        setGrounpImage(blurEffectView)
        setGroupNameLabel(blurEffectView)
        setLabel(blurEffectView)
        setJoinBtn(blurEffectView)
    }
    
    func setJoinBtn(blurEffectView: UIVisualEffectView) {
        let joinButton = UIButton()
        joinButton.frame.size = CGSize(width: 200, height: 50)
        joinButton.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
        joinButton.setTitle("参加する", forState: UIControlState.Normal)
        joinButton.setTitleColor(orange, forState: UIControlState.Normal)
        joinButton.titleLabel?.font = UIFont(name: "HirakakuProN-W6", size: 15)
        joinButton.layer.cornerRadius = 3
        joinButton.layer.borderWidth = 1
        joinButton.layer.borderColor = orange.CGColor
        joinButton.addTarget(self, action: "tapJoinBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        blurEffectView.addSubview(joinButton)
        
    }
    
    
    func setLabel(blurEffectView: UIVisualEffectView) {
        let label = UILabel()
        label.text = "このグループに参加しますか？"
        label.font = UIFont(name: "HirakakuProN-W3", size: 15)
        label.sizeToFit()
        label.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 250)
        blurEffectView.contentView.addSubview(label)
    }
    
    func setGroupNameLabel(blurEffectView: UIVisualEffectView) {
        groupNameLabel.text = self.name
        groupNameLabel.font = UIFont(name: "HirakakuProN-W3", size: 18)
        groupNameLabel.sizeToFit()
        groupNameLabel.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 75)
        blurEffectView.contentView.addSubview(groupNameLabel)
        
    }
    
    func setGrounpImage(blurEffectView: UIVisualEffectView) {
        groupImageView.frame.size = CGSize(width: 100, height: 100)
        groupImageView.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 150)
        groupImageView.image = UIImage(named: "hinako2")
        groupImageView.layer.cornerRadius = groupImageView.frame.width / 2
        groupImageView.clipsToBounds = true
        blurEffectView.contentView.addSubview(groupImageView)
    }
    
    func tapJoinBtn(sender: UIButton) {
        println("参加する！！")
    }
    
    func tapBackgroundView() {
        backgroundView.removeFromSuperview()
    }


}
