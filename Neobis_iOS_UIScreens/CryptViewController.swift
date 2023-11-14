//
//  CryptoScreen.swift
//  Neobis_iOS_UIScreens
//
//  Created by Alisher on 08.11.2023.
//

import Foundation
import SnapKit
import UIKit

class CryptViewController: UIViewController {
    private let portfolioLabel = UILabel()
    private let settingButton = UIButton()
    private let headerStackView = UIStackView()
    private let cryptTableView = UITableView()
    
    var cryptData: [Crypt] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillInTheData()
        initialize()
        setConstraints()
    }
    
    private func fillInTheData() {
        cryptData.append(Crypt(name: "Bitcoin", color: 0xF6543E, growthPercent: 1.6, priceInDollar: 29850.15, priceInCrypt: 2.73, currencyCrypt: "BTC", logoImageName: "bitcoin-logo"))
        cryptData.append(Crypt(name: "Ethereum", color: 0x6374C3, growthPercent: -0.82, priceInDollar: 10561.24, priceInCrypt: 47.61, currencyCrypt: "ETH", logoImageName: "eth-symbol-virgil"))
        cryptData.append(Crypt(name: "Litecoin", color: 0x30E0A1, growthPercent: -2.1, priceInDollar: 3676.76, priceInCrypt: 39.27, currencyCrypt: "LTC", logoImageName: "vector"))
        cryptData.append(Crypt())
        cryptData.append(Crypt())
        cryptData.append(Crypt())
    }
    
    private func initialize() {
        view.backgroundColor = .systemBackground
        
        portfolioLabel.text = "Портфолио"
        portfolioLabel.font = UIFont.boldSystemFont(ofSize: 36)
        portfolioLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(portfolioLabel)
        
        settingButton.setImage(UIImage(systemName: "gearshape"), for: .normal)
        settingButton.tintColor = UIColor(rgb: 0xB9C1D9)
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(settingButton)
        
        headerStackView.addArrangedSubview(portfolioLabel)
        headerStackView.addArrangedSubview(settingButton)
        headerStackView.alignment = .fill
        headerStackView.distribution = .fillProportionally
        headerStackView.spacing = 16.0
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerStackView)
        
        cryptTableView.register(CryptTableViewCell.self, forCellReuseIdentifier: CryptTableViewCell.identifier)
        cryptTableView.dataSource = self
        cryptTableView.delegate = self
        cryptTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cryptTableView)
    }
    
    private func setConstraints() {
        self.headerStackView.snp.makeConstraints {(make) in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 0.1)
            make.left.right.equalToSuperview().inset(32)
        }
        
        self.settingButton.snp.makeConstraints {(make) in
            make.width.equalToSuperview().multipliedBy(0.1)
        }
        
        self.cryptTableView.snp.makeConstraints {(make) in
            make.top.equalTo(headerStackView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(32)
            make.bottom.equalToSuperview()
        }
    }
}


extension CryptViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptTableViewCell.identifier, for: indexPath) as? CryptTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(crypt: cryptData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabel = UILabel()
        headerLabel.text = "посмотреть все"
        headerLabel.font = .systemFont(ofSize: 14)
        headerLabel.textAlignment = .right
        headerLabel.textColor = UIColor(rgb: 0xF6543E)
    
        return headerLabel
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
}
