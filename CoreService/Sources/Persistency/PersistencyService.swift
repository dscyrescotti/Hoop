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

    private lazy var managedObjectContext: NSManagedObjectContext = {
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
    func fetchObjects<T: NSManagedObject>(with type: T.Type) -> [T] where T: Entity {
        let fetchRequest = NSFetchRequest<T>(entityName: T.entityName)
        do {
            let result = try managedObjectContext.fetch(fetchRequest)
            return result
        } catch {
            debugPrint(error.localizedDescription)
        }
        return []
    }

    func fetchObjects<T: NSManagedObject>(with fetchRequest: NSFetchRequest<T>) -> [T] {
        do {
            let result = try managedObjectContext.fetch(fetchRequest)
            return result
        } catch {
            debugPrint(error.localizedDescription)
        }
        return []
    }

    func fetchCount<T: NSManagedObject>(with fetchRequest: NSFetchRequest<T>) -> Int {
        do {
            let count = try managedObjectContext.count(for: fetchRequest)
            return count
        } catch {
            debugPrint(error.localizedDescription)
        }
        return 0
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
}

