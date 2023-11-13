//
//  City.swift
//  Neobis_iOS_UIScreens
//
//  Created by Alisher on 13.11.2023.
//

import Foundation

struct City {
    var name: String
    var imageName: String
    
    init() {
        self.name = "ABU DHABI"
        self.imageName = "abu-dhabi"
    }
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}
