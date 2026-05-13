import SpriteKit
import GameplayKit

protocol AllFoods {
    var foodName: String { get }
    var foodAnimationFrames: [SKTexture] { get }
    var foodNode: SKSpriteNode  { get }
    var reducesHunger: Bool { get }
    var makesSick: Bool { get }
    var increasesHappiness: Bool { get }
    func foodIsBeingEaten(on node: SKSpriteNode)
}

extension AllFoods {
    func foodIsBeingEaten(on node: SKSpriteNode) {
        let foodEatenAnim = SKAction.animate (with: foodAnimationFrames, timePerFrame: 0.8 )
        node.run(foodEatenAnim)
        //add the food being eaten aniation here
    }
}

struct mainCourse: AllFoods {
    var foodName: String = "Meal"
    var foodAnimationFrames: [SKTexture] = (0...2).map { SKTexture(imageNamed: "meal\($0)")}
    var foodNode: SKSpriteNode
    
    init() {
        foodNode = SKSpriteNode(texture: foodAnimationFrames.first)
    }
    
    var reducesHunger: Bool = true
    var makesSick: Bool = false
    var increasesHappiness: Bool = false
    }

struct hotDog: AllFoods {
    var foodName: String = "Hotdog"
    var foodAnimationFrames: [SKTexture] = (0...2).map { SKTexture(imageNamed: "hotdog\($0)")}
    var foodNode: SKSpriteNode
    init() {
        foodNode = SKSpriteNode(texture: foodAnimationFrames.first)
    }
    var reducesHunger: Bool = false
    var makesSick: Bool = false
    var increasesHappiness: Bool = true
}

struct apple: AllFoods {
    var foodName: String = "Apple"
    var foodAnimationFrames: [SKTexture] = (0...2).map {SKTexture(imageNamed: "apple\($0)")}
    var foodNode: SKSpriteNode
    
    init() {
        foodNode = SKSpriteNode(texture: foodAnimationFrames.first)
    }
    
    var reducesHunger: Bool = false
    var makesSick: Bool = false
    var increasesHappiness: Bool = true
}
    
struct iceCream: AllFoods {
    var foodName: String = "IceCream"
    var foodAnimationFrames: [SKTexture] = (0...2).map {SKTexture(imageNamed: "iceCream\($0)")}
    var foodNode: SKSpriteNode
    
    init() {
        foodNode = SKSpriteNode(texture: foodAnimationFrames.first)
    }
    
    var reducesHunger: Bool = false
    var makesSick: Bool = true
    var increasesHappiness: Bool = true
}

struct drink: AllFoods {
    var foodName: String = "Drink"
    var foodAnimationFrames: [SKTexture] = (0...2).map {SKTexture(imageNamed: "drink\($0)")}
    var foodNode: SKSpriteNode
    
    // this sets the appearance of a food to the first frame of the animarion, basically gives the in-game foods the way they look
    init() {
        foodNode = SKSpriteNode(texture: foodAnimationFrames.first)
    }
    
    var reducesHunger: Bool = false
    var makesSick: Bool = false
    var increasesHappiness: Bool = false
}

class Food: BaseScene {
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        
      if playerTouchedUpperScreen {
            let idleScene = GameScene(size: self.size)
            self.view?.presentScene(idleScene)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
    
    override func didMove(to view: SKView) {
        
        setupCommonElements()
        setTheTable()
        //showDebugGrid()
        
        super.didMove(to: view)
        
        func setTheTable() {
            removeAllChildren()
            setupCommonElements()
            pointer()
            
            let mainCourse = mainCourse()
            let hotdog = hotDog()
            let apple = apple()
            let iceCream = iceCream()
            let drink = drink()
            
// make an array with all foods, if the index is more than 1 - hide main course and hotdog and show others; define when a food is selected and when it is confirmed
            
            addChild(mainCourse.foodNode)
            print("main course has been added!")
            //mainCourse.foodNode.position = CGPoint(x: size.width / 3.3, y: size.height / 2.33)
            mainCourse.foodNode.position = CGPoint(x: 197, y: 350)
            mainCourse.foodNode.zPosition = 10
        
            mainCourse.foodNode.setScale(self.size.width / mainCourse.foodNode.size.width)
           mainCourse.foodNode.isHidden = false
    
            addChild(hotdog.foodNode)
            print("Hotdog has been added!")
            hotdog.foodNode.position = CGPoint(x: 197, y: 350)
            hotdog.foodNode.zPosition = 11
            
            hotdog.foodNode.setScale(self.size.width / hotdog.foodNode.size.width)
           hotdog.foodNode.isHidden = false
            
            addChild(apple.foodNode)
            print("apple has been added!")
            apple.foodNode.position = CGPoint(x: 197, y: 350)
            apple.foodNode.zPosition = 12
            
            apple.foodNode.setScale(self.size.width / apple.foodNode.size.width)
           apple.foodNode.isHidden = true
            
            addChild(iceCream.foodNode)
            print("ice cream has been added!")
            iceCream.foodNode.position = CGPoint(x: 197, y: 350)
            iceCream.foodNode.zPosition = 13
            
            iceCream.foodNode.setScale(self.size.width / iceCream.foodNode.size.width)
            iceCream.foodNode.isHidden = true
            
            addChild(drink.foodNode)
            print("drink has been added!")
            drink.foodNode.position = CGPoint(x: 197, y: 350)
            drink.foodNode.zPosition = 14
        
            drink.foodNode.setScale(self.size.width / drink.foodNode.size.width)
            drink.foodNode.isHidden = true
            
            
         items = [mainCourse.foodNode, hotdog.foodNode, apple.foodNode, iceCream.foodNode, drink.foodNode]
            
            pointer()
            DebugStuff.highlightOverlay(on: self)
            showDebugGrid()
            
            
        }
     
        func eatTheFood() {
            
        }
    }
}
