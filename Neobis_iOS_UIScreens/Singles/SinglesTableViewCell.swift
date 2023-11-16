//
//  SinglesTableViewCell.swift
//  Neobis_iOS_UIScreens
//
//  Created by Alisher on 13.11.2023.
//

import Foundation
import SnapKit
import UIKit

class SinglesTableViewCell: UITableViewCell {
    static var identifier = "SingleCell"
    let nameLabel = UILabel()
    let sloganLabel = UILabel()
    let moreInfoButton = UIButton()
    
    private let leftSideOfCellStackView = UIStackView()
    
    let singlesImageView = UIImageView()
    private let cellStackView = UIStackView()
    
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
        nameLabel.font = UIFont.systemFont(ofSize: 32)
        contentView.addSubview(nameLabel)
        
        sloganLabel.translatesAutoresizingMaskIntoConstraints = false
        sloganLabel.font = UIFont.systemFont(ofSize: 14)
        sloganLabel.numberOfLines = 2
        contentView.addSubview(sloganLabel)
        
        leftSideOfCellStackView.addArrangedSubview(nameLabel)
        leftSideOfCellStackView.addArrangedSubview(sloganLabel)
        leftSideOfCellStackView.distribution = .fillProportionally
        leftSideOfCellStackView.alignment = .fill
        leftSideOfCellStackView.spacing = 4.0
        leftSideOfCellStackView.translatesAutoresizingMaskIntoConstraints = false
        leftSideOfCellStackView.axis = .vertical
        contentView.addSubview(leftSideOfCellStackView)
        
        singlesImageView.tintColor = .black
        singlesImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(singlesImageView)
        
        moreInfoButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        moreInfoButton.translatesAutoresizingMaskIntoConstraints = false
        moreInfoButton.tintColor = .black
        contentView.addSubview(moreInfoButton)
        
        cellStackView.addArrangedSubview(leftSideOfCellStackView)
        cellStackView.addArrangedSubview(singlesImageView)
        cellStackView.distribution = .fillProportionally
        cellStackView.alignment = .center
        cellStackView.spacing = 4.0
        cellStackView.translatesAutoresizingMaskIntoConstraints = false
        cellStackView.axis = .horizontal
        contentView.addSubview(cellStackView)
        
    }
    
    private func setConstraints() {
        self.leftSideOfCellStackView.snp.makeConstraints {(make) in
            make.centerY.equalTo(contentView)
        }
        self.singlesImageView.snp.makeConstraints {(make) in
            make.centerY.equalTo(contentView)
            make.width.lessThanOrEqualTo(contentView.snp.width).multipliedBy(0.25)
        }
        self.moreInfoButton.snp.makeConstraints{(make) in
            make.right.equalTo(contentView.layoutMarginsGuide)
            make.centerY.equalTo(contentView)
        }
        self.cellStackView.snp.makeConstraints{(make) in
            make.left.equalTo(contentView.layoutMarginsGuide)
            make.right.equalTo(moreInfoButton.layoutMarginsGuide)
        }
    }
    
    public func configure(singles: Singles, rowNumber: Int) {
        nameLabel.text = singles.name
        sloganLabel.text = singles.slogan
        singlesImageView.image = UIImage(named: singles.imageName)
        if rowNumber % 2 == 1 {
            cellStackView.removeArrangedSubview(leftSideOfCellStackView)
            cellStackView.insertArrangedSubview(leftSideOfCellStackView, at: 1)
            cellStackView.setNeedsLayout()
        }
    }
}
