import CoreData

@objc(ScoreObject)
public class ScoreObject: NSManagedObject, Entity {
    static public var entityName = String(describing: ScoreObject.self)

    @NSManaged public var points: Int
    @NSManaged public var date: Date
    @NSManaged public var isNew: Bool
}
