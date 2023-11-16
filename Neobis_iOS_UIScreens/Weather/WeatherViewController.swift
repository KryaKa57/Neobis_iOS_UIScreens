//
//  WeatherScreen.swift
//  Neobis_iOS_UIScreens
//
//  Created by Alisher on 08.11.2023.
//

import Foundation
import UIKit

class WeatherViewController: UIViewController {
    let weatherImageView = UIImageView()
    let todayDataLabel = UILabel()
    let todayTemperatureLabel = UILabel()
    let todayWeatherStatusLabel = UILabel()
    
    let windImageView = UIImageView()
    let todayWindStatusLabel = UILabel()
    let todayWindStatusStackView = UIStackView()
    
    let humidityImageView = UIImageView()
    let todayHumidityStatusLabel = UILabel()
    let todayHumidityStatusStackView = UIStackView()
    let todayStatusStackView = UIStackView()
    
    let weatherInfoStackView = UIStackView()
    let weatherWeeklyButton = UIButton()
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor(rgb: 0x47BFDF).cgColor,
            UIColor(rgb: 0x4A91FF).cgColor
        ]
        gradient.locations = [0, 1]
        return gradient
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.setNavigation()
        self.initialize()
        self.setConstraints()
    }
    
    private func setNavigation() {
        let locationUIBarButton = UIBarButtonItem(image: UIImage(named: "location"), style: .plain, target: self, action: nil)
        locationUIBarButton.tintColor = .white
        
        let cityNameUIBarButton = UIBarButtonItem(title: "Бишкек", style: .plain, target: self, action: nil)
        cityNameUIBarButton.tintColor = .white
        cityNameUIBarButton.setTitleTextAttributes([ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)], for: .normal)
        
        let cityMoreUIButton = UIBarButtonItem(image: UIImage(systemName: "chevron.down"), style: .plain, target: self, action: nil)
        cityMoreUIButton.tintColor = .white
        
        self.navigationItem.leftBarButtonItems = [
            locationUIBarButton,
            cityNameUIBarButton,
            cityMoreUIButton
        ]
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "notification"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    private func initialize() {
        //view.backgroundColor = UIColor(rgb: 0x47BFDF)

        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)

        weatherImageView.image = UIImage(named: "sun-shine")
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(weatherImageView)
        
        todayDataLabel.text = "Сегодня, 26 Апрель"
        todayDataLabel.font = UIFont.systemFont(ofSize: 18)
        todayDataLabel.textColor = .white
        todayDataLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(todayDataLabel)
        
        let attributedText = NSMutableAttributedString(string: "22", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 100)])
        attributedText.append(NSAttributedString(string: "°", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 80)]))

        todayTemperatureLabel.attributedText = attributedText
        todayTemperatureLabel.textColor = .white
        todayTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        todayTemperatureLabel.layer.shadowColor = UIColor.black.cgColor
        todayTemperatureLabel.layer.shadowRadius = 3.0
        todayTemperatureLabel.layer.shadowOpacity = 0.3
        todayTemperatureLabel.layer.shadowOffset = CGSize(width: -4, height: 4)
        todayTemperatureLabel.layer.masksToBounds = false
        view.addSubview(todayTemperatureLabel)
        
        todayWeatherStatusLabel.text = "Солнечно"
        todayWeatherStatusLabel.font = UIFont.boldSystemFont(ofSize: 24)
        todayWeatherStatusLabel.textColor = .white
        todayWeatherStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(todayWeatherStatusLabel)
        
        
        windImageView.image = UIImage(named: "wind")
        windImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(windImageView)
        
        todayWindStatusLabel.text = "Ветер   |     15 km/h"
        todayWindStatusLabel.textColor = .white
        todayWindStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(todayWindStatusLabel)
        
        humidityImageView.image = UIImage(named: "humidity")
        humidityImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(humidityImageView)
        
        todayHumidityStatusLabel.text = "Дождь  |     26 %"
        todayHumidityStatusLabel.textColor = .white
        todayHumidityStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(todayHumidityStatusLabel)
        
        todayWindStatusStackView.addArrangedSubview(windImageView)
        todayWindStatusStackView.addArrangedSubview(todayWindStatusLabel)
        todayWindStatusStackView.spacing = 16.0
        todayWindStatusStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(todayWindStatusStackView)
        
        todayHumidityStatusStackView.addArrangedSubview(humidityImageView)
        todayHumidityStatusStackView.addArrangedSubview(todayHumidityStatusLabel)
        todayHumidityStatusStackView.spacing = 16.0
        todayHumidityStatusStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(todayHumidityStatusStackView)
        
        todayStatusStackView.addArrangedSubview(todayWindStatusStackView)
        todayStatusStackView.addArrangedSubview(todayHumidityStatusStackView)
        todayStatusStackView.axis = .vertical
        todayStatusStackView.spacing = 16.0
        todayStatusStackView.alignment = .leading
        todayStatusStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(todayStatusStackView)
        
        weatherInfoStackView.addArrangedSubview(todayDataLabel)
        weatherInfoStackView.addArrangedSubview(todayTemperatureLabel)
        weatherInfoStackView.addArrangedSubview(todayWeatherStatusLabel)
        weatherInfoStackView.addArrangedSubview(todayStatusStackView)
        
        weatherInfoStackView.alignment = .center
        weatherInfoStackView.distribution = .fillProportionally
        weatherInfoStackView.spacing = 16.0
        weatherInfoStackView.axis = .vertical
        weatherInfoStackView.backgroundColor = UIColor(white: 1, alpha: 0.2)
        weatherInfoStackView.layer.borderWidth = 3.0
        weatherInfoStackView.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        weatherInfoStackView.layer.cornerRadius = 20
        weatherInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        weatherInfoStackView.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        weatherInfoStackView.isLayoutMarginsRelativeArrangement = true
        view.addSubview(weatherInfoStackView)
        
        
        weatherWeeklyButton.translatesAutoresizingMaskIntoConstraints = false
        weatherWeeklyButton.setTitle("Прогноз на неделю", for: .normal)
        weatherWeeklyButton.setTitleColor(UIColor(rgb: 0x444E72), for: .normal)
        weatherWeeklyButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        weatherWeeklyButton.tintColor = UIColor(rgb: 0x444E72)
        weatherWeeklyButton.semanticContentAttribute = .forceRightToLeft
        weatherWeeklyButton.backgroundColor = .white
        weatherWeeklyButton.layer.cornerRadius = 20
        weatherWeeklyButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        weatherWeeklyButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        weatherWeeklyButton.layer.shadowColor = UIColor.black.cgColor
        weatherWeeklyButton.layer.shadowRadius = 3.0
        weatherWeeklyButton.layer.shadowOpacity = 0.1
        weatherWeeklyButton.layer.shadowOffset = CGSize(width: -5, height: 10)
        view.addSubview(weatherWeeklyButton)
        
        weatherWeeklyButton.addTarget(self, action: #selector(goToNextScreen(sender:)), for: .touchUpInside)
    }
    
    private func setConstraints() {
        self.weatherImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 0.15)
        }
        self.weatherInfoStackView.snp.makeConstraints { (make) in
            make.top.equalTo(weatherImageView.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.85)
            make.height.equalTo(weatherInfoStackView.snp.width)
        }
        self.weatherWeeklyButton.snp.makeConstraints {(make) in
            make.top.equalTo(weatherInfoStackView.snp.bottom).offset(64)
            make.bottom.equalToSuperview().inset(64)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.06)
        }
        self.todayDataLabel.snp.makeConstraints {(make) in
            make.height.equalTo(weatherInfoStackView).multipliedBy(0.1)
        }
        self.todayTemperatureLabel.snp.makeConstraints {(make) in
            make.height.equalTo(weatherInfoStackView).multipliedBy(0.3)
        }
        self.todayStatusStackView.snp.makeConstraints {(make) in
            make.height.equalTo(weatherInfoStackView).multipliedBy(0.2)
            make.left.equalTo(weatherInfoStackView).inset(UIScreen.main.bounds.width*0.15)
        }
    }
    
    @objc func goToNextScreen(sender: UIButton) {
        var nextScreen: UIViewController
        nextScreen = SecondWeatherViewController()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]
        navigationItem.backBarButtonItem?.setTitleTextAttributes(attributes, for: .normal)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.pushViewController(nextScreen, animated: true)
    }
}


