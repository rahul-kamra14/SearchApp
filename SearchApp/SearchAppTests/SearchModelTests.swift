//
//  SearchModelTests.swift
//  SearchAppTests
//
//  Created by Rahul Kamra on 25/04/21.
//

import XCTest
@testable import SearchApp

class SearchModelTests: XCTestCase {
    
    func testSearchResponse() throws {
            guard
                let path = Bundle(for: type(of: self)).path(forResource: "SearchResults", ofType: "json")
                else { fatalError("Can't find search.json file") }

            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let response = try JSONDecoder().decode(SearchModel.self, from: data)

            XCTAssertEqual(response.totalResultsCount, 4918)
            XCTAssertEqual(response.geonames.count, 10)

            let firstObj = response.geonames.first!

            XCTAssertEqual(firstObj.geonameId, 5391959)
            XCTAssertEqual(firstObj.name, "San Francisco")
            XCTAssertEqual(firstObj.countryCode, "US")
            XCTAssertEqual(firstObj.population, 864816)
        }

}
