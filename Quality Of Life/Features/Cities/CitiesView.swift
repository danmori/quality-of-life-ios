//
//  CitiesView.swift
//  Quality Of Life
//
//  Created by Dan Mori on 05/07/22.
//

import UIKit

class CitiesView: UIView {
    lazy var tableView = UITableView()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    private func setupView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CityReuseIdentifider")
        addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
}
