//
//  StatsMenu.swift
//  Apollo Super Pet
//
//  Created by Orchid_Code on 09.12.2025.
//

import SpriteKit
import GameplayKit

class Stats: BaseScene {
    
    var character: Character?
    
    let scaleFactor: CGFloat = 0.75
    let hungerIcon = SKSpriteNode(imageNamed: "bowlIcon")
    let happinessIcon = SKSpriteNode(imageNamed: "heartIcon")
    var statsBar = SKSpriteNode (imageNamed: "statsBar0")
    
    //add other infos here once you figure them out
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        
        DebugStuff.highlightOverlay(on: self)
        setupCommonElements()
        showHungerStats()
        
        func showHungerStats () {
            
            character?.hunger = max(0, min(character!.hunger,4))
            
            hungerIcon.position = CGPoint(x: size.width * 0.5, y: size.height * 0.8 - 235)
            hungerIcon.zPosition = 20
            hungerIcon.setScale(scaleFactor)
            
            addChild(hungerIcon)
            
            statsBar.setScale(scaleFactor)
            statsBar.position = CGPoint(x: size.width * 0.5, y: size.height / 4 + 110)
            
            addChild(statsBar)
            
            switch character?.hunger {
            case 4: statsBar.texture = SKTexture(imageNamed: "statsBar0")
            case 3: statsBar.texture = SKTexture(imageNamed: "statsBar1")
            case 2: statsBar.texture = SKTexture(imageNamed: "statsBar2")
            case 1: statsBar.texture = SKTexture(imageNamed: "statsBar3")
            case 0: statsBar.texture = SKTexture(imageNamed: "statsBar4")
            default: break
            }
            
        }
        
    }
}

