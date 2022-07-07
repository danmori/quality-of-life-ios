//
//  CityDetailsResponse.swift
//  Quality Of Life
//
//  Created by Dan Mori on 06/07/22.
//

import Foundation

struct CityDetailsResponse: Codable {
    let links: Links
    let fullName: String
    let geonameID: Int
    let location: Location
    let name: String
    let population: Int

    enum CodingKeys: String, CodingKey {
        case links = "_links"
        case fullName = "full_name"
        case geonameID = "geoname_id"
        case location, name, population
    }
}

// MARK: - Links
struct Links: Codable {
    let cityAdmin1Division: CityDetail
    let cityAlternateNames: CityAlternateNames
    let cityCountry, cityTimezone: CityDetail
    let linksSelf: CityAlternateNames

    enum CodingKeys: String, CodingKey {
        case cityAdmin1Division = "city:admin1_division"
        case cityAlternateNames = "city:alternate-names"
        case cityCountry = "city:country"
        case cityTimezone = "city:timezone"
        case linksSelf = "self"
    }
}

// MARK: - City
struct CityDetail: Codable {
    let href: String
    let name: String
}

// MARK: - CityAlternateNames
struct CityAlternateNames: Codable {
    let href: String
}

// MARK: - Location
struct Location: Codable {
    let geohash: String
    let latlon: Latlon
}

// MARK: - Latlon
struct Latlon: Codable {
    let latitude, longitude: Double
}

struct CityInformations {
    let name: String
    let fullName: String
    let population: Int
    let latitude: Double
    let longitude: Double
}

extension CityDetailsResponse {
    var cityInformations: CityInformations {
        return CityInformations(name: self.name, fullName: self.fullName, population: self.population, latitude: self.location.latlon.latitude, longitude: self.location.latlon.longitude)
    }
}
