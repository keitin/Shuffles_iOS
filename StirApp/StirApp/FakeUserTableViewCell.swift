//
//  FakeUserTableViewCell.swift
//  StirApp
//
//  Created by 松下慶大 on 2015/06/29.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit

class FakeUserTableViewCell: UITableViewCell {
    @IBOutlet weak var fakeUserName: UILabel!
    @IBOutlet weak var userName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
