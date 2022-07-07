//
//  CityDetailsViewController.swift
//  Quality Of Life
//
//  Created by Dan Mori on 06/07/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CityDetailsDisplayLogic: AnyObject {
    func displayCityDetails(viewModel: CityDetails.LoadCityDetails.ViewModel)
}

class CityDetailsViewController: UIViewController, CityDetailsDisplayLogic {
    var interactor: CityDetailsBusinessLogic?
    var router: (NSObjectProtocol & CityDetailsRoutingLogic & CityDetailsDataPassing)?
    lazy var service = ServiceAPI()
    lazy var contentView = CityDetailsView()

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = CityDetailsInteractor(withServiceProvider: service)
    let presenter = CityDetailsPresenter()
    let router = CityDetailsRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
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
        loadCityDetails()
    }
    
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    func loadCityDetails() {
        interactor?.loadCityDetails(request: CityDetails.LoadCityDetails.Request())
    }
    
    func displayCityDetails(viewModel: CityDetails.LoadCityDetails.ViewModel) {
        DispatchQueue.main.async {
            self.title = viewModel.name
            self.contentView.cityNameLabel.text = "Nome: \(viewModel.name)"
            self.contentView.cityFullNameLabel.text = "Nome Completo: \(viewModel.fullName)"
            self.contentView.populationLabel.text = "População: \(viewModel.population)"
        }
    }
}
