//
//  PetsCardStore.swift
//  CardPetss
//
//  Created by Гранченко Максим on 12/10/18.
//  Copyright © 2018 Гранченко Максим. All rights reserved.
//

import UIKit

struct PetCardStore {
    
    static let defaultPets: [PetCard] = {
        return parsePets()
    }()
    
    private static func parsePets() -> [PetCard] {
        guard let fileURL = Bundle.main.url(forResource: "Pets", withExtension: "plist") else {
            return []
        }
        
        do {
            let petData = try Data(contentsOf: fileURL, options: .mappedIfSafe)
            let pets = try PropertyListDecoder().decode([PetCard].self, from: petData)
            return pets
        } catch {
            print(error)
            return []
        }
    }
}
