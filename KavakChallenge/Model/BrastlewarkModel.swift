//
//  BrastlewarkModel.swift
//  KavakChallenge
//
//  Created by Pablo Ramirez on 6/26/19.
//  Copyright © 2019 Pablo Ramirez. All rights reserved.
//

import Foundation

class Gnome: Decodable {
    
    let brastlewark: [Brastlewark]?
    
    init(brastlewark: [Brastlewark]) {
        self.brastlewark = brastlewark
    }
}

class Brastlewark: Decodable {
    
    let id: Int?
    let name: String?
    let thumbnail: String?
    let age: Int?
    let weight, height: Double?
    let hairColor: String?
    let professions: [String]?
    let friends: [String]?
    
    init(id: Int, name: String, thumbnail: String, age: Int, weight: Double, height: Double, hairColor: String, professions: [String], friends: [String]) {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
        self.age = age
        self.weight = weight
        self.height = height
        self.hairColor = hairColor
        self.professions = professions
        self.friends = friends
    }
}
