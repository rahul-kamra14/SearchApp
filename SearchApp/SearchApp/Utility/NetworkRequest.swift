//
//  NetworkRequest.swift
//  SearchApp
//
//  Created by Rahul Kamra on 25/04/21.
//

import Foundation

protocol UrlRequestProviderProtocol {
    var urlRequest : URLRequest? {get}
}

enum RequestProvider: UrlRequestProviderProtocol {
    
    case searchResults(text: String)
    
    private var apiKey: String {
        return "keep_truckin"
    }
    
    private var url: URL? {
        switch self {
        case .searchResults(let text):
            let urlStr = "http://api.geonames.org/searchJSON?name_startsWith=\(text)&maxRows=10&username=\(apiKey)"
            return urlStr.getCleanedURL()
        }
    }
    
    var urlRequest: URLRequest? {
        guard let url = self.url else {
            return nil
        }
        switch self {
        case .searchResults(_):
            return URLRequest(url: url)
        }
    }
    
}
