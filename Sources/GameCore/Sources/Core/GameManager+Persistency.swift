import CoreData
import Foundation
import Persistency

extension GameManager {
    func loadPersistency() {
        gameObject = persistency.fetchObjects(with: GameObject.self).first
        scores = loadScoreObjects().map { $0.score }
    }

    func loadNewGameObject() -> GameObject {
        /// set up ball object
        let ballObject = persistency.createObject(for: BallObject.self)
        ballObject.copy(from: ball)

        /// set up hoop object
        let hoopObjects: [HoopObject] = hoops.map { hoop in
            let hoopObject = persistency.createObject(for: HoopObject.self)
            hoopObject.copy(from: hoop)
            return hoopObject
        }
        
        /// set up game object
        let gameObject = persistency.createObject(for: GameObject.self)
        gameObject.lives = lives
        gameObject.winningSteak = winningSteak
        gameObject.points = points
        gameObject.ball = ballObject
        gameObject.hoops = NSOrderedSet(array: hoopObjects)
        gameObject.nodeAlignment = alignment.rawValue

        /// write data into sqlite
        persistency.saveContext()

        return gameObject
    }

    func updateGameObject() {
        /// get mutable order set
        guard let hoopObjects = gameObject?.hoops?.mutableCopy() as? NSMutableOrderedSet else {
            return
        }

        /// get first hoop object
        guard let bucketObject = hoopObjects.firstObject as? HoopObject else {
            return
        }

        /// reposition ball
        gameObject?.ball?.copy(from: ball)

        /// remove it from array and sqlite
        hoopObjects.remove(bucketObject)
        persistency.removeObject(bucketObject)

        /// add new hoop object
        let hoopObject = persistency.createObject(for: HoopObject.self)
        hoopObjects.add(hoopObject)

        /// reposition hoops
        for (hoop, object) in zip(hoops, hoopObjects.array) {
            (object as? HoopObject)?.copy(from: hoop)
        }

        /// update game
        gameObject?.hoops = hoopObjects.mutableCopy() as? NSOrderedSet
        gameObject?.nodeAlignment = alignment.rawValue

        /// write data into sqlite
        persistency.saveContext()
    }

    func updateGamePoints() {
        gameObject?.winningSteak = winningSteak
        gameObject?.points = points

        persistency.saveContext()
    }

    func updateGameLives() {
        gameObject?.lives = lives
        gameObject?.winningSteak = winningSteak

        persistency.saveContext()
    }

    public func deleteGameObject() {
        if let gameObject {
            /// add score object
            if gameObject.points > 0 {
                let scoreObject = persistency.createObject(for: ScoreObject.self)
                scoreObject.copy(gameObject.points)
            }

            /// update list
            var scoreObjects = loadScoreObjects()
            while scoreObjects.count > 15 {
                let object = scoreObjects.removeLast()
                persistency.removeObject(object)
            }

            /// remove game object
            self.gameObject = nil
            persistency.removeObject(gameObject)
            persistency.saveContext()

            /// update scores
            self.scores = scoreObjects.map { $0.score }
        }
    }

    private func loadScoreObjects() -> [ScoreObject] {
        let scoreRequest = NSFetchRequest<ScoreObject>(entityName: ScoreObject.entityName)
        let pointSort = NSSortDescriptor(keyPath: \ScoreObject.points, ascending: false)
        let dateSort = NSSortDescriptor(keyPath: \ScoreObject.date, ascending: true)
        scoreRequest.sortDescriptors = [pointSort, dateSort]
        return persistency.fetchObjects(with: scoreRequest)
    }

    public func updateScores() {
        let scoreRequest = NSFetchRequest<ScoreObject>(entityName: ScoreObject.entityName)
        let predictate = NSPredicate(format: "%K == YES", argumentArray: [#keyPath(ScoreObject.isNew)])
        scoreRequest.predicate = predictate
        let scoreObjects = persistency.fetchObjects(with: scoreRequest)
        guard !scoreObjects.isEmpty else { return }
        for scoreObject in scoreObjects {
            scoreObject.isNew = false
        }
        self.scores = loadScoreObjects().map { $0.score }
        persistency.saveContext()
    }

    public func loadNewScoreObjectCount() -> Int {
        let scoreRequest = NSFetchRequest<ScoreObject>(entityName: ScoreObject.entityName)
        let predictate = NSPredicate(format: "%K == YES", argumentArray: [#keyPath(ScoreObject.isNew)])
        scoreRequest.predicate = predictate
        return persistency.fetchCount(with: scoreRequest)
    }
}
