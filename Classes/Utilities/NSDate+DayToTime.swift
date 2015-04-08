extension NSDate {
    
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
    
    func timeHuman() -> String? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.stringFromDate(self)
    }
    
    func timeIntervalSinceDateWithRound(date: NSDate) -> Double! {
        let interval : NSTimeInterval = self.timeIntervalSinceDate(date)
        return Double(interval / 10 * 10)
    }
    
    func timeIntervalSinceDateHuman(date: NSDate) -> String! {
        let interval : Double = self.timeIntervalSinceDateWithRound(date)
        
        if (interval > 0) {
            let formatter = NSDateComponentsFormatter()
            
            formatter.unitsStyle = NSDateComponentsFormatterUnitsStyle.Positional
            formatter.zeroFormattingBehavior = NSDateComponentsFormatterZeroFormattingBehavior.allZeros
            formatter.allowedUnits = NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute
            
            return formatter.stringFromTimeInterval(interval)
        } else {
            return "0:00"
        }
    }
    
    func week() -> Week {
        return Week(rawValue: self.weekday)!
    }
}