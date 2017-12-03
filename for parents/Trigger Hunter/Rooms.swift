//
//  Trigger.swift
//  Trigger Hunter
//
//  Created by Cal Stephens on 12/3/17.
//  Copyright © 2017 Mobile & Ubiquitous Computing 2017. All rights reserved.
//

import UIKit

struct Room {
    let name: String
    let locationText: String
    let collectionViewImage: UIImage
    let triggers: [Trigger]
    
    var randomTrigger: Trigger? {
        return triggers.shuffled.first
    }
}

struct Trigger {
    let name: String
    let spawnedText: String
}

// MARK: Room + Data

extension Room {
    
    static let all = [Room.outside, .kitchen, .bedroom, .nearPet, .bathroom, .livingRoom]
    
    static let outside = Room(
        name: "Outside",
        locationText: "outside",
        collectionViewImage: #imageLiteral(resourceName: "Outside"),
        triggers: [.pollen, .smoke])
    
    static let kitchen = Room(
        name: "Kitchen",
        locationText: "in the kitchen",
        collectionViewImage: #imageLiteral(resourceName: "Kitchen"),
        triggers: []) // .cockroaches not supported on AR client
    
    static let bedroom = Room(
        name: "Bedroom",
        locationText: "in your bedroom",
        collectionViewImage: #imageLiteral(resourceName: "Bedroom"),
        triggers: [.dustMite, .mold])
    
    static let nearPet = Room(
        name: "Near a Pet",
        locationText: "near your pet",
        collectionViewImage: #imageLiteral(resourceName: "Pet"),
        triggers: [.petDander])
    
    static let bathroom = Room(
        name: "Bathroom",
        locationText: "in the bathroom",
        collectionViewImage: #imageLiteral(resourceName: "Bathroom"),
        triggers: []) // .strongSemellsFromCleaningProducts not supported on AR client
    
    static let livingRoom = Room(
        name: "Living Room",
        locationText: "in the living room",
        collectionViewImage: #imageLiteral(resourceName: "Living_Room"),
        triggers: [.dustMite, .mold])
    
}

// MARK: Trigger + Data

extension Trigger {
    
    static let pollen = Trigger(name: "Pollen", spawnedText: "pollen")
    static let smoke = Trigger(name: "Smoke", spawnedText: "smoke")
    static let dustMite = Trigger(name: "Dust Mite", spawnedText: "a dust mite")
    static let mold = Trigger(name: "Mold", spawnedText: "mold")
    static let petDander = Trigger(name: "Pet Dander", spawnedText: "pet dander")
    static let fluVirus = Trigger(name: "Flu Virus", spawnedText: "the flu virus")
    
}

// MARK: Array + Shuffled

fileprivate extension MutableCollection {
    
    // https://stackoverflow.com/questions/24026510/how-do-i-shuffle-an-array-in-swift
    
    /// Shuffles the contents of this collection in-place.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
    
    /// Shuffles the contents of this collection.
    var shuffled: Self {
        var copy = self
        copy.shuffle()
        return copy
    }
    
}
