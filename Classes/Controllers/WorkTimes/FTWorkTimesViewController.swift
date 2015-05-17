//
//  FTWorkTimesViewController.swift
//  TimeSheet
//
//  Created by TomomuraRyota on 2015/04/04.
//  Copyright (c) 2015年 TomomuraRyota. All rights reserved.
//

import UIKit
import Timepiece


class FTWorkTimesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FTWorkTimeUpdatedDelegate, FTWorkTimesForm {
    
    var targetDate: NSDate!
    var currentCalendar: NSCalendar!
    var daysOfMonthRange: NSRange!
    
    @IBOutlet weak var tableView: UITableView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.targetDate = NSDate()
        self.currentCalendar = NSCalendar.currentCalendar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.daysOfMonthRange = self.currentCalendar.rangeOfUnit(NSCalendarUnit.CalendarUnitDay,
            inUnit: NSCalendarUnit.CalendarUnitMonth,
            forDate: self.targetDate)
    }
    
    override func viewDidAppear(animated: Bool) {
        let dashboardsViewCtl : FTDashboardsViewController = self.parentViewController as! FTDashboardsViewController
        dashboardsViewCtl.delegate = self;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.daysOfMonthRange.length;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! FTWorkTimesTableViewDayCell

        self.cellConfigure(cell, indexPath: indexPath)
        
        return cell;
    }
    
    func cellConfigure(cell: FTWorkTimesTableViewDayCell, indexPath: NSIndexPath) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let date = self.convertFromIndexPath(indexPath)
        let predicate : NSPredicate? = NSPredicate(format: "(targetDate >= %@ ) and (targetDate < %@)", date.beginningOfDay, date.endOfDay)
        let workTime : WorkTime? = WorkTime.MR_findFirstWithPredicate(predicate) as! WorkTime?
        
        cell.date = date
        cell.workTime = workTime
        
        cell.setNeedsDisplay()
    }
    
    func convertFromIndexPath(indexPath: NSIndexPath) -> NSDate {
        let components = NSDateComponents()
        let targetCompornent = self.currentCalendar.components(NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth, fromDate: self.targetDate)
        
        
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let date : NSDate = self.convertFromIndexPath(indexPath)
        
        let storyboard : UIStoryboard = UIStoryboard(name: "WorkTimes", bundle: nil)
        let workTimesFormViewCtl = storyboard.instantiateInitialViewController() as! FTWorkTimesFormViewController
        workTimesFormViewCtl.delegate = self
        workTimesFormViewCtl.targetDate = date
        
        self.navigationController?.pushViewController(workTimesFormViewCtl, animated: true)        
    }
    
    func updatedWorkTime(targetDate: NSDate, workTime: WorkTime) {
        self.updateTableViewFromDate(targetDate)
    }
}
