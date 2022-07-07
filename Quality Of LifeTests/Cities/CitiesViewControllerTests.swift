//
//  CitiesViewControllerTests.swift
//  Quality Of Life
//
//  Created by Dan Mori on 06/07/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import Quality_Of_Life
import XCTest

class CitiesViewControllerTests: XCTestCase {
    var sut: CitiesViewController!
    var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupCitiesViewController()
    }
  
    override func tearDown() {
        window = nil
        super.tearDown()
    }
  
    func setupCitiesViewController() {
        sut = CitiesViewController()
    }
  
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
  
    class CitiesBusinessLogicSpy: CitiesBusinessLogic {
        var getCitiesCalled = false
        func getCities(request: Cities.GetCities.Request) {
            getCitiesCalled = true
        }
    }
    
    func testShouldGetCitiesWhenLoaded() {
        let spy = CitiesBusinessLogicSpy()
        sut.interactor = spy
        
        loadView()
        
        XCTAssertTrue(spy.getCitiesCalled, "viewDidLoad() should get cities")
    }
    
    func testDisplayCities() {
        let viewModel = Cities.GetCities.ViewModel(cities: [City(name: "Paris", geonameId: "1234")])
        
        loadView()
        sut.displayCities(viewModel: viewModel)
        
        XCTAssertTrue(sut.cities.count > 0, "Should return at least one city")
    }
}
