//
//  SearchModel.swift
//  SearchApp
//
//  Created by Rahul Kamra on 25/04/21.
//

import Foundation

struct SearchModel: Codable {
    var totalResultsCount: Int
    var geonames: [Geonames]
}

struct Geonames: Codable {
    var adminCode1: String
    var lng: String
    var geonameId: Int
    var toponymName: String
    var countryId: String
    var fcl: String
    var population: Int
    var countryCode: String
    var name: String
    var fclName: String
    var countryName: String
    var fcodeName: String
    var adminName1: String
    var lat: String
    var fcode: String
}
