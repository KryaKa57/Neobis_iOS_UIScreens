//
//  TravelScreen.swift
//  Neobis_iOS_UIScreens
//
//  Created by Alisher on 08.11.2023.
//

import Foundation
import UIKit

class TravelViewController: UIViewController {
    private let headerStackView = UIStackView()
    private let headerLabel = UILabel()
    private let hintLabel = UILabel()
    private var searchController: UISearchController!
    private var searchBar = UISearchBar()
    private let layoutCitiesCollectionView = UICollectionViewFlowLayout()
    private var citiesCollectionView: UICollectionView?
    
    var cityData: [City] = []
    var filterData: [City]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillInTheData()
        initialize()
        setConstraints()
    }
    
    
    private func fillInTheData() {
        cityData.append(City(name: "ABU DHABI", imageName: "abu-dhabi"))
        cityData.append(City(name: "SAN ANTONIO", imageName: "san-antonio"))
        cityData.append(City(name: "EGYPT", imageName: "egypt"))
        cityData.append(City(name: "BALI", imageName: "bali"))
        
        filterData = cityData
    }
    
    private func initialize() {
        view.backgroundColor = .white
        
        headerLabel.text = "Путешествуйте \n Почувствуйте прилив энергии"
        headerLabel.numberOfLines = 2
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont.boldSystemFont(ofSize: 18)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerLabel)

        hintLabel.text = "Мы поможем вам исследовать, сравнить и забронировать впечатления - все в одном месте."
        hintLabel.numberOfLines = 3
        hintLabel.textAlignment = .center
        hintLabel.font = UIFont.systemFont(ofSize: 14)
        hintLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hintLabel)

        headerStackView.addArrangedSubview(headerLabel)
        headerStackView.addArrangedSubview(hintLabel)
        headerStackView.alignment = .center
        headerStackView.distribution = .fillProportionally
        headerStackView.spacing = 16.0
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.axis = .vertical
        view.addSubview(headerStackView)
        
        searchBar.delegate = self
        searchBar.searchTextField.attributedPlaceholder =  NSAttributedString.init(string: "Куда хотите поехать?", attributes: [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0x2F86F9)])
        searchBar.searchTextField.backgroundColor = .white
        
        if let searchIcon = searchBar.searchTextField.leftView as? UIImageView {
            searchIcon.image = searchIcon.image?.withRenderingMode(.alwaysTemplate)
            searchIcon.tintColor = UIColor(rgb: 0x2F86F9)
        }
        searchBar.backgroundColor = .white
        searchBar.layer.cornerRadius = 10.0
        searchBar.layer.borderWidth = 1.0
        searchBar.layer.borderColor = UIColor(rgb: 0xC2C2C2).cgColor
        searchBar.layer.masksToBounds = true
        
        searchBar.barStyle = .default
        searchBar.sizeToFit()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        
        
        layoutCitiesCollectionView.scrollDirection = .vertical
        layoutCitiesCollectionView.itemSize = CGSize(width: view.frame.size.width, height: view.frame.size.width * 0.6)
        
        citiesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutCitiesCollectionView)
        guard let citiesCollectionView = citiesCollectionView else {
            return
        }
        citiesCollectionView.register(CityCollectionViewCell.self, forCellWithReuseIdentifier: CityCollectionViewCell.identifier)
        citiesCollectionView.dataSource = self
        citiesCollectionView.delegate = self
        citiesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        citiesCollectionView.frame = view.bounds
        view.addSubview(citiesCollectionView)
    }
    
    private func setConstraints() {
        self.headerStackView.snp.makeConstraints {[weak self] (make) in
            guard self != nil else {return}
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 0.1)
            make.left.right.equalToSuperview().inset(32)
        }
        self.searchBar.snp.makeConstraints {[weak self] (make) in
            guard self != nil else {return}
            make.top.equalTo(headerStackView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.05)
        }
        self.citiesCollectionView?.snp.makeConstraints {[weak self] (make) in
            guard self != nil else {return}
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(124)
        }
    }
}

extension TravelViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func filterDataSource(searchTerm: String) {
        if searchTerm.count > 0 {
            filterData = cityData
            
            let filteredResults = filterData.filter {
                $0.name.replacingOccurrences(of: " ", with: "").lowercased().contains(searchTerm.replacingOccurrences(of: " ", with: "").lowercased())
            }
            filterData = filteredResults
            citiesCollectionView?.reloadData()
        }
    }
    
    func restoreDataSource() {
        filterData = cityData
        citiesCollectionView?.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print(1)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(2)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(3)
    }
}

extension TravelViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filterData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.identifier, for: indexPath) as! CityCollectionViewCell
        cell.configure(city: filterData[indexPath.row])
        return cell
    }
}

