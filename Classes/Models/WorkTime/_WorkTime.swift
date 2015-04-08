// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to WorkTime.swift instead.

import CoreData

enum WorkTimeAttributes: String {
    case endTime = "endTime"
    case identifier = "identifier"
    case overTime = "overTime"
    case startTime = "startTime"
    case targetDate = "targetDate"
    case totalTime = "totalTime"
}

@objc
class _WorkTime: NSManagedObject {

    // MARK: - Class methods

    class func entityName () -> String {
        return "WorkTime"
    }

    class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _WorkTime.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged
    var endTime: NSDate?

    // func validateEndTime(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var identifier: String?

    // func validateIdentifier(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var overTime: NSNumber?

    // func validateOverTime(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var startTime: NSDate?

    // func validateStartTime(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var targetDate: NSDate?

    // func validateTargetDate(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var totalTime: NSNumber?

    // func validateTotalTime(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    // MARK: - Relationships

}

