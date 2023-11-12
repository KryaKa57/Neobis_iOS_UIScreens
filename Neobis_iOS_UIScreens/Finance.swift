//
//  Finance.swift
//  Neobis_iOS_UIScreens
//
//  Created by Alisher on 12.11.2023.
//

import Foundation

struct Finance {
    var category: String
    var price: Double
    var lastPurchase: String
    var logoImageName: String
    var color: Int
    
    init() {
        self.category = ""
        self.price = 0
        self.lastPurchase = ""
        self.logoImageName = "heart"
        self.color = 0xC141CC
    }
    
    init(category: String, color: Int?, price: Double, lastPurchase: String, logoImageName: String?) {
        self.category = category
        self.price = price
        self.lastPurchase = lastPurchase
        self.logoImageName = logoImageName ?? "heart"
        self.color = color ?? 0xC141CC
    }
}
