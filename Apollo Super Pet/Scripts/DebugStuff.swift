//
//  DebugStuff.swift
//  Apollo Super Pet
//
//  Created by Orchid_Code on 09.12.2025.
//
import SpriteKit
import UIKit

class DebugStuff {
    static func highlightOverlay(on parent: SKNode,
                                     strokeColor: UIColor = .systemPink,
                                     fillOpacity: CGFloat = 0.3,
                                     duration: TimeInterval? = nil) {
            
            // Hardcoded size and position
            let size = CGSize(width: 390.0, height: 222.8571)
            let position = CGPoint(x: 197.0, y: 350.0)
            
            let highlight = SKShapeNode(rectOf: size)
            highlight.position = position
            highlight.strokeColor = strokeColor
            highlight.fillColor = UIColor.blue.withAlphaComponent(fillOpacity)
            highlight.zPosition = 1000

            parent.addChild(highlight)
        
    }
}
