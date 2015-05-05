//
//  FTIntrosWelcomeViewController.swift
//  TimeSheet
//
//  Created by TomomuraRyota on 2015/04/27.
//  Copyright (c) 2015年 TomomuraRyota. All rights reserved.
//

import UIKit

class FTIntrosWelcomeViewController: FTIntrosPageDataViewController {
    @IBOutlet weak var descriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.pageIndex = 0
        self.descriptionLabel.text = "「TimeSheet」へようこそ。\nスワイプして次へ。"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
