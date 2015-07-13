//
//  GroupListTableViewController.swift
//  StirApp
//
//  Created by 松下慶大 on 2015/06/17.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit

class GroupListTableViewController: UITableViewController {
    
    var activeGroup: Group!
    var groups: Array<Group> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNib(UINib(nibName: "GroupTableViewCell", bundle: nil), forCellReuseIdentifier: "groupCell")
        tableView.separatorColor = UIColor.clearColor()
        
        let backButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: UIBarButtonItemStyle.Plain, target: self, action: "modalNewGroupViewController")
        
        //HTTP
        var callback = {() -> Void in
            println("グループフェッチ完了")
            self.groups = StockGroup.sharedInstance.myGroups
            self.tableView.reloadData()
        }
        
        StockGroup.fetchGroup(callback)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return  1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return groups.count
    }
    
    
    
    func modalNewGroupViewController() {
        performSegueWithIdentifier("modalNewGroupVC", sender: nil)
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("groupCell", forIndexPath: indexPath) as! GroupTableViewCell
        let group = groups[indexPath.row]
        cell.groupNameLabel.text = group.name
        cell.groupImageView.image = group.image
        cell.lastMessageLabel.text = group.lastMessage
        return cell
    }


    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        activeGroup = groups[indexPath.row]
        performSegueWithIdentifier("ShowTimeLineVC", sender: nil)
    }
    
//    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }
//    
//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowTimeLineVC" {
            let timeLineTableViewController = segue.destinationViewController as! TimeLineTableViewController
            timeLineTableViewController.currentGroup = activeGroup
        }
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

}
