//
//  BaseScene.swift
//  Apollo Super Pet
//
//  Created by Orchid_Code on 02.07.2025.
//
import SpriteKit
import GameplayKit

class BaseScene: SKScene {
    
    let background = SKSpriteNode(imageNamed: "background_with_clouds")
    let statsButton = SKSpriteNode(imageNamed: "statsButton")
    let foodButton = SKSpriteNode(imageNamed: "foodButton")
    let playButton = SKSpriteNode(imageNamed: "playButton")
    let docButton = SKSpriteNode(imageNamed: "docButton")
    let studyButton = SKSpriteNode(imageNamed: "studyButton")
    
    var upperButtons: [SKSpriteNode] = []
    
    var selectionPointer = SKSpriteNode(imageNamed: "pointer")
    var currentIndex = 0
    var items: [SKSpriteNode] = []
    var itemIsChosen: Bool = false
    var itemIsConfirmed: Bool = false
    var lastTapTime: TimeInterval = 0
    let doubleTapThreshold: TimeInterval = 0.3
    var chosenItem: SKSpriteNode?
    var playerTouchedUpperScreen = false
    var playerTouchesMidScreen = false
    var playerSwipedUp = false
    var touchStartPoint: CGPoint?
    var touchEndPoint: CGPoint?
    
    /*___________________________section with variables ends here ________________________________*/
    
    
    /* all about touch recognition and touch controls */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self)
        touchStartPoint = location
        
        playerTouchedUpperScreen = location.y > size.height * (2.0/3.0)
        
      
        
        if foodButton.contains(location) {
            
            let foodScene = Food(size: self.size)
            self.view?.presentScene(foodScene)
            return
        }
        
        
        if statsButton.contains(location) {
            let stats = Stats(size: self.size)
            self.view?.presentScene(stats)
            return
            
        }
        
    }
    /*_________________ TOUCHES ENDED___________________*/
    override func touchesEnded (_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        
        let location = touch.location (in: self)
        touchEndPoint = location
        
        /*____ALL ABOUT SWIPE UP_____*/
        let swipeEnd = touch.location(in: self)
        
        guard let swipeStart = touchStartPoint else { return }
        
        let swipePointsDifference = swipeEnd.y - swipeStart.y
        
        let playerSwipedUp = swipePointsDifference > 50
      
        
        if playerSwipedUp && selectionPointer.contains(swipeStart) {
            (self as? Food)?.eatTheFood()
            itemIsConfirmed = true
           print ("Yay, they swiped up to choose a food!")
            return
        }
        
        /*____ALL ABOUT TOUCHING DIFFERENT SCREEN PARTS_____*/
        
        playerTouchesMidScreen = location.y > size.height/4 && location.y < (size.height * 2/3)
      
        
        
        if playerTouchesMidScreen {
            currentIndex += 1
            pointer()
            print("index has been increased to \(currentIndex)")
           
            
            
          //  if selectionPointer.contains(location) && playerSwipedUp {
                
            //    print ("poo poo pee pee, player confirmed the food")
              //  return
            //}
            
           
        }
    }
        
        /*______________________________________________________________________________*/
        
        override func didMove(to view: SKView) {
            super.didMove(to: view)
            upperButtons = [statsButton, foodButton, playButton, docButton, studyButton]
            setupCommonElements()
            
            // this is where debug stuff would go
            //DebugStuff.highlightOverlay(on: self)
            
            showDebugGrid()
        }
        
        func pointer() {
        guard !items.isEmpty else { return }

            if currentIndex >= items.count {
                currentIndex = 0
            }
            
            chosenItem = items[currentIndex]
            itemIsChosen = true
           // print("this item has been chosen")
            
            guard let chosenItem = chosenItem else { return }
            
            var pointerPosition = CGPoint(x: chosenItem.position.x, y: chosenItem.position.y)
            
            switch currentIndex {
                
            case 0:
                pointerPosition.x += 0
            case 1:
                pointerPosition.x += 180
            case 2:
                pointerPosition.x -= 15
            case 3:
                pointerPosition.x += 98
            case 4:
                pointerPosition.x += 236
            default:
                pointerPosition.x += 0
                
            }
            
            
            selectionPointer.position = pointerPosition
            //print("Current index:", currentIndex)
           // print ("player chose \(chosenItem)")
            
            for (index, item) in items.enumerated() {
                
                if currentIndex > 1 {
                    item.isHidden = !(2...4).contains(index)
                } else {
                    item.isHidden = index >= 2
                }
            }
            
            if selectionPointer.parent == nil {
                addChild(selectionPointer)
                selectionPointer.zPosition = 5
                selectionPointer.setScale(self.size.width / selectionPointer.size.width)
                
                
            }
            
            
        }
        
        func setupCommonElements() {
            //set up that background with clouds
            background.position = CGPoint(x: size.width / 2, y: size.height / 2)
            background.setScale(0.65)
            background.zPosition = -5
            if background.parent == nil {
                addChild(background)
                
                //setup the upper buttons, add the lower ones later
                let buttonWidth = size.width * 0.12
                let buttonSize = CGSize(width: buttonWidth, height: buttonWidth)
                let buttonSpacing = size.width * 0.05
                
                let totalButtonWidth = CGFloat(upperButtons.count) * buttonSize.width
                let totalSpacing = CGFloat(upperButtons.count - 1) * buttonSpacing
                let totalWidth = totalButtonWidth + totalSpacing
                let startX = (size.width - totalWidth) / 1.32
                
                for (index, button) in upperButtons.enumerated() {
                    button.size = buttonSize
                    let x = startX + CGFloat(index) * (buttonSize.width + buttonSpacing)
                    let y = size.height - (buttonSize.height * 3)
                    button.position = CGPoint(x: x, y: y)
                    button.zPosition = 1
                    for button in upperButtons {
                        if button.parent == nil {
                            addChild(button)
                        }
                    }
                }
            }
        }
        
        func showDebugGrid(cellSize: CGFloat = 14) {
            let columns = Int(size.width / cellSize)
            let rows = Int(size.height / cellSize)
            for col in 0...columns {
                let x = CGFloat(col) * cellSize
                let path = CGMutablePath()
                path.move(to: CGPoint(x: x, y: 0))
                path.addLine(to: CGPoint(x: x, y: size.height))
                
                let line = SKShapeNode(path: path)
                line.strokeColor = .systemPink
                line.lineWidth = 0.5
                line.zPosition = 1000
                addChild(line)
            }
            
            for row in 0...rows {
                let y = CGFloat(row) * cellSize+1
                let path = CGMutablePath()
                path.move(to: CGPoint(x: 0, y: y))
                path.addLine(to: CGPoint(x: size.width, y: y))
                
                let line = SKShapeNode(path: path)
                line.strokeColor = .systemPink
                line.lineWidth = 0.5
                line.zPosition = 1000
                addChild(line)
            }
        }
    }
