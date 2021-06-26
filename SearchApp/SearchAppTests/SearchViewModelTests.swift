//
//  SearchViewModelTests.swift
//  SearchAppTests
//
//  Created by Rahul Kamra on 25/04/21.
//

import XCTest
@testable import SearchApp

class SearchViewModelTests: XCTestCase {
    var apiService:MockApiService?
    var sut: SearchListViewModel?
    
    override func setUp() {
        super.setUp()
        apiService = MockApiService()
        sut = SearchListViewModel(service: apiService!)
    }
    
    override func tearDown() {
        sut = nil
        apiService = nil
        super.tearDown()
    }
    
    func test_fetch_search_results() {
        // When start fetch
        sut?.fetchSearchResults("San francisco")
        // Assert
        XCTAssert(apiService!.isFetchDataCalled)
    }
    
    func test_fetch_search_fail() {
            
        
        sut?.fetchSearchResults("San francisco")

        apiService!.fetchFail()
        
        // Sut should have 0 count of data Array
        XCTAssertEqual( sut!.dataArray.count, 0 )
        
    }

}
