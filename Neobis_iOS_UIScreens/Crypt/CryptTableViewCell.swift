//
//  CryptoTableViewCell.swift
//  Neobis_iOS_UIScreens
//
//  Created by Alisher on 09.11.2023.
//

import Foundation
import SnapKit
import UIKit

class CryptTableViewCell: UITableViewCell {
    static var identifier = "CryptCell"
    let nameLabel = UILabel()
    let growthPercent = UILabel()
    let priceInDollar = UILabel()
    let priceInCrypt = UILabel()
    let logoButton = UIButton()
    
    private let nameWithPercentStackView = UIStackView()
    private let pricesStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialize()
        self.setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        logoButton.backgroundColor = UIColor(rgb: 0x638FFE).withAlphaComponent(0.1)
        logoButton.setImage(UIImage(named: "iconfinder"), for: .normal)
        logoButton.layer.cornerRadius = 10
        logoButton.clipsToBounds = true
        contentView.addSubview(logoButton)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        contentView.addSubview(nameLabel)
        
        growthPercent.textColor = UIColor(rgb: 0xAEB6CE)
        growthPercent.font = UIFont.systemFont(ofSize: 12)
        growthPercent.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(growthPercent)
        
        priceInDollar.translatesAutoresizingMaskIntoConstraints = false
        priceInDollar.font = UIFont.boldSystemFont(ofSize: 16)
        contentView.addSubview(priceInDollar)
        
        priceInCrypt.textColor = UIColor(rgb: 0xAEB6CE)
        priceInCrypt.font = UIFont.systemFont(ofSize: 12)
        priceInCrypt.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(priceInCrypt)
        
        nameWithPercentStackView.addArrangedSubview(nameLabel)
        nameWithPercentStackView.addArrangedSubview(growthPercent)
        nameWithPercentStackView.alignment = .fill
        nameWithPercentStackView.distribution = .fillProportionally
        nameWithPercentStackView.spacing = 4.0
        nameWithPercentStackView.translatesAutoresizingMaskIntoConstraints = false
        nameWithPercentStackView.axis = .vertical
        contentView.addSubview(nameWithPercentStackView)
        
        pricesStackView.addArrangedSubview(priceInDollar)
        pricesStackView.addArrangedSubview(priceInCrypt)
        pricesStackView.alignment = .trailing
        pricesStackView.distribution = .fillProportionally
        pricesStackView.spacing = 4.0
        pricesStackView.translatesAutoresizingMaskIntoConstraints = false
        pricesStackView.axis = .vertical
        contentView.addSubview(pricesStackView)
    }
    
    private func setConstraints() {
        self.logoButton.snp.makeConstraints{(make) in
            make.width.height.equalTo(contentView.snp.width).multipliedBy(0.15)
            make.centerY.equalTo(contentView.layoutMarginsGuide)
        }
        self.nameWithPercentStackView.snp.makeConstraints {(make) in
            make.centerY.equalTo(contentView.layoutMarginsGuide)
            make.left.equalTo(logoButton.snp.right).offset(16)
        }
        self.pricesStackView.snp.makeConstraints {(make) in
            make.centerY.equalTo(contentView.layoutMarginsGuide)
            make.right.equalTo(contentView.snp.right)
            make.bottom.equalTo(nameWithPercentStackView.snp.bottom)
        }
    }
    
    public func configure(crypt: Crypt) {
        let growthPercent = crypt.growthPercent
        nameLabel.text = crypt.name
        self.growthPercent.text = (growthPercent > 0 ? "+" : "") + "\(growthPercent)%"
        priceInDollar.text = "$\(crypt.priceInDollar)"
        priceInCrypt.text = "\(crypt.priceInCrypt) \(crypt.currencyCrypt)"
        logoButton.setImage(UIImage(named: "\(crypt.name)"), for: .normal)
        logoButton.backgroundColor = UIColor(rgb: crypt.color).withAlphaComponent(0.1)
    }
}

extension UIColor {
    public convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    public convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
