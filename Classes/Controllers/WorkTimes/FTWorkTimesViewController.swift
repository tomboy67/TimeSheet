//
//  FTWorkTimesViewController.swift
//  TimeSheet
//
//  Created by TomomuraRyota on 2015/04/04.
//  Copyright (c) 2015年 TomomuraRyota. All rights reserved.
//

import UIKit

class FTWorkTimesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var targetDate: NSDate!
    var currentCalendar: NSCalendar!
    var daysOfMonthRange: NSRange!
    
    @IBOutlet weak var tableView: UITableView!
    
    enum Week :Int {
        case Sunday = 1
        case Monday = 2
        case Tuesday = 3
        case Wednesday = 4
        case Thursday = 5
        case Friday = 6
        case Saturday = 7
        
        func name() -> String {
            switch self {
            case .Sunday: return "日"
            case .Monday: return "月"
            case .Tuesday: return "火"
            case .Wednesday: return "水"
            case .Thursday: return "木"
            case .Friday: return "金"
            case .Saturday: return "土"
            }
        }
        
        func color() -> UIColor {
            switch self {
            case .Sunday: return UIColor.redColor()
            case .Saturday: return UIColor.blueColor()
            default: return UIColor.blackColor()
            }
        }
    }
    
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
        let date = self.convertFromIndexPath(indexPath)
        let day = indexPath.row + 1
        let dayHuman = NSString(format: "%02d", day)
        
        cell.dayLabel.text = "\(dayHuman)日";
        cell.wdayLabel.text = "\(self.weekday(date).name())";
        
        cell.dayLabel.textColor = weekday(date).color()
        cell.wdayLabel.textColor = weekday(date).color()
        
        return cell;
    }
    
    func convertFromIndexPath(indexPath: NSIndexPath) -> NSDate {
        let components = NSDateComponents()
        let targetCompornent = self.currentCalendar.components(NSCalendarUnit.YearCalendarUnit | NSCalendarUnit.MonthCalendarUnit, fromDate: self.targetDate)
        
        components.year = targetCompornent.year
        components.month = targetCompornent.month
        components.day = indexPath.row + 1
        
        return self.currentCalendar.dateFromComponents(components)!
    }
    
    func weekdayNumber(date: NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        var components: NSDateComponents = calendar.components(
            NSCalendarUnit.CalendarUnitWeekday, fromDate: date)
        return components.weekday
    }
    
    func weekday(date : NSDate) -> Week {
        return Week(rawValue: self.weekdayNumber(date))!
    }
    
}
