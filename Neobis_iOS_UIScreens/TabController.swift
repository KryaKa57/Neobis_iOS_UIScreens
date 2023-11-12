//
//  TabController.swift
//  Neobis_iOS_UIScreens
//
//  Created by Alisher on 12.11.2023.
//

import Foundation
import UIKit

class TabController: UITabBarController {
    override func viewDidLoad() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        super.viewDidLoad()
        self.setUpTabs()
    }
    
    private func setUpTabs() {
        let crypt = self.createNav(with: "Crypt", and: UIImage(named: "Bitcoin"), vc: CryptViewController())
        let finance = self.createNav(with: "Finance", and: UIImage(systemName: "dollarsign.circle"), vc: FinanceViewController())
        let travel = self.createNav(with: "Travel", and: UIImage(systemName: "airplane.departure"), vc: TravelViewController())
        let singles = self.createNav(with: "Singles", and: UIImage(systemName: "s.circle"), vc: SinglesViewController())
     
        self.setViewControllers([crypt, finance, travel, singles], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }
}
