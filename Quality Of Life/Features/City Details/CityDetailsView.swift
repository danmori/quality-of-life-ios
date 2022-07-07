//
//  CityDetailsView.swift
//  Quality Of Life
//
//  Created by Dan Mori on 06/07/22.
//

import UIKit

class CityDetailsView: UIView {
    lazy var cityNameLabel: UILabel = UILabel()
    lazy var cityFullNameLabel: UILabel = UILabel()
    lazy var populationLabel: UILabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        backgroundColor = .white
        
        let stack = UIStackView(arrangedSubviews: [cityNameLabel, cityFullNameLabel, populationLabel])
        stack.axis = .vertical
        stack.spacing = 10.0
        stack.distribution = .equalSpacing
        
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0).isActive = true
        stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20.0).isActive = true
        stack.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
    }
}
