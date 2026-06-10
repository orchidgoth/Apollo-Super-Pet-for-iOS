//
//  Character Manager.swift
//  Apollo Super Pet
//
//  Created by Orchid_Code on 19.11.2025.
//
class CharacterManager {
    static let shared = CharacterManager()
    private init () {}
    
    var currentCharacterStage: forAllCharacters?
    
    var hunger: Int = 4
    var happiness: Int = 0
    
    func setupIdleCharacter () -> forAllCharacters {
        //aCharacter is one that's given to this function as an initial thing
        
        let characterNow: forAllCharacters
        
        let age = currentCharacterStage?.age ?? 0
        
        switch age {
        case 0..<1:
            characterNow = babyCharacter()
            
            // case 1..3:
            //   characterNow = childCharacter()
        default:
            characterNow = babyCharacter()
            
        }
        currentCharacterStage = characterNow
        return characterNow
    }
}
