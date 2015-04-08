@objc(WorkTime)
class WorkTime: _WorkTime {
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
        identifier = NSUUID().UUIDString
    }
    
    class func findOrCreateByTargetDate(targetDate: NSDate, context: NSManagedObjectContext) -> WorkTime {
        let predicate : NSPredicate? = NSPredicate(format: "(targetDate >= %@ ) and (targetDate < %@)", targetDate.beginningOfDay, targetDate.endOfDay)
        var workTime : WorkTime! = WorkTime.MR_findFirstWithPredicate(predicate, inContext: context) as WorkTime!
        if (workTime == nil) {
            workTime = WorkTime.MR_createInContext(context) as WorkTime
        }
        workTime.targetDate = targetDate
        
        return workTime
    }
    
    func totalTimeHuman() -> NSString? {
        if (self.isAllInputed()) {
            return self.endTime?.timeIntervalSinceDateHuman(self.startTime!)
        } else {
            return nil
        }
    }
    
    func overTimeHuman() -> NSString? {
        if (self.isAllInputed()) {
            let regularTime : NSDate = self.targetDate!.change(year: nil, month: nil, day: nil, hour: 18, minute: 0, second: 0)
            return self.endTime!.timeIntervalSinceDateHuman(regularTime)
        } else {
            return nil
        }
    }
    
    func isAllInputed() -> Bool {
        return self.targetDate != nil && self.startTime != nil && self.endTime != nil
    }
}
