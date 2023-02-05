import CoreData

public class PersistencyService {
    private lazy var persistentContainer: NSPersistentContainer = {
        let persistentStore = NSPersistentStoreDescription()
        persistentStore.shouldMigrateStoreAutomatically = true
        persistentStore.shouldInferMappingModelAutomatically = true
        let container = NSPersistentContainer(name: "Hoop", managedObjectModel: managedObjectModel)
        do {
            let coordinator = container.persistentStoreCoordinator
            if let oldStore = coordinator.persistentStores.first {
                try coordinator.remove(oldStore)
            }
            _ = try coordinator.addPersistentStore(type: .sqlite, at: sqliteURL)
        } catch {
            fatalError("[Error]: \(error.localizedDescription)")
        }
        container.persistentStoreDescriptions = [persistentStore]
        container.loadPersistentStores { description, error in
            if let error {
                fatalError("[Error]: \(error.localizedDescription)")
            }
        }
        return container
    }()

    public lazy var managedObjectContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()

    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.module.url(forResource: "Hoop", withExtension: ".momd"), let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("[Error]: Unable to load model.")
        }
        return model
    }()

    private lazy var sqliteURL: URL = {
        do {
            let fileURL = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            ).appendingPathComponent("Hoop.sqlite")
            return fileURL
        } catch {
            fatalError("[Error]: \(error.localizedDescription)")
        }
    }()

    public init() { }

    public func testSchema() {
        let request = NSFetchRequest<GameObject>.init(entityName: GameObject.entityName)
        do {
            let results = try managedObjectContext.fetch(request)
            let count = try managedObjectContext.count(for: request)
            print(results, count)
        } catch {
            print(error.localizedDescription)
        }
        let gameObject = GameObject(context: managedObjectContext)
        gameObject.nodeAlignment = 1
        let ballObject = BallObject(context: managedObjectContext)
        ballObject.xPoint = 50
        ballObject.yPoint = 50
        gameObject.ball = ballObject
        for i in 0..<3 {
            let hoopObject = HoopObject(context: managedObjectContext)
            hoopObject.isDynamic = .random()
            hoopObject.degree = -90 * Double(i)
            hoopObject.nodeAlignment = 1 + i
            hoopObject.yPoint = 50
            hoopObject.xPoint = 50
            let hoops = (gameObject.hoops?.mutableCopy() as? NSMutableOrderedSet) ?? .init()
            hoops.add(hoopObject)
            gameObject.hoops = hoops.copy() as? NSOrderedSet
        }
        do {
            try managedObjectContext.save()
            print("Save Game Object")
        } catch {
            print(error.localizedDescription)
        }
        do {
            let results = try managedObjectContext.fetch(request)
            let count = try managedObjectContext.count(for: request)
            print(results, count)
        } catch {
            print(error.localizedDescription)
        }

    }
}

