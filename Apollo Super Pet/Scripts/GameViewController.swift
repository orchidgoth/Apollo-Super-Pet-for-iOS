//
//  GameViewController.swift
//  Apollo Super Pet
//
//  Created by Orchid_Code on 02.07.2025.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene(size: view.bounds.size)  // or BaseScene if you're testing that
        scene.scaleMode = .aspectFill
        
        let skView = self.view as! SKView
        skView.presentScene(scene)
        
        
        
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.backgroundColor = .clear
    }
}
