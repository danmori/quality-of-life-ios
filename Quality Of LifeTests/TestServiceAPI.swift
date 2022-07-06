//
//  TestServiceAPI.swift
//  Quality Of LifeTests
//
//  Created by Dan Mori on 06/07/22.
//

@testable import Quality_Of_Life
import Foundation

class TestServiceAPI: ServiceProvider {
    func getMostPopulatedCities(completion: @escaping ((Result<MostPopulatedCitiesResponse, APIError>) -> Void)) {
        completion(.success(MostPopulatedCitiesResponse(embedded: Embedded(citySearchResults: [CitySearchResult(links: CitySearchResultLinks(cityItem: CityItem(href: "")), matchingFullName: "Paris")]))))
    }
}
