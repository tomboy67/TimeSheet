@objc(WorkTime)
class WorkTime: _WorkTime {
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
        identifier = NSUUID().UUIDString
    }
    
    class func findOrCreateByTargetDate(targetDate: NSDate, context: NSManagedObjectContext) -> WorkTime {
        let predicate : NSPredicate? = NSPredicate(format: "(targetDate >= %@ ) and (targetDate < %@)", targetDate.beginningOfDay(), targetDate.endOfDay())
        var workTime : WorkTime! = WorkTime.MR_findFirstWithPredicate(predicate, inContext: context) as WorkTime!
        if (workTime == nil) {
            workTime = WorkTime.MR_createInContext(context) as WorkTime
        }
        workTime.targetDate = targetDate
        
        return workTime
    }
}
