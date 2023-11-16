//
//  Crypt.swift
//  Neobis_iOS_UIScreens
//
//  Created by Alisher on 09.11.2023.
//

import Foundation

struct Crypt {
    var name: String
    var growthPercent: Double
    var priceInDollar: Double
    var priceInCrypt: Double
    var currencyCrypt: String
    var logoImageName: String
    var color: Int
    
    init() {
        self.name = "Ripple"
        self.growthPercent = 0.27
        self.priceInCrypt = 16447.65
        self.priceInDollar = 5241.62
        self.currencyCrypt = "XRP"
        self.logoImageName = "iconfinder_XRP-alt_1175359"
        self.color = 0x638FFE
    }
    
    init(name: String, color: Int, growthPercent: Double, priceInDollar: Double, priceInCrypt: Double, currencyCrypt: String, logoImageName: String) {
        self.name = name
        self.growthPercent = growthPercent
        self.priceInDollar = priceInDollar
        self.priceInCrypt = priceInCrypt
        self.currencyCrypt = currencyCrypt
        self.logoImageName = logoImageName
        self.color = color
    }
}
