//
//  NewTweetViewController.swift
//  StirApp
//
//  Created by 松下慶大 on 2015/06/12.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    let placeholderLabel = UILabel()
    let tweet = Tweet()
    var currentUser = CurrentUser.sharedInstance
    
    var currentGroup: Group!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setIconImageView()
        makePlaceholderLabel()
        tweetTextView.delegate = self
        
        nameLabel.text = currentUser.name
        iconImageView.image = currentUser.image
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let callBack = { () -> Void in
            self.currentUser = CurrentUser.sharedInstance
            self.iconImageView.image = self.currentUser.image
        }
        currentUser.fetchCurrentUser(callBack)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Stop, target: self, action: "backToTimeLineViewController")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: UIBarButtonItemStyle.Plain, target: self, action: "sendTweet")
        
        //Registing Notification Center
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "willShowKeyBoard:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //lifting Notification Center
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver("willShowKeyBoard")

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func sendTweet() {
        
        self.tweetTextView.resignFirstResponder()
        
        if tweetTextView.text == "" {
            let alertController = UIAlertController.showAlert("It is blanks", message: "")
            presentViewController(alertController, animated: true, completion: nil)
        } else {
            tweet.text = tweetTextView.text
            var callBack = { () -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            println(currentGroup)
            StockTweets.saveTweet(tweet, group: currentGroup, currentUser: currentUser, callBack: callBack)
        }
    }
    
    
    func backToTimeLineViewController() {
        self.tweetTextView.resignFirstResponder()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func makePlaceholderLabel() {
        placeholderLabel.frame.origin = CGPointMake(0, 8)
        placeholderLabel.text = "What are you doing now?"
        placeholderLabel.sizeToFit()
        placeholderLabel.textColor = UIColor.grayColor()
        placeholderLabel.font = UIFont(name: "HiraKakuProN-W3", size: 15)
        tweetTextView.addSubview(placeholderLabel)
    }
    
    
    func setIconImageView() {
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        iconImageView.clipsToBounds = true
    }
    
    
    //keyBoard
    func willShowKeyBoard(notification: NSNotification?) {
        placeholderLabel.hidden = true
    }
    
}
