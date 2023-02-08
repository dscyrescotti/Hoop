import CoreData

@objc(BallObject)
public class BallObject: NSManagedObject, Entity {
    static public var entityName = String(describing: BallObject.self)

    @NSManaged public var xPoint: CGFloat
    @NSManaged public var yPoint: CGFloat
}
