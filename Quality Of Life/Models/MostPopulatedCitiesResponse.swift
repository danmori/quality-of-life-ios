//
//  MostPopulatedCitiesResponse.swift
//  Quality Of Life
//
//  Created by Dan Mori on 05/07/22.
//

import Foundation

// MARK: - MostPopulatedCitiesResponse
struct MostPopulatedCitiesResponse: Codable {
    let embedded: Embedded

    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
    }
}

// MARK: - Embedded
struct Embedded: Codable {
    let citySearchResults: [CitySearchResult]

    enum CodingKeys: String, CodingKey {
        case citySearchResults = "city:search-results"
    }
}

// MARK: - CitySearchResult
struct CitySearchResult: Codable {
    let links: CitySearchResultLinks
    let matchingFullName: String

    enum CodingKeys: String, CodingKey {
        case links = "_links"
        case matchingFullName = "matching_full_name"
    }
}

// MARK: - CitySearchResultLinks
struct CitySearchResultLinks: Codable {
    let cityItem: CityItem

    enum CodingKeys: String, CodingKey {
        case cityItem = "city:item"
    }
}

// MARK: - SelfClass
struct CityItem: Codable {
    let href: String
}

struct City: Codable {
    let name: String
    let geonameId: String
}

extension MostPopulatedCitiesResponse {
    var cities : [City] {
        return embedded.citySearchResults.map { return City(name: $0.matchingFullName, geonameId: $0.links.cityItem.href.split(separator: ":").last?.replacingOccurrences(of: "/", with: "") ?? "")}
    }
}
