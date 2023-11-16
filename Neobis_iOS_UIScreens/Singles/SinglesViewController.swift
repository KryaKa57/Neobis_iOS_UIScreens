//
//  SinglesScreen.swift
//  Neobis_iOS_UIScreens
//
//  Created by Alisher on 08.11.2023.
//

import Foundation
import UIKit

class SinglesViewController: UIViewController {
    private let singlesTableView = UITableView()
    
    var singlesData: [Singles] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigation()
        self.fillInTheData()
        self.initialize()
        self.setConstraints()
    }
    
    private func setNavigation() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem?.tintColor = .black
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = .black
        self.navigationItem.title = "Singles"
    }
    
    private func fillInTheData() {
        singlesData.append(Singles(name: "SOS", slogan: "Mini meltdown? Get some Headspace in a hurry", imageName: "book"))
        singlesData.append(Singles(name: "On-the-Go", slogan: "Mindful living? Get your Headspace to go", imageName: "bookshelf"))
        singlesData.append(Singles(name: "Classic", slogan: "Like it simple? Get some extra Headspace", imageName: "diploma"))
        singlesData.append(Singles(name: "SOS", slogan: "Mini meltdown? Get some Headspace in a hurry", imageName: "book"))
    }
    
    private func initialize() {
        view.backgroundColor = UIColor(rgb: 0xF2F2F2)

        singlesTableView.register(SinglesTableViewCell.self, forCellReuseIdentifier: SinglesTableViewCell.identifier)
        singlesTableView.dataSource = self
        singlesTableView.delegate = self
        singlesTableView.translatesAutoresizingMaskIntoConstraints = false
        singlesTableView.backgroundColor = .white
        singlesTableView.clipsToBounds = true
        singlesTableView.layer.cornerRadius = 24
        view.addSubview(singlesTableView)
    }
    
    private func setConstraints() {
        self.singlesTableView.snp.makeConstraints {(make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(124)
        }
    }    
}



extension SinglesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return singlesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SinglesTableViewCell.identifier, for: indexPath) as? SinglesTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(singles: singlesData[indexPath.row], rowNumber: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144.0
    }
}
