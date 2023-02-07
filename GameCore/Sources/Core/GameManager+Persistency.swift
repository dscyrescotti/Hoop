import Foundation
import Persistency

extension GameManager {
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

        /// write data into sqlite
        persistency.saveContext()

        return gameObject
    }
}
