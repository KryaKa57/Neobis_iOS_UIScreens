//
//  Weather.swift
//  Neobis_iOS_UIScreens
//
//  Created by Alisher on 15.11.2023.
//

import Foundation

struct Weather: Hashable {
    var date: String
    var hour: String
    var statusImageName: String
    var degree: Int
    
    init() {
        self.date = ""
        self.hour = ""
        self.statusImageName = ""
        self.degree = 0
    }
    
    init(date: String, hour: String, statusImageName: String, degree: Int) {
        self.date = date
        self.hour = hour
        self.statusImageName = statusImageName
        self.degree = degree
    }
}
