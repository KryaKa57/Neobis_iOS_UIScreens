//
//  HourlyWeatherCollectionViewCell.swift
//  Neobis_iOS_UIScreens
//
//  Created by Alisher on 15.11.2023.
//

import Foundation
import SnapKit
import UIKit

class HourlyWeatherCollectionViewCell : UICollectionViewCell {
    static var identifier = "HourlyWeatherCell"
    let degreeLabel = UILabel()
    let statusImageView = UIImageView()
    let hourLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        degreeLabel.textColor = .white
        degreeLabel.font = UIFont.systemFont(ofSize: 18)
        degreeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(degreeLabel)
        
        statusImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(statusImageView)
        
        hourLabel.textColor = .white
        hourLabel.font = UIFont.systemFont(ofSize: 18)
        hourLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(hourLabel)
        
        
    }
    
    private func setConstraints() {
        self.degreeLabel.snp.makeConstraints{(make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView.layoutMarginsGuide)
        }
        self.statusImageView.snp.makeConstraints{(make) in
            make.top.equalTo(degreeLabel.snp.bottom)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.65)
            make.width.equalTo(statusImageView.snp.height).multipliedBy(1.1)
            make.centerX.centerY.equalTo(contentView.layoutMarginsGuide)
        }
        self.hourLabel.snp.makeConstraints{(make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(statusImageView.snp.bottom)
        }
    }
    
    public func configure(weather: Weather) {
        degreeLabel.text = "\(weather.degree)°C"
        statusImageView.image = UIImage(named: weather.statusImageName)
        hourLabel.text = weather.hour
    }
    
}
