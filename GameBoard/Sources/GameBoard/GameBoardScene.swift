import Model
import SpriteKit
import DesignSystem

class GameBoardScene: SKScene {
    // MARK: - ID
    static private let ballNodeId = "gameboard.ball"
    static private let hoopNodeId = "gameboard.hoop"

    static private let ballCategory: UInt32 = 1 << 1
    static private let hoopCategory: UInt32 = 1 << 2

    // MARK: - PROPERTIES
    var ballNode: SKSpriteNode?
    var trajectoryNodes: [SKShapeNode] = []
    var hoopNodes: [SKSpriteNode] = []

    var dragOrigin: CGPoint = .zero

    let viewModel: GameBoardViewModel

    // MARK: - INIT
    init(_ viewModel: GameBoardViewModel) {
        self.viewModel = viewModel
        super.init(size: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func sceneDidLoad() {
        super.sceneDidLoad()
        viewModel.restartGame { [weak self] in
            self?.restartNewGame()
        }
    }
}

// MARK: - SCENE
extension GameBoardScene {
    override func didMove(to view: SKView) {
        viewModel.loadGame(on: frame)
        configureScene()
        configureBallNode()
        configureHoopNodes()
        configureTrajectoryNodes()
        startAnimationOnBallNode()
    }

    func configureScene() {
        /// add left wall
        let leftWallNode = SKNode()
        leftWallNode.position = CGPoint(x: frame.minX - 1, y: frame.midY)
        let leftWallPhysicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: frame.height * 2))
        leftWallPhysicsBody.isDynamic = false
        leftWallNode.physicsBody = leftWallPhysicsBody
        addChild(leftWallNode)
        /// add right wall
        let rightWallNode = SKNode()
        rightWallNode.position = CGPoint(x: frame.maxX + 1, y: frame.midY)
        let rightWallPhysicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: frame.height * 2))
        rightWallPhysicsBody.isDynamic = false
        rightWallNode.physicsBody = rightWallPhysicsBody
        addChild(rightWallNode)
        /// update scale mode
        scaleMode = .aspectFit
        physicsWorld.contactDelegate = self
    }

    func prepareForNextRound(_ bucketNode: SKSpriteNode) {
        ballNode?.physicsBody?.isDynamic = false
        let scaleUp = SKAction.scale(to: 1.5, duration: 0.1)
        let scaleDown = SKAction.scale(to: 1, duration: 0.2)
        ballNode?.run(.sequence([scaleUp, scaleDown, scaleUp, scaleDown]))
        var count = 0
        while true && count < 3 {
            let hoopNode = hoopNodes.removeFirst()
            hoopNode.removeFromParent()
            count += 1
            if bucketNode === hoopNode {
                break
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [weak self] in
            self?.loadNextHoop(bucketNode, count: count)
        }
    }

    func loadNextHoop(_ bucketNode: SKSpriteNode, count: Int) {
        for _ in 0..<count {
            viewModel.prepareForNextRound(on: frame, with: ballNode?.position ?? .zero)
            if let newHoop = viewModel.hoops.last {
                let hoopNode = loadHoopNode(newHoop)
                addChild(hoopNode)
                hoopNodes.append(hoopNode)
            }
        }
        let duration = 0.5 * Double(count)
        ballNode?.run(.moveTo(y: viewModel.ball.location.y, duration: duration))
        for (index, hoop) in viewModel.hoops.enumerated() {
            let moveDown = SKAction.moveTo(y: hoop.location.y, duration: duration)
            let wait = SKAction.wait(forDuration: 0.1 * Double(index + 1))
            hoopNodes[index].run(.sequence([wait, moveDown]))
        }
        self.startAnimationOnBallNode()
    }

    func restartNewGame() {
        ballNode?.removeFromParent()
        for (index, hoopNode) in hoopNodes.enumerated() {
            let wait = SKAction.wait(forDuration: 0.3 - 0.1 * Double(index))
            let moveUp = SKAction.moveTo(y: frame.maxY + 100, duration: 0.5)
            let remove = SKAction.removeFromParent()
            hoopNode.run(SKAction.sequence([wait, moveUp, remove]))
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.reloadNewGame()
        }
    }

    func reloadNewGame() {
        hoopNodes.removeAll()
        viewModel.loadGame(on: frame)
        configureBallNode()
        configureHoopNodes()
        startAnimationOnBallNode()
        viewModel.gameState = .idle
    }
}

// MARK: - Ball
extension GameBoardScene {
    func configureBallNode() {
        /// add a ball node with ball texture
        let texture = SKTexture(image: .loadImage(.basketball))
        let ballNode = SKSpriteNode(texture: texture)
        ballNode.name = GameBoardScene.ballNodeId
        ballNode.size = CGSize(width: 50, height: 50)
        ballNode.position = CGPoint(x: viewModel.ball.location.x, y: frame.maxY + 100)
        addChild(ballNode)
        self.ballNode = ballNode
        /// set up the physics body with bouncing behaviour
        let physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.1, size: ballNode.size)
        physicsBody.allowsRotation = true
        physicsBody.friction = 5
        physicsBody.restitution = 0.4
        physicsBody.isDynamic = false
        physicsBody.categoryBitMask = Self.ballCategory
        physicsBody.collisionBitMask = Self.hoopCategory
        physicsBody.contactTestBitMask = physicsBody.collisionBitMask
        ballNode.physicsBody = physicsBody
        ballNode.run(.moveTo(y: viewModel.ball.location.y, duration: 0.5))
    }

    func startAnimationOnBallNode() {
        /// animate the ball to scale up and down constantly in idle state
        let scaleUp = SKAction.scale(to: 1.2, duration: 0.3)
        let scaleDown = SKAction.scale(to: 1, duration: 0.3)
        ballNode?.run(.repeatForever(.sequence([scaleUp, scaleDown])))
    }

    func stopAnimationOnBallNode() {
        /// remove animation from the ball and reset the original scale
        ballNode?.removeAllActions()
        ballNode?.setScale(1)
    }

    /// shoot the ball with impulse force
    func shootBall(with velocityX: CGFloat, and velocityY: CGFloat) {
        ballNode?.physicsBody?.isDynamic = true
        ballNode?.physicsBody?.applyImpulse(CGVector(dx: velocityX, dy: velocityY))
    }
}

// MARK: - TRAJECTORY
extension GameBoardScene {
    func configureTrajectoryNodes() {
        /// set up  trajectory nodes
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
        /// display trajectory nodes
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
        /// hide trajectory nodes
        trajectoryNodes.forEach { node in
            node.isHidden = true
        }
    }
}

// MARK: - HOOP
extension GameBoardScene {
    func configureHoopNodes() {
        for (index, hoop) in viewModel.hoops.enumerated() {
            let hoopNode = loadHoopNode(hoop)
            addChild(hoopNode)
            hoopNodes.append(hoopNode)
            let moveDown = SKAction.moveTo(y: hoop.location.y, duration: 0.5)
            let wait = SKAction.wait(forDuration: 0.1 * Double(index + 1))
            hoopNode.run(.sequence([wait, moveDown]))
        }
    }

    func loadHoopNode(_ hoop: Hoop) -> SKSpriteNode {
        let texture = SKTexture(image: .loadImage(.hoop))
        let hoopNode = SKSpriteNode(texture: texture)
        hoopNode.name = GameBoardScene.hoopNodeId
        hoopNode.size = CGSize(width: 80, height: 80)
        hoopNode.position = CGPoint(x: hoop.location.x, y: frame.maxY + 100)
        let bucketTexture = SKTexture(image: .loadImage(.hoopTexture))
        let physicsBody = SKPhysicsBody(texture: bucketTexture, size: hoopNode.size)
        physicsBody.isDynamic = false
        physicsBody.categoryBitMask = Self.hoopCategory
        physicsBody.collisionBitMask = 0
        hoopNode.physicsBody = physicsBody
        return hoopNode
    }
}

// MARK: - UPDATE
extension GameBoardScene {
    override func update(_ currentTime: TimeInterval) {
        guard viewModel.gameState == .shoot, let ballNode else { return }
        if ballNode.position.y < 0 {
            viewModel.gameState = .miss
        }
    }
}

// MARK: - CONTACT
extension GameBoardScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        guard viewModel.gameState == .shoot else { return }
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        switch contactMask {
        case Self.ballCategory | Self.hoopCategory:
            let isBallNode = contact.bodyA.categoryBitMask == Self.ballCategory
            guard let ballNode = (isBallNode ? contact.bodyA.node : contact.bodyB.node) as? SKSpriteNode  else { return }
            guard let hoopNode = (isBallNode ? contact.bodyB.node : contact.bodyA.node) as? SKSpriteNode else { return }
            let frame = CGRect(
                origin: CGPoint(x: hoopNode.frame.midX - 20, y: hoopNode.frame.midY - 20),
                size: CGSize(width: ballNode.size.width - 10, height: ballNode.size.height - 10)
            )
            if frame.contains(ballNode.position) {
                viewModel.gameState = .bucket
                prepareForNextRound(hoopNode)
                viewModel.gameState = .idle
            }
        default:
            break
        }
    }
}

// MARK: - TOUCH
extension GameBoardScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard viewModel.gameState == .idle else { return }
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = self.atPoint(location)
        guard node.name == GameBoardScene.ballNodeId else { return }
        dragOrigin = location
        viewModel.gameState = .aim
        stopAnimationOnBallNode()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard viewModel.gameState == .aim else { return }
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let velocityX = (dragOrigin.x - location.x) / 1.3
        let velocityY = (dragOrigin.y - location.y) / 1.3
        displayTrajectoryNodes(basedOn: velocityX, and: velocityY)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard viewModel.gameState == .aim else { return }
        guard let ballNode else { return }
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        hideTrajectoryNodes()
        if ballNode.frame.contains(location) {
            viewModel.gameState = .idle
            startAnimationOnBallNode()
        } else {
            viewModel.gameState = .shoot
            let velocityX = (dragOrigin.x - location.x) / 1.65
            let velocityY = (dragOrigin.y - location.y) / 1.65
            shootBall(with: velocityX, and: velocityY)
        }
    }
}
