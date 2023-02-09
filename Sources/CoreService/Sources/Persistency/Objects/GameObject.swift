import CoreData

@objc(GameObject)
public class GameObject: NSManagedObject, Entity {
    static public var entityName = String(describing: GameObject.self)

    @NSManaged public var nodeAlignment: Int
    @NSManaged public var points: Int
    @NSManaged public var winningSteak: Int
    @NSManaged public var lives: Int
    @NSManaged public var ball: BallObject?
    @NSManaged public var hoops: NSOrderedSet?
}
