//
//  SearchGroupViewController.swift
//  StirApp
//
//  Created by 松下慶大 on 2015/06/17.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit

class SearchGroupViewController: UIViewController, UITextFieldDelegate, SearchedGroupViewDelegate {
    @IBOutlet weak var searchButton: UIButton!
    
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
        
        setSearchButton()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapSearchGroupBtn(sender: UIButton) {
        
        let group = Group()
        group.name = groupNameTextField.text
        group.password = groupPassTextField.text
        
        var callback = { (group: Group?) -> Void in
        
            if group != nil {
                let searchedGroupView = SearchedGroupView(frame: self.navigationController!.view.frame)
                searchedGroupView.customDelegate = self
                searchedGroupView.group = group
                searchedGroupView.setUpInfoView()
                self.navigationController?.view.addSubview(searchedGroupView)
            } else {
                let message = "Not Found"
                self.showAlert(message)
            }
            
        }
        StockGroup.searchGroup(group, callback: callback)
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setSearchButton() {
        searchButton.layer.cornerRadius = 5
        searchButton.layer.masksToBounds = true
    }
    
    
    func groupViewTapJoinButton(errorMessage: String) {
        if errorMessage == "" {
            self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
        } else {
            showAlert(errorMessage)
        }
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(OKAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    

    
}
