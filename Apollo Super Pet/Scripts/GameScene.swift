//this has been moved from earlier versions during the complete overhaul (July 2, 2025)

import SpriteKit
import GameplayKit

class GameScene: BaseScene {
    var activeCharacter = SKSpriteNode()
    var currentBackground = SKSpriteNode()
    var characterAge: Int = 0
    var characterStage: forAllCharacters?
    var currentCharacter: forAllCharacters?
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        setupCommonElements()
        
        setupCharacter()
        
    }
    
    func setupCharacter() {
        
        let characterNow = CharacterManager.shared.setupCharacter()
        
        let idleCharSprite = SKSpriteNode(texture: characterNow.idleFrames.first)
        idleCharSprite.position = CGPoint(x: 197, y: 350)
        idleCharSprite.setScale(self.size.width / idleCharSprite.size.width)
        idleCharSprite.zPosition = 3
        addChild(idleCharSprite)
        
        characterNow.idleMovement(on: idleCharSprite)
        
        
        
        let customBckSprite = SKSpriteNode(texture: characterNow.customBackground.last)
        customBckSprite.position = CGPoint(x: 197, y: 350)
        customBckSprite.setScale(self.size.width / customBckSprite.size.width)
        customBckSprite.zPosition = 2
        
        addChild(customBckSprite)
        characterNow.backgroundStarts(on: customBckSprite)
        
        // DebugStuff.highlightOverlay(on: self)
        
    }
}
