//
//  Charachter.swift
//  Apollo Super Pet
//
//  Created by Orchid_Code on 17.07.2025.
//
import SpriteKit
import GameplayKit

protocol forAllCharacters {
    var idleFrames: [SKTexture] { get }
    var eatingFrames: [SKTexture] { get }
    var idlePosition: CGPoint { get }
    var customBackground: [SKTexture] { get }
    var backgroundPosition: CGPoint { get }
    //var backgroundSize: CGSize { get }
    //var happyFrames: [SKTexture] { get }
    //var sadFrames: [SKTexture] { get }
    var noEmoteFrame: SKTexture { get }
    var age: Int { get }
    var name: String { get }
    func idleMovement(on node: SKSpriteNode)
    func backgroundStarts (on node: SKSpriteNode)
    //add other things that each character has here
}

extension forAllCharacters {
    
    func idleMovement(on node: SKSpriteNode) {
           let idleAnim = SKAction.animate(with: idleFrames, timePerFrame: 0.8)
           node.run(SKAction.repeatForever(idleAnim))
       }
       
       func backgroundStarts(on node: SKSpriteNode) {
           let backgroundAnim = SKAction.animate(with: customBackground, timePerFrame: 0.02)
           node.run(backgroundAnim)
       }
       
       func eatingAnim(on node: SKSpriteNode) {
           let eatingAnim = SKAction.animate(with: eatingFrames, timePerFrame: 0.5)
           let chewingFramesRepeatTwice = SKAction.repeat(eatingAnim, count: 2)
           node.run(chewingFramesRepeatTwice)
           
       }
    }
     
struct babyCharacter: forAllCharacters {
    
    let idleFrames = (0...4).map { SKTexture(imageNamed: "BabyFace\($0)")
    }
    let eatingFrames = (0...1).map { SKTexture(imageNamed: "babyEat\($0)")
    }
    let idlePosition = CGPoint(x: 375, y: 500)
    let customBackground = (0...15).map { SKTexture(imageNamed: "BckAnim\($0)")}
    let backgroundPosition = CGPoint (x: 0.5, y: 0.5)
    let noEmoteFrame = SKTexture(imageNamed: "babyEat1")
    
    //let backgroundSize: CGSize
    //var happyFrames: [SKTexture]
    //var sadFrames: [SKTexture]
    let age: Int = 0
    let name: String = "Baby"
    //add more properties of the character here
}

//struct toddlerCharacter: forAllCharacters {
     
//}

//struct pointHead: forAllCharacters {
    
//}

//struct garlicCharacter: forAllCharacters {
    
//}

// the Character class is where I write what happens to the character when something in the game happens, like it gets fed or sick or whatever

class Character {
    //the activeCharacter is the character we currently see on the screen
    var activeCharacter: SKSpriteNode
    // the current character is the one on which stage the creature currently is - it's baby in the beginning, toddler after that, and based on care/misses after that
    var currentCharacter: forAllCharacters
    
    var currentAge: Int = 0
    var health: Int = 4
    var hunger: Int = 0
    var happiness: Int = 4
    var background: [SKTexture] = []
    var idleAnimation: [SKTexture] = []
    
    init (character: forAllCharacters, activeCharacter: SKSpriteNode) {
        self.activeCharacter = activeCharacter
        self.currentCharacter = character
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func idleMovement() {
        let idleAnim = SKAction.animate(with: currentCharacter.idleFrames, timePerFrame: 0.8)
        activeCharacter.run(SKAction.repeatForever(idleAnim))
    }
    func backgroundStarts() {
        let backgroundAnim = SKAction.animate(with: currentCharacter.customBackground, timePerFrame: 0.02)
        activeCharacter.run(backgroundAnim)
    }
    
   /* func eatingAnim() {
        let eatingAnim = SKAction.animate(with: currentCharacter.eatingFrames, timePerFrame: 0.5)
        var chewingFramesRepeatTwice = SKAction.repeat(eatingAnim, count: 2)
        activeCharacter.run(chewingFramesRepeatTwice)
        
    } */
    
    /*func sayNo() {
        
        let lookRight = SKAction.scaleX(to: -1, duration: 0.2)
        let lookLeft = SKAction.scaleX(to: 1, duration: 0.2)
        let waitBeforeTurn = SKAction.wait(forDuration: 0.2)
        let shakeHeadAnim = SKAction.sequence([lookLeft, waitBeforeTurn, lookRight])
        let sayNoAnimation = SKAction.repeat(shakeHeadAnim, count: 2)
        activeCharacter.run(sayNoAnimation)
        
    } */
}
