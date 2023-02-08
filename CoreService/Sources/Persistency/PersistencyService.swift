import CoreData

public class PersistencyService {
    private let modelName: String = "Hoop"

    public init() { }

    private lazy var persistentContainer: NSPersistentContainer = {
        let persistentStore = NSPersistentStoreDescription()
        persistentStore.shouldMigrateStoreAutomatically = true
        persistentStore.shouldInferMappingModelAutomatically = true
        let container = NSPersistentContainer(name: modelName, managedObjectModel: managedObjectModel)
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
        guard let modelURL = Bundle.module.url(forResource: modelName, withExtension: ".momd"), let model = NSManagedObjectModel(contentsOf: modelURL) else {
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
}

// MARK: - Methods
public extension PersistencyService {
    func loadGameObject() -> GameObject? {
        let fetchRequest = NSFetchRequest<GameObject>(entityName: GameObject.entityName)
        do {
            let gameObject = try managedObjectContext.fetch(fetchRequest).first
            return gameObject
        } catch {
            debugPrint(error.localizedDescription)
        }
        return nil
    }

    func createObject<T: NSManagedObject>(for type: T.Type) -> T {
        return T(context: managedObjectContext)
    }

    func saveContext() {
        guard managedObjectContext.hasChanges else { return }
        do {
            try managedObjectContext.save()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }

    func removeObject(_ object: NSManagedObject) {
        managedObjectContext.delete(object)
    }

    func printOut() {
        let ballRequest = NSFetchRequest<BallObject>(entityName: BallObject.entityName)
        let hoopRequest = NSFetchRequest<HoopObject>(entityName: HoopObject.entityName)
        let gameRequest = NSFetchRequest<GameObject>(entityName: GameObject.entityName)
        do {
            let balls = try managedObjectContext.fetch(ballRequest)
            let hoops = try managedObjectContext.fetch(hoopRequest)
            let games = try managedObjectContext.fetch(gameRequest)
            print(balls, hoops, games)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}

