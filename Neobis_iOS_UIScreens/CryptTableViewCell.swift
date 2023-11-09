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
    let logoImageView = UIImageView()
    
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
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        growthPercent.translatesAutoresizingMaskIntoConstraints = false
        priceInDollar.translatesAutoresizingMaskIntoConstraints = false
        priceInCrypt.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(nameLabel)
        contentView.addSubview(growthPercent)
//        contentView.addSubview(priceInDollar)
//        contentView.addSubview(priceInCrypt)
        
        nameWithPercentStackView.addArrangedSubview(nameLabel)
        nameWithPercentStackView.addArrangedSubview(growthPercent)
        nameWithPercentStackView.alignment = .fill
        nameWithPercentStackView.distribution = .fillProportionally
        nameWithPercentStackView.spacing = 16.0
        nameWithPercentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameWithPercentStackView)
    }
    
    private func setConstraints() {
        self.nameWithPercentStackView.snp.makeConstraints {[weak self] (make) in
            guard self != nil else {return}
            make.top.equalTo(contentView.layoutMarginsGuide)
        }
    }
}
