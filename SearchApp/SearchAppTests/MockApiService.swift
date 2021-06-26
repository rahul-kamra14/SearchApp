//
//  MockApiService.swift
//  SearchAppTests
//
//  Created by Rahul Kamra on 25/04/21.
//

import Foundation
@testable import SearchApp

enum CustomError: Error {
    // Throw when an invalid password is entered
    case somethingWentWrong
    case otherError
}

class MockApiService: ServiceProtocol {
    var isFetchDataCalled = false
    var completeClosure: ((SearchModel?, Error?) -> ())!
    
    func fetchDataToDisplay(forRequestType requestType: URLRequest, completionHandler: @escaping (SearchModel?, Error?) -> ()) {
        isFetchDataCalled = true
        completeClosure = completionHandler
    }
    
    func fetchSuccess() {        
        
        let model = SearchModel(totalResultsCount: 1, geonames: [])
        completeClosure( model, nil )
    }
    
    func fetchFail() {
        completeClosure(nil, CustomError.somethingWentWrong )
    }
}
