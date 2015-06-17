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
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Bookmarks, target: self, action: "backToGroupListVC")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: "saveGroup")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //camera
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {

        groupImageView.image = image!
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //Action
    func saveGroup() {
        var name = groupNameTextFiled.text
        var pass = groupPassTextFiled.text
        var confirmPass = groupPassConfirmTextField.text
        
        var callback = { () -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }

        
        if pass == confirmPass {
            println("保存しました")
//            StockGroup.saveGroup(name, passwd: pass, )
            StockGroup.saveGroup(name, password: pass, callback: callback)
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
