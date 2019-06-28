//
//  DetailsViewModel.swift
//  KavakChallenge
//
//  Created by Pablo Ramirez on 6/27/19.
//  Copyright © 2019 Pablo Ramirez. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewModel{
    
    var gnome: Brastlewark!
    var image: UIImage?
    
    init() {
        
    }
    
    func getHairColor(color: String) -> UIColor{
        switch color {
        case "Red":
            return .red
        case "Yellow":
            return .yellow
        case "Blue":
            return .blue
        case "Green":
            return .green
        case "Black":
            return .black
        case "Brown":
            return .brown
        case "Gray":
            return .gray
        case "Pink":
            return UIColor(red: 255.0/255.0, green: 105.0/255.0, blue: 180.0/255.0, alpha: 1)
        case "Purple":
            return .purple
        default:
            return .white
        }
    }
}
