import CoreData

@objc(BallObject)
public class BallObject: NSManagedObject {
    static public let entityName = String(describing: BallObject.self)

    @NSManaged public var xPoint: CGFloat
    @NSManaged public var yPoint: CGFloat
}
