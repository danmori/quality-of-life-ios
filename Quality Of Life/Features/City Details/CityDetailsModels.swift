//
//  CityDetailsModels.swift
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

enum CityDetails {
    enum LoadCityDetails {
        struct Request{}
        struct Response{
            let name: String
            let fullName: String
            let population: Int
        }
        struct ViewModel{
            let name: String
            let fullName: String
            let population: String
        }
    }
}
