//
//  SecondWeatherViewControl.swift
//  Neobis_iOS_UIScreens
//
//  Created by Alisher on 15.11.2023.
//

import Foundation
import UIKit

class SecondWeatherViewController: UIViewController {
    private lazy var todayLabel: UILabel = {
        let label = UILabel()
        label.text = "Сегодня"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let todayDataLabel = UILabel()
    private let todayDataStackView = UIStackView()
    
    private let hourlyLayoutCollectionView = UICollectionViewFlowLayout()
    private var hourlyRateCollectionView: UICollectionView?
    
    private let dailyLayoutCollectionView = UICollectionViewFlowLayout()
    private var dailyRateCollectionView: UICollectionView?
    
    var timerForShowScrollIndicator: Timer?
    let scrollView = UIScrollView()
    
    private lazy var footerButton: UIButton = {
        let button = UIButton()
        let attributedText = NSMutableAttributedString(string: "AccuWeather", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        button.setTitleColor(.white, for: .normal)
        button.setAttributedTitle(NSAttributedString(attributedString: attributedText), for: .normal)
        button.setImage(UIImage(systemName: "sun.max.fill"), for: .normal)
        button.tintColor = .white
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
    
    var weatherData: [Weather] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillInTheData()
        self.setNavigation()
        self.initialize()
        self.setConstraints()
        startTimerForShowScrollIndicator()
    }
    
    private func setNavigation() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    private func fillInTheData() {
        weatherData.append(Weather(date: "Апр, 26", hour: "15.00", statusImageName: "cloudy-sunny", degree: 29))
        weatherData.append(Weather(date: "Апр, 26", hour: "16.00", statusImageName: "cloudy-sunny", degree: 26))
        weatherData.append(Weather(date: "Апр, 26", hour: "17.00", statusImageName: "cloudy", degree: 24))
        weatherData.append(Weather(date: "Апр, 26", hour: "18.00", statusImageName: "cloudy-night", degree: 23))
        weatherData.append(Weather(date: "Апр, 26", hour: "19.00", statusImageName: "cloudy-night", degree: 22))
        
        weatherData.append(Weather(date: "Апр, 26", hour: "-", statusImageName: "rainy-thunder", degree: 21))
        weatherData.append(Weather(date: "Апр, 27", hour: "-", statusImageName: "cloudy", degree: 22))
        weatherData.append(Weather(date: "Апр, 28", hour: "-", statusImageName: "sunny", degree: 34))
        weatherData.append(Weather(date: "Апр, 29", hour: "-", statusImageName: "cloudy", degree: 27))
        weatherData.append(Weather(date: "Апр, 30", hour: "-", statusImageName: "cloudy-sunny", degree: 32))
        weatherData.append(Weather(date: "Май, 1", hour: "-", statusImageName: "cloudy", degree: 29))
        weatherData.append(Weather(date: "Май, 2", hour: "-", statusImageName: "rainy", degree: 24))
        weatherData.append(Weather(date: "Май, 3", hour: "-", statusImageName: "rainy", degree: 22))
        weatherData.append(Weather(date: "Май, 4", hour: "-", statusImageName: "rainy-thunder", degree: 21))
        weatherData.append(Weather(date: "Май, 5", hour: "-", statusImageName: "sunny", degree: 28))
        weatherData.append(Weather(date: "Май, 6", hour: "-", statusImageName: "sunny", degree: 31))
        weatherData.append(Weather(date: "Май, 7", hour: "-", statusImageName: "cloudy-sunny", degree: 27))
    }
    
    private func initialize() {
        //view.backgroundColor = UIColor(rgb: 0x47BFDF)

        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)
        
        view.addSubview(todayDataLabel)
        
        todayDataLabel.text = "Апр, 26"
        todayDataLabel.font = UIFont.systemFont(ofSize: 18)
        todayDataLabel.textColor = .white
        todayDataLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(todayDataLabel)
        
        todayDataStackView.addArrangedSubview(todayLabel)
        todayDataStackView.addArrangedSubview(todayDataLabel)
        view.addSubview(todayDataStackView)
        
        hourlyLayoutCollectionView.scrollDirection = .horizontal
        hourlyLayoutCollectionView.itemSize = CGSize(width: view.frame.size.width * 0.15, height: view.frame.size.height * 0.15)
        
        hourlyRateCollectionView = UICollectionView(frame: .zero, collectionViewLayout: hourlyLayoutCollectionView)
        guard let hourlyRateCollectionView = hourlyRateCollectionView else {
            return
        }
        hourlyRateCollectionView.backgroundColor = UIColor(white: 1, alpha: 0)
        hourlyRateCollectionView.dataSource = self
        hourlyRateCollectionView.delegate = self
        hourlyRateCollectionView.translatesAutoresizingMaskIntoConstraints = false
        hourlyRateCollectionView.frame = view.bounds
        hourlyRateCollectionView.register(HourlyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: HourlyWeatherCollectionViewCell.identifier)
        view.addSubview(hourlyRateCollectionView)
        
        
        dailyLayoutCollectionView.scrollDirection = .vertical
        dailyLayoutCollectionView.itemSize = CGSize(width: view.frame.size.width*0.8, height: view.frame.size.height * 0.08)
        dailyLayoutCollectionView.sectionHeadersPinToVisibleBounds = true
        
        dailyRateCollectionView = UICollectionView(frame: .zero, collectionViewLayout: dailyLayoutCollectionView)
        guard let dailyRateCollectionView = dailyRateCollectionView else {
            return
        }
        dailyRateCollectionView.backgroundColor = UIColor(white: 1, alpha: 0)
        dailyRateCollectionView.dataSource = self
        dailyRateCollectionView.delegate = self
        dailyRateCollectionView.translatesAutoresizingMaskIntoConstraints = false
        dailyRateCollectionView.frame = view.bounds
        dailyRateCollectionView.indicatorStyle = .white
        dailyRateCollectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        
        dailyRateCollectionView.register(DailyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: DailyWeatherCollectionViewCell.identifier)
        dailyRateCollectionView.register(HeaderCollectionReusableView.self,
                                         forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                         withReuseIdentifier: HeaderCollectionReusableView.identifier)
        view.addSubview(dailyRateCollectionView)
        
        view.addSubview(footerButton)
    }
    
    private func setConstraints() {
        self.todayDataStackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(UIScreen.main.bounds.height * 0.18)
            make.left.right.equalToSuperview().inset(32)
            make.width.equalTo(UIScreen.main.bounds.width - 64)
        }
        self.hourlyRateCollectionView?.snp.makeConstraints { (make) in
            make.top.equalTo(todayDataStackView.snp.bottom)
            make.left.right.equalToSuperview().inset(32)
            make.width.equalTo(UIScreen.main.bounds.width - 64)
            make.height.equalTo(UIScreen.main.bounds.height * 0.25)
        }
        self.dailyRateCollectionView?.snp.makeConstraints { (make) in
            make.top.equalTo(hourlyRateCollectionView!.snp.bottom)
            make.left.right.equalToSuperview().inset(32)
            make.width.equalTo(UIScreen.main.bounds.width - 64)
            make.height.equalTo(UIScreen.main.bounds.height * 0.4)
        }
        self.footerButton.snp.makeConstraints {(make) in
            make.top.equalTo(dailyRateCollectionView!.snp.bottom).offset(24)
            make.width.equalToSuperview()
        }
    }
    
    func startTimerForShowScrollIndicator() {
        self.timerForShowScrollIndicator = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.showScrollIndicatorsInContacts), userInfo: nil, repeats: true)
    }
    
    @objc func showScrollIndicatorsInContacts() {
        UIView.animate(withDuration: 0.001) {
            self.dailyRateCollectionView?.flashScrollIndicators()
        }
    }
        
}


extension SecondWeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == hourlyRateCollectionView {
            return weatherData.filter{
                !$0.hour.contains("-")
            }.count
        } else {
            return weatherData.filter{
                $0.hour.contains("-")
            }.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == hourlyRateCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionViewCell.identifier, for: indexPath) as! HourlyWeatherCollectionViewCell
            cell.configure(weather: weatherData.filter{
                !$0.hour.contains("-")
            }[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyWeatherCollectionViewCell.identifier, for: indexPath) as! DailyWeatherCollectionViewCell
            cell.configure(weather: weatherData.filter{
            $0.hour.contains("-")
            }[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for i in 0..<collectionView.numberOfItems(inSection: 0) {
            if i == indexPath.row {
                let cell = hourlyRateCollectionView!.cellForItem(at: [0, i])
                cell?.layer.borderWidth = 2.0
                cell?.layer.borderColor = UIColor.white.withAlphaComponent(0.6).cgColor
                cell?.layer.cornerRadius = 15
                cell?.backgroundColor = UIColor.white.withAlphaComponent(0.2)
            } else {
                let cell = hourlyRateCollectionView!.cellForItem(at: [0, i])
                cell?.layer.borderWidth = 0
                cell?.backgroundColor = UIColor.white.withAlphaComponent(0)
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
        headerView.configure()
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView == dailyRateCollectionView {
            return CGSize(width: view.layer.bounds.size.width, height: 50)
        } else {
            return CGSize()
        }
    }
}

