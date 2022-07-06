//
//  CitiesViewController.swift
//  Quality Of Life
//
//  Created by Dan Mori on 05/07/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CitiesDisplayLogic: AnyObject {
    func displayCities(viewModel: Cities.GetCities.ViewModel)
}

class CitiesViewController: UIViewController, CitiesDisplayLogic {
    var interactor: CitiesBusinessLogic?
    var router: (NSObjectProtocol & CitiesRoutingLogic & CitiesDataPassing)?
    lazy var contentView = CitiesView()
    private var cities: [City] = []

    // MARK: Object lifecycle
  
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = CitiesInteractor()
        let presenter = CitiesPresenter()
        let router = CitiesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        setupTableView()
    }
    
    private func setupTableView() {
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
    }
    
    // MARK: Routing
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
  
  // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getCities()
    }
    
    override func loadView() {
        super.loadView()
        view = contentView
    }
      
    func getCities() {
        interactor?.getCities(request: Cities.GetCities.Request())
    }
    
    func displayCities(viewModel: Cities.GetCities.ViewModel) {
        self.cities = viewModel.cities
        DispatchQueue.main.async {
            self.contentView.tableView.reloadData()
        }
    }
}

extension CitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension CitiesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityReuseIdentifider", for: indexPath)
        cell.textLabel?.text = cities[indexPath.row].name
        return cell
    }
}
