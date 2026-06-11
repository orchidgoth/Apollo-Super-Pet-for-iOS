import SpriteKit
import GameplayKit

protocol AllFoods {
    var foodName: String { get }
    var foodAnimationFrames: [SKTexture] { get }
    var foodSpriteNode: SKSpriteNode  { get }
    var reducesHunger: Bool { get }
    var makesSick: Bool { get }
    var increasesHappiness: Bool { get }
    func foodIsBeingEaten(on node: SKSpriteNode, in scene: Food) // this would only define the animation of the food as creature eats it - the creature will be animated separately
}

extension AllFoods {
    func foodIsBeingEaten(on node: SKSpriteNode, in scene: Food) {
        
        var startingPoint: CGPoint
    
        switch foodName {
            
        case MainCourse().foodName:
            startingPoint = CGPoint (x: scene.size.width / 2.3, y: scene.size.height / 2.23)
            
        case HotDog().foodName:
            startingPoint = CGPoint (x: 0, y: scene.size.height / 2.16)
            
        case Apple().foodName:
            startingPoint = CGPoint (x: scene.size.width / 2, y: scene.size.height / 2.23)
            
        case IceCream().foodName:
            startingPoint = CGPoint (x: scene.size.width / 4, y: scene.size.height / 2.16)
            
        case Drink().foodName:
            startingPoint = CGPoint (x: -60, y: scene.size.height / 2.23)
            
        default:
            startingPoint = CGPoint (x: scene.size.width / 2.53, y: scene.size.height / 2.23)
            
        }
        
        node.position = startingPoint
        
        let serveFood = SKAction.moveTo(y: node.position.y - scene.size.height / 6, duration: 0)
                            let waitForFood  = SKAction.wait(forDuration: 0.4)
                            let eatFood = SKAction.animate(with: foodAnimationFrames, timePerFrame: 0.6)
                            let foodAnimation = SKAction.sequence([waitForFood, serveFood, eatFood, waitForFood])
                            
        node.run(foodAnimation)
        //add the food being eaten animation here
    }
}

struct MainCourse: AllFoods {
    var foodName: String = "Meal"
    var foodAnimationFrames: [SKTexture] = (0...2).map { SKTexture(imageNamed: "meal\($0)")}
    var foodSpriteNode: SKSpriteNode
    
    init() {
        foodSpriteNode = SKSpriteNode(texture: foodAnimationFrames.first)
    }
    
    var reducesHunger: Bool = true
    var makesSick: Bool = false
    var increasesHappiness: Bool = false
    }

struct HotDog: AllFoods {
    var foodName: String = "Hotdog"
    var foodAnimationFrames: [SKTexture] = (0...2).map { SKTexture(imageNamed: "hotdog\($0)")}
    var foodSpriteNode: SKSpriteNode
    init() {
        foodSpriteNode = SKSpriteNode(texture: foodAnimationFrames.first)
    }
    var reducesHunger: Bool = false
    var makesSick: Bool = false
    var increasesHappiness: Bool = true
}

struct Apple: AllFoods {
    var foodName: String = "Apple"
    var foodAnimationFrames: [SKTexture] = (0...2).map {SKTexture(imageNamed: "apple\($0)")}
    var foodSpriteNode: SKSpriteNode
    
    init() {
        foodSpriteNode = SKSpriteNode(texture: foodAnimationFrames.first)
    }
    
    var reducesHunger: Bool = false
    var makesSick: Bool = false
    var increasesHappiness: Bool = true
}
    
struct IceCream: AllFoods {
    var foodName: String = "IceCream"
    var foodAnimationFrames: [SKTexture] = (0...2).map {SKTexture(imageNamed: "iceCream\($0)")}
    var foodSpriteNode: SKSpriteNode
    
    init() {
        foodSpriteNode = SKSpriteNode(texture: foodAnimationFrames.first)
    }
    
    var reducesHunger: Bool = false
    var makesSick: Bool = true
    var increasesHappiness: Bool = true
}

struct Drink: AllFoods {
    var foodName: String = "Drink"
    var foodAnimationFrames: [SKTexture] = (0...2).map {SKTexture(imageNamed: "drink\($0)")}
    var foodSpriteNode: SKSpriteNode
    
    // this sets the appearance of a food to the first frame of the animation, basically gives the in-game foods the way they look
    init() {
        foodSpriteNode = SKSpriteNode(texture: foodAnimationFrames.first)
    }
    
    var reducesHunger: Bool = false
    var makesSick: Bool = false
    var increasesHappiness: Bool = false
}

class Food: BaseScene {
    
    var activeCharacter: SKSpriteNode!
    
    // the properties to store the foods - so that when I remove them from parent later, it would surely be the same thing; the stuff created in the function needs to be stored somewhere and it's in these:
    
    let mainCourse = MainCourse()
    let hotdog = HotDog()
    let apple = Apple()
    let iceCream = IceCream()
    let drink = Drink()
    
    var foods: [AllFoods] = []
    
    
    // need variable names to make it clear this is only what the foods look like, imagining it as images of food on a canteen menu :)
    
   
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
        
        foods = [mainCourse, hotdog, apple, iceCream, drink] // variables that refer to food structs with all info
       
        items = foods.map {$0.foodSpriteNode}
       // just the images of foods
        currentIndex = 0
        
        mainCourse.foodSpriteNode.setScale(1.0)
        hotdog.foodSpriteNode.setScale(1.0)
        apple.foodSpriteNode.setScale(1.0)
        iceCream.foodSpriteNode.setScale(1.0)
        drink.foodSpriteNode.setScale(1.0)
        
        
        // make an array with all foods, if the index is more than 1 - hide main course and hotdog and show others; define when a food is selected and when it is confirmed
        
        addChild(mainCourse.foodSpriteNode)
        print("main course has been added but it's just a picture!")
        //mainCourse.foodNode.position = CGPoint(x: size.width / 3.3, y: size.height / 2.33)
        mainCourse.foodSpriteNode.position = CGPoint(x: 197, y: 350)
        mainCourse.foodSpriteNode.zPosition = 10
        mainCourse.foodSpriteNode.setScale(self.size.width / mainCourse.foodSpriteNode.size.width)
        mainCourse.foodSpriteNode.isHidden = false
        
        addChild(hotdog.foodSpriteNode)
        print("Hotdog has been added and it's just a picture!")
        hotdog.foodSpriteNode.position = CGPoint(x: 197, y: 350)
        hotdog.foodSpriteNode.zPosition = 11
        hotdog.foodSpriteNode.setScale(self.size.width / hotdog.foodSpriteNode.size.width)
        hotdog.foodSpriteNode.isHidden = false
        
        addChild(apple.foodSpriteNode)
        print("apple has been added and it's also just a pic!")
        apple.foodSpriteNode.position = CGPoint(x: 197, y: 350)
        apple.foodSpriteNode.zPosition = 12
        apple.foodSpriteNode.setScale(self.size.width / apple.foodSpriteNode.size.width)
        apple.foodSpriteNode.isHidden = true
        
        addChild( iceCream.foodSpriteNode)
        print("ice cream has been added - yes, it's also just a pic on a menu!")
        iceCream.foodSpriteNode.position = CGPoint(x: 197, y: 350)
        iceCream.foodSpriteNode.zPosition = 13
        iceCream.foodSpriteNode.setScale(self.size.width /  iceCream.foodSpriteNode.size.width)
        iceCream.foodSpriteNode.isHidden = true
        
        addChild( drink.foodSpriteNode)
        print("drink has been added, just a drawing!")
        drink.foodSpriteNode.position = CGPoint(x: 197, y: 350)
        drink.foodSpriteNode.zPosition = 14
        drink.foodSpriteNode.setScale(self.size.width / drink.foodSpriteNode.size.width)
        drink.foodSpriteNode.isHidden = true
        
        
       
        
        
        pointer()
        DebugStuff.highlightOverlay(on: self)
        showDebugGrid()
        
    }
    
    func eatTheFood() {
        
        isEating = true
        
        
        selectionPointer.removeFromParent()
        mainCourse.foodSpriteNode.removeFromParent()
        hotdog.foodSpriteNode.removeFromParent()
        apple.foodSpriteNode.removeFromParent()
        iceCream.foodSpriteNode.removeFromParent()
        drink.foodSpriteNode.removeFromParent()
        
        let characterNow = CharacterManager.shared.setupIdleCharacter()
        let hungryCharSprite = SKSpriteNode(texture: characterNow.eatingFrames.first)
        hungryCharSprite.position = CGPoint(x: 197, y: 350)
        hungryCharSprite.setScale(self.size.width / hungryCharSprite.size.width)
        hungryCharSprite.zPosition = 3
        addChild(hungryCharSprite)
        
       
        
        let foodToEat = foods[currentIndex]
        let foodToEatSprite = items[currentIndex]
        foodToEatSprite.position = CGPoint(x: 197, y: 350)
        foodToEatSprite.setScale(1.0)
        foodToEatSprite.setScale(self.size.width / foodToEatSprite.size.width)
        foodToEatSprite.zPosition = 4
        addChild(foodToEatSprite)
        
        foodToEat.foodIsBeingEaten(on: foodToEatSprite, in: self)
        characterNow.eatingAnim(on: hungryCharSprite)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.isEating = false
            self.currentIndex = 0
            self.setTheTable()
        }
        
        if foodToEat.reducesHunger {
            CharacterManager.shared.hunger -= 1 }
        }
        
        }

