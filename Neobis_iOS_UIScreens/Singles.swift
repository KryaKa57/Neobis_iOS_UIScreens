//
//  Singles.swift
//  Neobis_iOS_UIScreens
//
//  Created by Alisher on 13.11.2023.
//

import Foundation

struct Singles {
    var name: String
    var slogan: String
    var imageName: String
    
    init() {
        self.name = ""
        self.slogan = ""
        self.imageName = ""
    }
    
    init(name: String, slogan: String, imageName: String) {
        self.name = name
        self.slogan = slogan
        self.imageName = imageName
    }
}
