@objc(WorkTime)
class WorkTime: _WorkTime {
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
        identifier = NSUUID().UUIDString
    }
    
    override func willSave() {
        super.willSave()
        
        self.setPrimitiveValue(self.startTime?.change(year: self.targetDate?.year, month: self.targetDate?.month, day: self.targetDate?.day, hour: nil, minute: nil, second: nil), forKey: "startTime")
        self.setPrimitiveValue(self.endTime?.change(year: self.targetDate?.year, month: self.targetDate?.month, day: self.targetDate?.day, hour: nil, minute: nil, second: nil), forKey: "endTime")
    }
    
    class func findByTargetDate(targetDate: NSDate, context: NSManagedObjectContext) -> WorkTime? {
        let predicate : NSPredicate? = NSPredicate(format: "(targetDate >= %@ ) and (targetDate < %@)", targetDate.beginningOfDay, targetDate.endOfDay)
        let workTime = WorkTime.MR_findFirstWithPredicate(predicate, inContext: context) as! WorkTime?
        
        return workTime
    }
    
    class func findOrCreateByTargetDate(targetDate: NSDate, context: NSManagedObjectContext) -> WorkTime {
        let predicate : NSPredicate? = NSPredicate(format: "(targetDate >= %@ ) and (targetDate < %@)", targetDate.beginningOfDay, targetDate.endOfDay)
        var workTime = WorkTime.MR_findFirstWithPredicate(predicate, inContext: context) as! WorkTime!
        if (workTime == nil) {
            workTime = WorkTime.MR_createInContext(context) as! WorkTime
        }
        workTime.targetDate = targetDate
        
        return workTime
    }
    
    func totalTimeHuman() -> String? {
        if (self.isAllInputed()) {
            return self.endTime?.timeIntervalSinceDateHuman(self.startTime!)
        } else {
            return nil
        }
    }
    
    func overTimeHuman() -> String? {
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
