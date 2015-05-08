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
    @IBOutlet weak var statusImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageIndex = 2
        self.descriptionLabel.text = "使う準備が整いました"
        self.completeButton.setAttributedTitle(NSAttributedString(string: "時間の管理をはじめる"), forState: UIControlState.Normal)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.user!.name != nil && !self.user!.name!.isEmpty {
            self.showCompleteMessages()
        } else {
            self.showNameEmptyMessages()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showNameEmptyMessages() {
        self.statusImage.image = UIImage(named: "x-mark")
        self.descriptionLabel.text = "名前が未入力です"
        self.descriptionLabel.textColor = .redColor()
        self.completeButton.hidden = true
    }
    
    /**
    完了画面を表示する
    */
    func showCompleteMessages() {
        self.statusImage.image = UIImage(named: "complete")
        self.descriptionLabel.text = "ようこそ「\(self.user!.name!)」さん\n使う準備が整いました"
        self.descriptionLabel.textColor = .whiteColor()
        self.completeButton.hidden = false
    }
    
    @IBAction func onClickComplete(sender: AnyObject) {
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreWithCompletion { (result, error) -> Void in
            let storyboard : UIStoryboard! =  UIStoryboard(name: "Dashboards", bundle: nil)
            let initialViewCtl = storyboard.instantiateInitialViewController() as! UIViewController
            
            self.presentViewController(initialViewCtl, animated: true, completion: nil)
        }
    }
}