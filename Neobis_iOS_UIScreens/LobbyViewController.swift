//
//  ViewController.swift
//  Neobis_iOS_UIScreens
//
//  Created by Alisher on 07.11.2023.
//

import UIKit

class LobbyViewController: UIViewController {

    let weatherButton = UIButton()
    let cryptoButton = UIButton()
    let financeButton = UIButton()
    let travelButton = UIButton()
    let singlesButton = UIButton()
    
    var buttons: [UIButton] = [UIButton]()
    var buttonTitles: [String] = ["weather", "crypto", "finance", "travel", "singles"]
    
    let buttonStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttons = [self.weatherButton, self.cryptoButton, self.financeButton, self.travelButton, self.singlesButton]
        setUpButtons()
        view.backgroundColor = .systemBackground
        title = "Lobby"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func setUpButtons() {
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
        
        //Constraints of stack view
        NSLayoutConstraint.activate([
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonStackView.widthAnchor.constraint(equalToConstant: 200)
            
        ])
    }
    
    @objc func goToNextScreen(sender: UIButton) {
        var nextScreen: UIViewController
        switch (sender.titleLabel?.text){
        case buttonTitles[0]:
            nextScreen = WeatherScreen()
        case buttonTitles[1]:
            nextScreen = CryptoScreen()
        case buttonTitles[2]:
            nextScreen = FinanceScreen()
        case buttonTitles[3]:
            nextScreen = TravelScreen()
        case buttonTitles[4]:
            nextScreen = SinglesScreen()
        default:
            nextScreen = WeatherScreen()
        }
        nextScreen.title = sender.titleLabel?.text ?? ""
        navigationController?.pushViewController(nextScreen, animated: true)
    }
}

