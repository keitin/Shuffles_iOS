//
//  SearchGroupViewController.swift
//  StirApp
//
//  Created by 松下慶大 on 2015/06/17.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit

class SearchGroupViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var groupPassTextField: UITextField!
    @IBOutlet weak var groupNameTextField: UITextField!

    
    let groupView = UIView()
    let groupImageView = UIImageView()
    let groupNameLabel = UILabel()
    var name = ""
    var currentGroupName = ""
    var currentPass = ""
    var currentGroup = Group()

    
    let orange = UIColor(red: 244/255, green: 104/255, blue: 95/255, alpha: 1.0)

    
    override func viewDidLoad() {
        super.viewDidLoad()

        groupPassTextField.delegate = self
        groupNameTextField.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapSearchGroupBtn(sender: UIButton) {
        
        let group = Group()
        group.name = groupNameTextField.text
        group.password = groupPassTextField.text
        
        var callback = { (params: Dictionary<String, AnyObject>) -> Void in
            self.name = params["groupName"] as! String!
            self.currentGroup.password = params["groupPass"] as! String!
            self.currentGroup.name = self.name
            self.setGroupView()
        }
        
        StockGroup.searchGroup(group, callback: callback)
    }
    
    
    func setGroupView() {
        groupView.frame.size = CGSize(width: self.view.frame.width - 50 , height: 300)
        groupView.center = self.view.center
        groupView.layer.borderColor = orange.CGColor
        groupView.layer.borderWidth = 2
        setLabel()
        setGrounpImage()
        setJoinBtn()
        setGroupNameLabel()
//        self.view.addSubview(groupView)
        
    }
    
    
    func setJoinBtn() {
        let joinButton = UIButton()
        joinButton.frame.size = CGSize(width: 200, height: 50)
        joinButton.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 100)
        joinButton.setTitle("参加する", forState: UIControlState.Normal)
        joinButton.setTitleColor(orange, forState: UIControlState.Normal)
        joinButton.titleLabel?.font = UIFont(name: "HirakakuProN-W6", size: 15)
        joinButton.layer.cornerRadius = 3
        joinButton.layer.borderWidth = 1
        joinButton.layer.borderColor = orange.CGColor
        joinButton.addTarget(self, action: "tapJoinBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(joinButton)
    }
    
    
    func setLabel() {
        let label = UILabel()
        label.text = "このグループに参加しますか？"
        label.font = UIFont(name: "HirakakuProN-W3", size: 15)
        label.sizeToFit()
        label.center = CGPoint(x: self.groupView.center.x, y: self.groupView.center.y - 150)
        view.addSubview(label)
    }
    
    func setGroupNameLabel() {
        groupNameLabel.text = self.name
        groupNameLabel.font = UIFont(name: "HirakakuProN-W3", size: 18)
        groupNameLabel.sizeToFit()
        groupNameLabel.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 25)
        view.addSubview(groupNameLabel)

    }
    
    
    func setGrounpImage() {
        groupImageView.frame.size = CGSize(width: 100, height: 100)
        groupImageView.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 50)
        groupImageView.image = UIImage(named: "hinako2")
        groupImageView.layer.cornerRadius = groupImageView.frame.width / 2
        groupImageView.clipsToBounds = true
        view.addSubview(groupImageView)
    }

    
    func tapJoinBtn(sender: UIButton) {
        
        var callback = { () -> Void in
            self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
        }

        StockGroup.addGroup(currentGroup, callback: callback)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

}
