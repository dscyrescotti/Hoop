import SpriteKit
import DesignSystem

enum GameState {
    case idle
    case aim
    case shoot
    case gameOver
}

class GameBoardScene: SKScene {
    static private let ballNodeId = "gameboard.ball"

    var ballNode: SKSpriteNode?
    var trajectoryNodes: [SKShapeNode] = []

    var state: GameState = .idle
    var dragOrigin: CGPoint = .zero

    override func didMove(to view: SKView) {
        initBallNode()
        initTrajectoryNodes()
        initScene()
        startAnimationOnBallNode()
    }
}

// MARK: - SCENE
extension GameBoardScene {
    func initScene() {
        /// set up the physics body to add boundary to the scene
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
}

// MARK: - Ball
extension GameBoardScene {
    func initBallNode() {
        /// create a ball node with ball texture
        let texture = SKTexture(image: .loadImage(.basketball))
        let ballNode = SKSpriteNode(texture: texture)
        ballNode.name = GameBoardScene.ballNodeId
        ballNode.size = CGSize(width: 50, height: 50)
        ballNode.position = CGPoint(x: frame.midX, y: frame.midY)
        /// set up the physics body with bouncing behaviour
        let physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.1, size: ballNode.size)
        physicsBody.allowsRotation = true
        physicsBody.restitution = 0.4
        physicsBody.isDynamic = false
        ballNode.physicsBody = physicsBody
        addChild(ballNode)
        self.ballNode = ballNode
    }

    func startAnimationOnBallNode() {
        let scaleUp = SKAction.scale(to: 1.2, duration: 0.3)
        let scaleDown = SKAction.scale(to: 1, duration: 0.3)
        ballNode?.run(.repeatForever(.sequence([scaleUp, scaleDown])))
    }

    func stopAnimationOnBallNode() {
        ballNode?.removeAllActions()
        ballNode?.setScale(1)
    }

    func shootBall(with velocityX: CGFloat, and velocityY: CGFloat) {
        ballNode?.physicsBody?.isDynamic = true
        ballNode?.physicsBody?.applyImpulse(CGVector(dx: velocityX, dy: velocityY))
    }
}

// MARK: - TRAJECTORY
extension GameBoardScene {
    func initTrajectoryNodes() {
        for index in 0...10 {
            let radius = 5 - CGFloat(index) * 0.3
            let trajectoryNode = SKShapeNode(circleOfRadius: radius)
            let color = UIColor.red.withAlphaComponent(1 - CGFloat(index) * 0.09)
            trajectoryNode.fillColor = color
            trajectoryNode.strokeColor = color
            trajectoryNode.isHidden = true
            addChild(trajectoryNode)
            trajectoryNodes.append(trajectoryNode)
        }
    }

    func displayTrajectoryNodes(basedOn velocityX: CGFloat, and velocityY: CGFloat) {
        guard let ballNode else { return }
        for index in 0...10 {
            let time = CGFloat(index) / 2
            let accelerationX = CGFloat(0)
            let accelerationY = CGFloat(-9.8)
            let x = ballNode.position.x + time * (velocityX + 0.5 * time * accelerationX) + 0.5 * time * time * accelerationX
            let y = ballNode.position.y + time * (velocityY + 0.5 * time * accelerationY) + 0.5 * time * time * accelerationY
            trajectoryNodes[index].isHidden = false
            trajectoryNodes[index].position = CGPoint(x: x, y: y)
        }
    }

    func hideTrajectoryNodes() {
        trajectoryNodes.forEach { node in
            node.isHidden = true
        }
    }
}

// MARK: - TOUCH
extension GameBoardScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard state == .idle else { return }
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = self.atPoint(location)
        guard node.name == GameBoardScene.ballNodeId else { return }
        dragOrigin = location
        state = .aim
        stopAnimationOnBallNode()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard state == .aim else { return }
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let velocityX = (dragOrigin.x - location.x)
        let velocityY = (dragOrigin.y - location.y)
        displayTrajectoryNodes(basedOn: velocityX, and: velocityY)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard state == .aim else { return }
        guard let ballNode else { return }
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let isOutOfBall = (ballNode.frame.minX > location.x || ballNode.frame.maxX < location.x) || (ballNode.frame.minY > location.y || ballNode.frame.maxY < location.y)
        hideTrajectoryNodes()
        if isOutOfBall {
            state = .shoot
            let velocityX = (dragOrigin.x - location.x) / 1.3
            let velocityY = (dragOrigin.y - location.y) / 1.3
            shootBall(with: velocityX, and: velocityY)
        } else {
            state = .idle
            startAnimationOnBallNode()
        }
    }
}
