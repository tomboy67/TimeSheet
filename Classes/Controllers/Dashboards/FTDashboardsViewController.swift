//
//  FTDashboardsViewController.swift
//  TimeSheet
//
//  Created by TomomuraRyota on 2015/04/04.
//  Copyright (c) 2015年 TomomuraRyota. All rights reserved.
//

import UIKit
import DKCircleButton
import MagicalRecord

protocol FTWorkTimeUpdatedDelegate {
    func updatedStartTime(targetDate: NSDate, startTime: NSDate)
    func updatedEndTime(targetDate: NSDate, endTime: NSDate)
}

class FTDashboardsViewController: UIViewController {
    
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startTimeButton: DKCircleButton!
    @IBOutlet weak var endTimeButton: DKCircleButton!
    @IBOutlet weak var workTimesContainerView: UIView!
    
    var delegate:FTWorkTimeUpdatedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "タイムカード"
        NSTimer.bk_scheduledTimerWithTimeInterval(1,
            block: { (timer) -> Void in
                self.updateTimeLabel()
                self.updateSecondsLabel()
            },
            repeats: true)

        println(self.childViewControllers.first)
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
        let targetDate : NSDate = NSDate()
        let startTime : NSDate = NSDate().roundDateToFlooringMinutes(15)
        
        MagicalRecord.saveWithBlock({ (localContext) -> Void in
            let workTime = WorkTime.findOrCreateByTargetDate(targetDate, context: localContext)
            workTime.startTime = startTime

            }, completion: { (result, error) -> Void in
                if (error != nil) {
                    println("error")
                } else {
                    self.delegate?.updatedStartTime(targetDate, startTime: startTime)
                    
                    println("success")
                }
        })
    }
    
    @IBAction func onClickEndTime(sender: AnyObject) {
        let targetDate : NSDate = NSDate()
        let endTime : NSDate =  NSDate().roundDateToFlooringMinutes(15)
        
        MagicalRecord.saveWithBlock({ (localContext) -> Void in
            let workTime = WorkTime.findOrCreateByTargetDate(targetDate, context: localContext)
            workTime.endTime = endTime
            
            }, completion: { (result, error) -> Void in
                if (error != nil) {
                    println("error")
                } else {
                    self.delegate?.updatedEndTime(targetDate, endTime: endTime)

                    println("success")
                }
        })
    }
    
}
