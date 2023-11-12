//
//  FinanceTableViewCell.swift
//  Neobis_iOS_UIScreens
//
//  Created by Alisher on 12.11.2023.
//

import Foundation
import SnapKit
import UIKit

class FinanceTableViewCell: UITableViewCell {
    static var identifier = "FinanceCell"
    let categoryLabel = UILabel()
    let priceLabel = UILabel()
    let lastPurchaseLabel = UILabel()
    let logoButton = UIButton()
    
    private let leftSideOfCellStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialize()
        self.setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        logoButton.backgroundColor = UIColor(rgb: 0xC141CC)
        logoButton.setImage(UIImage(named: "heart"), for: .normal)
        logoButton.layer.cornerRadius = 20
        logoButton.clipsToBounds = true
        contentView.addSubview(logoButton)
        
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(categoryLabel)
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        contentView.addSubview(priceLabel)
        
        lastPurchaseLabel.textColor = UIColor(rgb: 0xAEB6CE)
        lastPurchaseLabel.font = UIFont.systemFont(ofSize: 14)
        lastPurchaseLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(lastPurchaseLabel)
        
        
        leftSideOfCellStackView.addArrangedSubview(priceLabel)
        leftSideOfCellStackView.addArrangedSubview(lastPurchaseLabel)
        leftSideOfCellStackView.alignment = .trailing
        leftSideOfCellStackView.distribution = .fillProportionally
        leftSideOfCellStackView.spacing = 4.0
        leftSideOfCellStackView.translatesAutoresizingMaskIntoConstraints = false
        leftSideOfCellStackView.axis = .vertical
        contentView.addSubview(leftSideOfCellStackView)
    }
    
    private func setConstraints() {
        self.logoButton.snp.makeConstraints{[weak self] (make) in
            guard self != nil else {return}
            make.width.height.equalTo(contentView.snp.width).multipliedBy(0.1)
            make.centerY.equalTo(contentView.layoutMarginsGuide)
            make.left.equalTo(contentView.snp.left).inset(16)
        }
        self.categoryLabel.snp.makeConstraints {[weak self] (make) in
            guard self != nil else {return}
            make.centerY.equalTo(contentView.layoutMarginsGuide)
            make.left.equalTo(logoButton.snp.right).offset(16)
        }
        self.leftSideOfCellStackView.snp.makeConstraints {[weak self] (make) in
            guard self != nil else {return}
            make.centerY.equalTo(contentView.layoutMarginsGuide)
            make.right.equalTo(contentView.snp.right).inset(16)
        }
    }
}
