//
//  Service.swift
//  SearchApp
//
//  Created by Rahul Kamra on 25/04/21.
//

import Foundation

protocol ServiceProtocol {
    func fetchDataToDisplay(forRequestType requestType: URLRequest, completionHandler: @escaping (SearchModel?, Error?) -> ())
}

class Service: ServiceProtocol {
    var networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    func fetchDataToDisplay(forRequestType requestType: URLRequest, completionHandler: @escaping (SearchModel?, Error?) -> ()) {
        networkClient.fetchDataToDisplay(forRequestType: requestType, completionHandler: completionHandler)
    }
}
