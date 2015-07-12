//
//  NewGroupViewController.swift
//  StirApp
//
//  Created by 松下慶大 on 2015/06/17.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit

class NewGroupViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var selectImageButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var groupPassConfirmTextField: UITextField!
    @IBOutlet weak var groupPassTextFiled: UITextField!
    @IBOutlet weak var groupNameTextFiled: UITextField!
    @IBOutlet weak var groupImageView: UIImageView!
    
    let photoPicker = UIImagePickerController()
    var groupImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoPicker.delegate = self
        
        groupImageView.layer.cornerRadius = groupImageView.frame.width / 2
        groupImageView.clipsToBounds = true

        groupImageView.userInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: "openCameraRoll")
        groupImageView.addGestureRecognizer(gesture)
        
        setCreateButton()
        setSelectImageButton()
        
        groupNameTextFiled.delegate = self
        groupPassTextFiled.delegate = self
        groupPassConfirmTextField.delegate = self
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Stop, target: self, action: "backToGroupListVC")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: "searchGroup")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchGroup() {
        performSegueWithIdentifier("showSearchGroupVC", sender: nil)
    }
    
    //camera
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        groupImage = image
        groupImageView.image = image!
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func tapCreateGroupBtn(sender: UIButton) {
        var message = ""
        if groupNameTextFiled.text == "" ||
            groupPassConfirmTextField.text == "" ||
            groupPassTextFiled.text == ""{
            message = "Form is blank"
            showErrorAlert(message)
        } else if groupPassTextFiled.text != groupPassConfirmTextField.text {
            message = "Password does not accord"
            showErrorAlert(message)
        } else if groupImage == nil {
            message = "Set group image"
            showErrorAlert(message)
        } else {
            let group = Group()
            group.name  = groupNameTextFiled.text
            group.password = groupPassTextFiled.text
            group.confirmPass = groupPassConfirmTextField.text
            group.image = groupImage
            
            var callback = { () -> Void in
                self.showSuccessfullyAlert()
            }
            
            StockGroup.saveGroup(group, callback: callback)
            
        }
    }
    
    @IBAction func tapSelectImage(sender: UIButton) {
        self.photoPicker.sourceType = .PhotoLibrary
        self.presentViewController(photoPicker, animated: true, completion: nil)
    }
    
    func openCameraRoll() {
        self.photoPicker.sourceType = .PhotoLibrary
        self.presentViewController(photoPicker, animated: true, completion: nil)
    }
    
    func backToGroupListVC() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func setCreateButton() {
        createButton.layer.cornerRadius = 5
        createButton.layer.masksToBounds = true
    }
    
    func setSelectImageButton() {
        let textLabel = UILabel()
        textLabel.frame.size = selectImageButton.frame.size
        textLabel.layer.position = CGPoint(x: 155, y: 15)
        textLabel.text = "Select Group Image"
        textLabel.font = UIFont(name: "Helvetica", size: 14)
        textLabel.textColor = UIColor.mainColor()
        selectImageButton.addSubview(textLabel)
    }
    
    
    func showErrorAlert(errorMessage: String) {
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(OKAction)
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func showSuccessfullyAlert() {
        let alertController = UIAlertController(title: "Complete", message: "Successfully Create Group", preferredStyle: UIAlertControllerStyle.Alert)
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(OKAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
