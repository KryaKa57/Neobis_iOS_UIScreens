//
//  FinanceScreen.swift
//  Neobis_iOS_UIScreens
//
//  Created by Alisher on 08.11.2023.
//

import Foundation
import UIKit

class FinanceViewController: UIViewController {
    private let headerStackView = UIStackView()
    private let headerLabel = UILabel()
    private let balanceLabel = UILabel()
    private let monthManipulationStackView = UIStackView()
    private let monthLabel = UILabel()
    private let prevMonthPickButton = UIButton()
    private let nextMonthPickButton = UIButton()
    
    private let financeTableView = UITableView()
    
    var financeData: [Finance] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillInTheData()
        self.initialize()
        self.setConstraints()
    }
    
    private func fillInTheData() {
        financeData.append(Finance(category: "Дом", color: 0xFFC328, price: 321, lastPurchase: "Продукты", logoImageName: "home"))
        financeData.append(Finance(category: "Покупки", color: 0x3C009E, price: 574, lastPurchase: "Одежда", logoImageName: "tag"))
        financeData.append(Finance(category: "Транспорт", color: 0x9CC741, price: 124, lastPurchase: "Такси", logoImageName: "happy"))
        financeData.append(Finance(category: "Здоровье", color: nil, price: 765, lastPurchase: "Лечение", logoImageName: nil))
        financeData.append(Finance(category: "Фитнес", color: 0x1F86FF, price: 324, lastPurchase: "Тренировки", logoImageName: "cookie"))
        financeData.append(Finance(category: "Счета", color: 0x21C0E3, price: 726, lastPurchase: "Комунальные", logoImageName: "mail"))
        financeData.append(Finance(category: "Ресторан", color: nil, price: 325, lastPurchase: "Ужин", logoImageName: nil))
    }
    
    private func initialize() {
        view.backgroundColor = UIColor(rgb: 0xF2F2F2)
        
        headerLabel.text = "Баланс"
        headerLabel.font = UIFont.boldSystemFont(ofSize: 16)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerLabel)
        
        balanceLabel.text = "1$"
        balanceLabel.font = UIFont.boldSystemFont(ofSize: 36)
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(balanceLabel)
        
        monthLabel.text = "Апрель 2020"
        monthLabel.font = UIFont.systemFont(ofSize: 18)
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(monthLabel)
        
        prevMonthPickButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        prevMonthPickButton.tintColor = .black
        prevMonthPickButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(prevMonthPickButton)
        
        nextMonthPickButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        nextMonthPickButton.tintColor = .black
        nextMonthPickButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextMonthPickButton)
        
        monthManipulationStackView.addArrangedSubview(prevMonthPickButton)
        monthManipulationStackView.addArrangedSubview(monthLabel)
        monthManipulationStackView.addArrangedSubview(nextMonthPickButton)
        monthManipulationStackView.alignment = .fill
        monthManipulationStackView.distribution = .fillProportionally
        monthManipulationStackView.spacing = 16.0
        monthManipulationStackView.translatesAutoresizingMaskIntoConstraints = false
        monthManipulationStackView.axis = .horizontal
        view.addSubview(monthManipulationStackView)
        
        headerStackView.addArrangedSubview(headerLabel)
        headerStackView.addArrangedSubview(balanceLabel)
        headerStackView.addArrangedSubview(monthManipulationStackView)
        headerStackView.alignment = .center
        headerStackView.distribution = .fillProportionally
        headerStackView.spacing = 16.0
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.axis = .vertical
        view.addSubview(headerStackView)

        financeTableView.register(FinanceTableViewCell.self, forCellReuseIdentifier: FinanceTableViewCell.identifier)
        financeTableView.dataSource = self
        financeTableView.delegate = self
        financeTableView.translatesAutoresizingMaskIntoConstraints = false
        financeTableView.backgroundColor = .white
        financeTableView.clipsToBounds = true
        financeTableView.layer.cornerRadius = 24
        view.addSubview(financeTableView)
    }
    
    private func setConstraints() {
        self.headerStackView.snp.makeConstraints {[weak self] (make) in
            guard self != nil else {return}
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 0.1)
            make.left.right.equalToSuperview().inset(32)
        }

        self.financeTableView.snp.makeConstraints {[weak self] (make) in
            guard self != nil else {return}
            make.top.equalTo(headerStackView.snp.bottom).offset(32)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(124)
        }
    }
}


extension FinanceViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return financeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FinanceTableViewCell.identifier, for: indexPath) as? FinanceTableViewCell else {
            return UITableViewCell()
        }
        cell.categoryLabel.text = financeData[indexPath.row].category
        cell.priceLabel.text = "$\(financeData[indexPath.row].price)"
        cell.lastPurchaseLabel.text = financeData[indexPath.row].lastPurchase
        cell.logoButton.setImage(UIImage(named: "\(financeData[indexPath.row].logoImageName)"), for: .normal)
        cell.logoButton.backgroundColor = UIColor(rgb: financeData[indexPath.row].color)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let vw = UIView()
        vw.backgroundColor = UIColor.clear
        let titleLabel = UILabel(frame: CGRect(x:0,y: 0 ,width:tableView.frame.size.width,height:50))
        titleLabel.numberOfLines = 0;
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.text  = "см. еще"
        titleLabel.textAlignment = .center
        vw.addSubview(titleLabel)
        return vw
    }
}
