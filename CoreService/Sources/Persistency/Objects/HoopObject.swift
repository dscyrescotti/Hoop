import CoreData

@objc(HoopObject)
public class HoopObject: NSManagedObject, Entity {
    static public var entityName = String(describing: HoopObject.self)

    @NSManaged public var xPoint: CGFloat
    @NSManaged public var yPoint: CGFloat
    @NSManaged public var degree: Double
    @NSManaged public var isDynamic: Bool
    @NSManaged public var nodeAlignment: Int
    @NSManaged public var game: GameObject?
}
