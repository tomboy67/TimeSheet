//
//  FTDashboardsViewController.swift
//  TimeSheet
//
//  Created by TomomuraRyota on 2015/04/04.
//  Copyright (c) 2015年 TomomuraRyota. All rights reserved.
//

import UIKit

class FTDashboardsViewController: UIViewController {
    
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startTimeButton: DKCircleButton!
    @IBOutlet weak var endTimeButton: DKCircleButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "タイムカード"
        NSTimer.bk_scheduledTimerWithTimeInterval(1,
            block: { (timer) -> Void in
                self.updateTimeLabel()
                self.updateSecondsLabel()
            },
            repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateTimeLabel() {
        let now = NSDate()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        self.timeLabel.text = dateFormatter.stringFromDate(now)
    }
    
    func updateSecondsLabel() {
        let now = NSDate()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "ss"
        self.secondsLabel.text = dateFormatter.stringFromDate(now)
    }
    
    @IBAction func onClickStartTime(sender: AnyObject) {
        MagicalRecord.saveWithBlock({ (localContext) -> Void in
            let workTime = WorkTime.findOrCreateByTargetDate(NSDate(), context: localContext)
            workTime.startTime = NSDate().roundDateToFlooringMinutes(15)

            }, completion: { (result, error) -> Void in
                if (error != nil) {
                    println("error")
                } else {
                    println("success");
                }
        })
    }
    
    @IBAction func onClickEndTime(sender: AnyObject) {
        MagicalRecord.saveWithBlock({ (localContext) -> Void in
            let workTime = WorkTime.findOrCreateByTargetDate(NSDate(), context: localContext)
            workTime.endTime = NSDate().roundDateToFlooringMinutes(15)
            
            }, completion: { (result, error) -> Void in
                if (error != nil) {
                    println("error")
                } else {
                    println("success");
                }
        })
    }
    
}
