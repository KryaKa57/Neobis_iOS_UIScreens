//
//  CityCollectionViewCell.swift
//  Neobis_iOS_UIScreens
//
//  Created by Alisher on 13.11.2023.
//

import Foundation
import SnapKit
import UIKit

class CityCollectionViewCell : UICollectionViewCell {
    static var identifier = "CityCell"
    let cityNameLabel = UILabel()
    let cityImageView = UIImageView()
    
    private let leftSideOfCellStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        
        let attributedString = NSMutableAttributedString.init(string: "ABU DHABI")
               
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: UIColor.red, range: NSRange.init(location: 0, length: attributedString.length))
        cityNameLabel.attributedText = attributedString
        cityNameLabel.textColor = .white
        cityNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        contentView.addSubview(cityNameLabel)
        
        cityImageView.image = UIImage(named: "abu-dhabi")
        cityImageView.clipsToBounds = true
        cityImageView.layer.cornerRadius = 24
        contentView.addSubview(cityImageView)
        contentView.sendSubviewToBack(cityImageView)
    }
    
    private func setConstraints() {
        self.cityNameLabel.snp.makeConstraints{(make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView.layoutMarginsGuide).offset(contentView.bounds.height * 0.2)
        }
        self.cityImageView.snp.makeConstraints{(make) in
            make.height.width.equalTo(contentView.layoutMarginsGuide).multipliedBy(0.95)
            make.centerX.centerY.equalTo(contentView.layoutMarginsGuide)
        }
    }
    
    public func configure(city: City) {
        cityNameLabel.text = city.name
        cityImageView.image = UIImage(named: city.imageName)
    }
}
