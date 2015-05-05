//
//  FTIntrosCompleteViewController.swift
//  TimeSheet
//
//  Created by TomomuraRyota on 2015/05/03.
//  Copyright (c) 2015年 TomomuraRyota. All rights reserved.
//

import UIKit

class FTIntrosCompleteViewController: FTIntrosPageDataViewController {
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageIndex = 2        
        self.descriptionLabel.text = "使う準備が整いました"
        self.completeButton.setAttributedTitle(NSAttributedString(string: "時間の管理をはじめる"), forState: UIControlState.Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onClickComplete(sender: AnyObject) {
        let storyboard : UIStoryboard! =  UIStoryboard(name: "Dashboards", bundle: nil)
        let initialViewCtl = storyboard.instantiateInitialViewController() as! UIViewController
        
        self.presentViewController(initialViewCtl, animated: true) { () -> Void in
            println("completed")
        }
    }
}
