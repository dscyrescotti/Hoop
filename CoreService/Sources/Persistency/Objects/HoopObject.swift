import Model
import CoreData

@objc(HoopObject)
public class HoopObject: NSManagedObject {
    static public let entityName = String(describing: HoopObject.self)

    @NSManaged public var xPoint: CGFloat
    @NSManaged public var yPoint: CGFloat
    @NSManaged public var degree: Double
    @NSManaged public var isDynamic: Bool
    @NSManaged internal var nodeAlignment: Int
    @NSManaged public var game: GameObject?
}
