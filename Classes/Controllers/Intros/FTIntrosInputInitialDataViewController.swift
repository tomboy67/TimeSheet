//
//  FTIntrosInputInitialDataViewController.swift
//  TimeSheet
//
//  Created by TomomuraRyota on 2015/04/27.
//  Copyright (c) 2015年 TomomuraRyota. All rights reserved.
//

import UIKit

class FTIntrosInputInitialDataViewController: FTIntrosPageDataViewController, UITextFieldDelegate {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageIndex = 1
        self.descriptionLabel.text = "名前を入力したらすぐにはじめられます"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let user = User.MR_createEntity() as! User
        
        user.name = self.nameTextField.text
        return true
    }
}
