//
//  BrastlewarkModel.swift
//  KavakChallenge
//
//  Created by Pablo Ramirez on 6/26/19.
//  Copyright © 2019 Pablo Ramirez. All rights reserved.
//

import Foundation
import ObjectMapper

public class Gnome: Mappable {
    
    public var brastlewark: [Brastlewark] = []
    
    init(){}
    
    required public init?(map: Map){
    }
    
    public func mapping(map: Map) {
        brastlewark <- map["Brastlewark"]
    }
}

public class Brastlewark: Mappable {
    
    public var id: Int = 0
    public var name: String = ""
    public var thumbnail: String = ""
    public var age: Int = 0
    public var weight: Double = 0.0
    public var height: Double = 0.0
    public var hairColor: String = ""
    public var professions: [String] = []
    public var friends: [String] = []
    
    init(){}
    
    required public init?(map: Map){
    }
    
    public func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        thumbnail   <- map["thumbnail"]
        age         <- map["age"]
        weight      <- map["weight"]
        height      <- map["height"]
        hairColor   <- map["hairColor"]
        professions <- map["professions"]
        friends     <- map["friends"]
    }
}
