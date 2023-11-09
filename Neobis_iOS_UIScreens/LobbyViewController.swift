//
//  ViewController.swift
//  Neobis_iOS_UIScreens
//
//  Created by Alisher on 07.11.2023.
//

import UIKit
import SnapKit

class LobbyViewController: UIViewController {

    let weatherButton = UIButton()
    let cryptoButton = UIButton()
    let financeButton = UIButton()
    let travelButton = UIButton()
    let singlesButton = UIButton()
    let buttonStackView = UIStackView()
    
    var buttons: [UIButton] = [UIButton]()
    var buttonTitles: [String] = ["weather", "crypto", "finance", "travel", "singles"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttons = [self.weatherButton, self.cryptoButton, self.financeButton, self.travelButton, self.singlesButton]
        setUpButtons()
        view.backgroundColor = .systemBackground
        title = "Lobby"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setUpButtons() {
        var index = 0
        for button in buttons {
            //Configure buttons
            view.addSubview(button)
            button.configuration = .filled()
            button.configuration?.baseBackgroundColor = .black
            button.configuration?.title = buttonTitles[index]
            
            button.translatesAutoresizingMaskIntoConstraints = false
            
            buttonStackView.addArrangedSubview(button)
            index += 1
            
            button.addTarget(self, action: #selector(goToNextScreen(sender:)), for: .touchUpInside)
        }
        //Configure stack view of buttons
        view.addSubview(buttonStackView)
        buttonStackView.alignment = .fill
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 16.0
        buttonStackView.axis = .vertical
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.buttonStackView.snp.makeConstraints { [weak self] (make) in
            guard self != nil else { return }
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
        }
    }
    
    @objc func goToNextScreen(sender: UIButton) {
        var nextScreen: UIViewController
        switch (sender.titleLabel?.text){
        case buttonTitles[0]:
            nextScreen = WeatherScreen()
        case buttonTitles[1]:
            nextScreen = CryptScreen()
        case buttonTitles[2]:
            nextScreen = FinanceScreen()
        case buttonTitles[3]:
            nextScreen = TravelScreen()
        case buttonTitles[4]:
            nextScreen = SinglesScreen()
        default:
            nextScreen = WeatherScreen()
        }
        navigationController?.pushViewController(nextScreen, animated: true)
    }
}

