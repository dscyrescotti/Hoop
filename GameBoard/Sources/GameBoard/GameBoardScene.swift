import Model
import SpriteKit
import DesignSystem

class GameBoardScene: SKScene {
    // MARK: - ID
    static private let ballNodeId = "gameboard.ball"
    static private let hoopNodeId = "gameboard.hoop"

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
        let leftWallPhysicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: frame.height))
        leftWallPhysicsBody.isDynamic = false
        leftWallNode.physicsBody = leftWallPhysicsBody
        addChild(leftWallNode)
        /// add right wall
        let rightWallNode = SKNode()
        rightWallNode.position = CGPoint(x: frame.maxX + 1, y: frame.midY)
        let rightWallPhysicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: frame.height))
        rightWallPhysicsBody.isDynamic = false
        rightWallNode.physicsBody = rightWallPhysicsBody
        addChild(rightWallNode)
        /// update scale mode
        scaleMode = .aspectFit
    }

    func prepareForNextRound() {
        viewModel.prepareForNextRound(on: frame, with: ballNode?.position ?? .zero)
        ballNode?.physicsBody?.isDynamic = false
        let bucketNode = hoopNodes.removeFirst()
        bucketNode.removeFromParent()
        if let newHoop = viewModel.hoops.last {
            let hoopNode = loadHoopNode(newHoop)
            addChild(hoopNode)
            hoopNodes.append(hoopNode)
        }
        ballNode?.run(.moveTo(y: viewModel.ball.location.y, duration: 1))
        for (index, hoop) in viewModel.hoops.enumerated() {
            hoopNodes[index].run(.moveTo(y: hoop.location.y, duration: 1))
        }
        startAnimationOnBallNode()
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
        ballNode.position = viewModel.ball.location
        addChild(ballNode)
        self.ballNode = ballNode
        /// set up the physics body with bouncing behaviour
        let physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.1, size: ballNode.size)
        physicsBody.allowsRotation = true
        physicsBody.restitution = 0.4
        physicsBody.isDynamic = false
        ballNode.physicsBody = physicsBody
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
        for hoop in viewModel.hoops {
            let hoopNode = loadHoopNode(hoop)
            addChild(hoopNode)
            hoopNodes.append(hoopNode)
        }
    }

    func loadHoopNode(_ hoop: Hoop) -> SKSpriteNode {
        let texture = SKTexture(image: .loadImage(.hoop))
        let hoopNode = SKSpriteNode(texture: texture)
        hoopNode.name = GameBoardScene.hoopNodeId
        hoopNode.size = CGSize(width: 80, height: 80)
        hoopNode.position = hoop.location
        let bucketTexture = SKTexture(image: .loadImage(.hoopTexture))
        let physicsBody = SKPhysicsBody(texture: bucketTexture, size: hoopNode.size)
        physicsBody.isDynamic = false
        hoopNode.physicsBody = physicsBody
        return hoopNode
    }
}

extension GameBoardScene {
    override func update(_ currentTime: TimeInterval) {
        guard viewModel.gameState == .shoot else { return }
        guard let ballNode else { return }
        let bucketNode = hoopNodes.first {
            let frame = $0.frame
            let inner = CGRect(origin: CGPoint(x: frame.midX - 25, y: frame.midY - 25), size: ballNode.size)
            return inner.contains(ballNode.position)
        }
        if bucketNode != nil {
            viewModel.gameState = .bucket
            prepareForNextRound()
            viewModel.gameState = .idle
        } else if !frame.contains(ballNode.position) {
            viewModel.gameState = .miss
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
