//
//  FTWorkTimesViewController.swift
//  TimeSheet
//
//  Created by TomomuraRyota on 2015/04/04.
//  Copyright (c) 2015年 TomomuraRyota. All rights reserved.
//

import UIKit
import Timepiece


class FTWorkTimesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FTWorkTimeUpdatedDelegate {
    
    var targetDate: NSDate!
    var currentCalendar: NSCalendar!
    var daysOfMonthRange: NSRange!
    
    @IBOutlet weak var tableView: UITableView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.targetDate = NSDate()
        self.currentCalendar = NSCalendar(identifier: NSGregorianCalendar)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.daysOfMonthRange = self.currentCalendar.rangeOfUnit(NSCalendarUnit.DayCalendarUnit,
            inUnit: NSCalendarUnit.MonthCalendarUnit,
            forDate: self.targetDate)
    }
    
    override func viewDidAppear(animated: Bool) {
        let dashboardsViewCtl : FTDashboardsViewController = self.parentViewController as FTDashboardsViewController
        dashboardsViewCtl.delegate = self;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.daysOfMonthRange.length;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as FTWorkTimesTableViewDayCell;
        
        self.cellConfigure(cell, indexPath: indexPath)

        
        return cell;
    }
    
    func cellConfigure(cell: FTWorkTimesTableViewDayCell, indexPath: NSIndexPath) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let date = self.convertFromIndexPath(indexPath)
        let predicate : NSPredicate? = NSPredicate(format: "(targetDate >= %@ ) and (targetDate < %@)", date.beginningOfDay, date.endOfDay)
        let workTime : WorkTime? = WorkTime.MR_findFirstWithPredicate(predicate) as WorkTime?
        
        cell.startTimeLabel.text = workTime?.startTime?.timeHuman()
        cell.endTimeLabel.text = workTime?.endTime?.timeHuman()
        cell.dayLabel.text = NSString(format: "%02d日", date.day)
        cell.wdayLabel.text = "\(date.week().name())"
        cell.totalTimeLabel.text = workTime?.totalTimeHuman()
        cell.overtimeLabel.text = workTime?.overTimeHuman()
        
        cell.dayLabel.textColor = date.week().color()
        cell.wdayLabel.textColor = date.week().color()
    }
    
    func convertFromIndexPath(indexPath: NSIndexPath) -> NSDate {
        let components = NSDateComponents()
        let targetCompornent = self.currentCalendar.components(NSCalendarUnit.YearCalendarUnit | NSCalendarUnit.MonthCalendarUnit, fromDate: self.targetDate)
        
        components.year = targetCompornent.year
        components.month = targetCompornent.month
        components.day = indexPath.row + 1
        
        return self.currentCalendar.dateFromComponents(components)!
    }

    func updatedStartTime(targetDate: NSDate, startTime: NSDate) {
        self.updateTableViewFromDate(targetDate)
    }
    
    func updatedEndTime(targetDate: NSDate, endTime: NSDate) {
        self.updateTableViewFromDate(targetDate)
    }
    
    func updateTableViewFromDate(date: NSDate) {
        let indexPath : NSIndexPath = NSIndexPath(forRow: date.day - 1, inSection: 0)
        
        self.tableView.beginUpdates()
        self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        self.tableView.endUpdates()
    }
}
