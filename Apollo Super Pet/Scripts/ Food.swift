import SpriteKit
import GameplayKit

protocol AllFoods {
    var foodName: String { get }
    var foodAnimationFrames: [SKTexture] { get }
    var foodNode: SKSpriteNode  { get }
    var reducesHunger: Bool { get }
    var makesSick: Bool { get }
    var increasesHappiness: Bool { get }
    func foodIsBeingEaten(on node: SKSpriteNode) // this would only define the animation of the food as creature eats it - the creature will be animated separately
}

extension AllFoods {
    func foodIsBeingEaten(on node: SKSpriteNode) {
        let foodEatenAnim = SKAction.animate (with: foodAnimationFrames, timePerFrame: 0.8 )
        node.run(foodEatenAnim)
        //add the food being eaten animation here
    }
}

struct MainCourse: AllFoods {
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

struct HotDog: AllFoods {
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

struct Apple: AllFoods {
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
    
struct IceCream: AllFoods {
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

struct Drink: AllFoods {
    var foodName: String = "Drink"
    var foodAnimationFrames: [SKTexture] = (0...2).map {SKTexture(imageNamed: "drink\($0)")}
    var foodNode: SKSpriteNode
    
    // this sets the appearance of a food to the first frame of the animation, basically gives the in-game foods the way they look
    init() {
        foodNode = SKSpriteNode(texture: foodAnimationFrames.first)
    }
    
    var reducesHunger: Bool = false
    var makesSick: Bool = false
    var increasesHappiness: Bool = false
}

class Food: BaseScene {
    
    var activeCharacter: SKSpriteNode!
    
    // the properties to store the foods - so that when I remove them from parent later, it would surely be the same thing; the stuff created in the function needs to be stored somewhere and it's in these:
    
    var mainCourse: SKSpriteNode!
    var hotdog: SKSpriteNode!
    var apple: SKSpriteNode!
    var iceCream: SKSpriteNode!
    var drink: SKSpriteNode!
    
    // need variable names to make it clear this is only what the foods look like, imagining it as images of food on a canteen menu :)
    
    let mainCoursePicture = SKSpriteNode(imageNamed: "meal0")
    let hotdogPicture = SKSpriteNode(imageNamed: "hotdog0")
    let applePicture = SKSpriteNode(imageNamed: "apple0")
    let iceCreamPicture = SKSpriteNode(imageNamed: "iceCream0")
    let drinkPicture = SKSpriteNode(imageNamed: "drink0")
    
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
        
        
    }
    
    func setTheTable() {
        
        removeAllChildren()
        setupCommonElements()
        pointer()
        
        
        // make an array with all foods, if the index is more than 1 - hide main course and hotdog and show others; define when a food is selected and when it is confirmed
        
        addChild(mainCoursePicture)
        print("main course has been added but it's just a picture!")
        //mainCourse.foodNode.position = CGPoint(x: size.width / 3.3, y: size.height / 2.33)
        mainCoursePicture.position = CGPoint(x: 197, y: 350)
        mainCoursePicture.zPosition = 10
        
        mainCoursePicture.setScale(self.size.width / mainCoursePicture.size.width)
        mainCoursePicture.isHidden = false
        
        addChild(hotdogPicture)
        print("Hotdog has been added and it's just a picture!")
        hotdogPicture.position = CGPoint(x: 197, y: 350)
        hotdogPicture.zPosition = 11
        
        hotdogPicture.setScale(self.size.width / hotdogPicture.size.width)
        hotdogPicture.isHidden = false
        
        addChild(applePicture)
        print("apple has been added and it's also just a pic!")
        applePicture.position = CGPoint(x: 197, y: 350)
        applePicture.zPosition = 12
        
        applePicture.setScale(self.size.width / applePicture.size.width)
        applePicture.isHidden = true
        
        addChild(iceCreamPicture)
        print("ice cream has been added - yes, it's also just a pic on a menu!")
        iceCreamPicture.position = CGPoint(x: 197, y: 350)
        iceCreamPicture.zPosition = 13
        
        iceCreamPicture.setScale(self.size.width / iceCreamPicture.size.width)
        iceCreamPicture.isHidden = true
        
        addChild(drinkPicture)
        print("drink has been added, just a drawing!")
        drinkPicture.position = CGPoint(x: 197, y: 350)
        drinkPicture.zPosition = 14
        
        drinkPicture.setScale(self.size.width / drinkPicture.size.width)
        drinkPicture.isHidden = true
        
        items = [mainCoursePicture, hotdogPicture, applePicture, iceCreamPicture, drinkPicture]
        
        pointer()
        DebugStuff.highlightOverlay(on: self)
        showDebugGrid()
        
    }
    
    func eatTheFood() {
        
        mainCoursePicture.removeFromParent()
        hotdogPicture.removeFromParent()
        applePicture.removeFromParent()
        iceCreamPicture.removeFromParent()
        drinkPicture.removeFromParent()
        
        let characterNow = CharacterManager.shared.setupIdleCharacter()
        let hungryCharSprite = SKSpriteNode(texture: characterNow.eatingFrames.first)
        hungryCharSprite.position = CGPoint(x: 197, y: 350)
        hungryCharSprite.setScale(self.size.width / hungryCharSprite.size.width)
        hungryCharSprite.zPosition = 3
        addChild(hungryCharSprite)
        
        characterNow.eatingAnim(on: hungryCharSprite)
        
        if playerSwipedUp {
            eatTheFood()
        }
        
    }
}
