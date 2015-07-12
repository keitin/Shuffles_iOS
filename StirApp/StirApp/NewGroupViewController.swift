//
//  NewGroupViewController.swift
//  StirApp
//
//  Created by 松下慶大 on 2015/06/17.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit

class NewGroupViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
        
        let group = Group()
        group.name  = groupNameTextFiled.text
        group.password = groupPassTextFiled.text
        group.confirmPass = groupPassConfirmTextField.text
        group.image = groupImage
        
        var callback = { () -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        if group.password == group.confirmPass {
            println("保存しました")
            StockGroup.saveGroup(group, callback: callback)
        } else {
            println("確認用パスワードが異なります")
        }
    }
    
    
    func openCameraRoll() {
        self.photoPicker.sourceType = .PhotoLibrary
        self.presentViewController(photoPicker, animated: true, completion: nil)
    }
    
    func backToGroupListVC() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
