import Model
import CoreData

@objc(GameObject)
public class GameObject: NSManagedObject {
    static public let entityName = String(describing: GameObject.self)

    @NSManaged internal var nodeAlignment: Int
    @NSManaged public var points: Int
    @NSManaged public var winningSteak: Int
    @NSManaged public var lives: Int
    @NSManaged public var ball: BallObject?
    @NSManaged public var hoops: NSOrderedSet?

    var alignment: NodeAlignment {
        get { NodeAlignment(rawValue: nodeAlignment) ?? .center }
        set { nodeAlignment = newValue.rawValue }
    }
}
