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
    //var chosenFood = items[currentIndex]
    
    // the properties to store the foods - so that when I remove them from parent later, it would surely be the same thing; the stuff created in the function needs to be stored somewhere and it's in these:
    
    let mainCourse = MainCourse()
    let hotdog = HotDog()
    let apple = Apple()
    let iceCream = IceCream()
    let drink = Drink()
    
   /* var mainCourse: SKSpriteNode!
    var hotdog: SKSpriteNode!
    var apple: SKSpriteNode!
    var iceCream: SKSpriteNode!
    var drink: SKSpriteNode! */
    
    
    // need variable names to make it clear this is only what the foods look like, imagining it as images of food on a canteen menu :)
    
    /* var mainCoursePicture = mainCourse.foodNode
    let hotdogPicture = SKSpriteNode(imageNamed: "hotdog0")
    let applePicture = SKSpriteNode(imageNamed: "apple0")
    let iceCreamPicture = SKSpriteNode(imageNamed: "iceCream0")
    let drinkPicture = SKSpriteNode(imageNamed: "drink0")*/
    
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
        
        mainCourse.foodNode.setScale(1.0)
        hotdog.foodNode.setScale(1.0)
        apple.foodNode.setScale(1.0)
        iceCream.foodNode.setScale(1.0)
        drink.foodNode.setScale(1.0)
        
        
        // make an array with all foods, if the index is more than 1 - hide main course and hotdog and show others; define when a food is selected and when it is confirmed
        
        addChild(mainCourse.foodNode)
        print("main course has been added but it's just a picture!")
        //mainCourse.foodNode.position = CGPoint(x: size.width / 3.3, y: size.height / 2.33)
        mainCourse.foodNode.position = CGPoint(x: 197, y: 350)
        mainCourse.foodNode.zPosition = 10
        mainCourse.foodNode.setScale(self.size.width / mainCourse.foodNode.size.width)
        mainCourse.foodNode.isHidden = false
        
        addChild(hotdog.foodNode)
        print("Hotdog has been added and it's just a picture!")
        hotdog.foodNode.position = CGPoint(x: 197, y: 350)
        hotdog.foodNode.zPosition = 11
        hotdog.foodNode.setScale(self.size.width / hotdog.foodNode.size.width)
        hotdog.foodNode.isHidden = false
        
        addChild(apple.foodNode)
        print("apple has been added and it's also just a pic!")
        apple.foodNode.position = CGPoint(x: 197, y: 350)
        apple.foodNode.zPosition = 12
        apple.foodNode.setScale(self.size.width / apple.foodNode.size.width)
        apple.foodNode.isHidden = true
        
        addChild( iceCream.foodNode)
        print("ice cream has been added - yes, it's also just a pic on a menu!")
        iceCream.foodNode.position = CGPoint(x: 197, y: 350)
        iceCream.foodNode.zPosition = 13
        iceCream.foodNode.setScale(self.size.width /  iceCream.foodNode.size.width)
        iceCream.foodNode.isHidden = true
        
        addChild( drink.foodNode)
        print("drink has been added, just a drawing!")
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
        
        isEating = true
        
        selectionPointer.removeFromParent()
        mainCourse.foodNode.removeFromParent()
        hotdog.foodNode.removeFromParent()
        apple.foodNode.removeFromParent()
        iceCream.foodNode.removeFromParent()
        drink.foodNode.removeFromParent()
        
        let characterNow = CharacterManager.shared.setupIdleCharacter()
        let hungryCharSprite = SKSpriteNode(texture: characterNow.eatingFrames.first)
        hungryCharSprite.position = CGPoint(x: 197, y: 350)
        hungryCharSprite.setScale(self.size.width / hungryCharSprite.size.width)
        hungryCharSprite.zPosition = 3
        addChild(hungryCharSprite)
        
        characterNow.eatingAnim(on: hungryCharSprite)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.isEating = false
            self.currentIndex = 0
            self.setTheTable()
        }
            
        }

        
    }
