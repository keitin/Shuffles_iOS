//
//  TimeLineTableViewController.swift
//  StirApp
//
//  Created by 松下慶大 on 2015/06/12.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit

class TimeLineTableViewController: UITableViewController {

    var tweets: Array<Tweet> = []
    var currentGroup: Group!
    let currentUser = CurrentUser.sharedInstance
    var flag: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //セルの登録
        self.tableView.registerNib(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: "TweetTableViewCell")
        
        self.tableView.estimatedRowHeight = 90
        self.tableView.rowHeight = UITableViewAutomaticDimension

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let myBarButton_3 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Pause, target: self, action: "changeFakeUser")
        let myBarButton_2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Play, target: self, action: "modalFakeUsersTableViewController")
        let myBarButton_1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Compose, target: self, action: "modalToNewTweetViewController")
        let myRightButtons: NSArray = [myBarButton_1, myBarButton_2, myBarButton_3]
        self.navigationItem.setRightBarButtonItems(myRightButtons as [AnyObject], animated: true)
        
        
        let callBack = { () -> Void in
            self.tweets = StockTweets.sharedInstance.tweets
            self.tableView.reloadData()
            println("gggggggggggggggggggggggg")
            println(self.tweets)
        }
        
        //ツイートをdbからフェッチ
        StockTweets.fetchTweets(currentGroup, callBack: callBack)
        
        let informationView = InformationView(frame: self.view.bounds)
        self.tabBarController?.view.addSubview(informationView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return tweets.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetTableViewCell", forIndexPath: indexPath) as! TweetTableViewCell
        let tweet = tweets[indexPath.row]
        cell.tweetLabel?.text = tweet.text
        if flag {
            cell.nameLabel.text = tweet.user.name
        } else {
            cell.nameLabel.text = tweet.user.fakeUser?.name
            println(tweet.user.fakeUser)
        }
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    func changeFakeUser() {
        if flag == true {
            flag = false
        } else {
            flag = true
        }
        self.tableView.reloadData()
    }
    
    //segue
    func modalToNewTweetViewController() {
        performSegueWithIdentifier("modalToNewTweetViewController", sender: nil)
    }
    
    func modalFakeUsersTableViewController() {
        performSegueWithIdentifier("modalFakeUsersTableViewController", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "modalToNewTweetViewController" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let newTweetViewController = navigationController.viewControllers.first as! NewTweetViewController
            newTweetViewController.currentGroup = self.currentGroup
        } else if segue.identifier == "modalFakeUsersTableViewController" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let fakeUserTableViewController = navigationController.viewControllers.first as! FakeUsersListTableViewController
            fakeUserTableViewController.currentGroup = self.currentGroup
        }
    }

}
