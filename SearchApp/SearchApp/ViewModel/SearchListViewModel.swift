//
//  SearchViewModel.swift
//  SearchApp
//
//  Created by Rahul Kamra on 25/04/21.
//

import Foundation

import Foundation

class SearchListViewModel {
    
    let service: ServiceProtocol
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    var shouldReloadTableView: ((Bool)-> Void)?
    var dataArray: [Geonames] = []
    
    func fetchSearchResults(_ text: String) {
        let requestProvider = RequestProvider.searchResults(text: text)
        guard let request = requestProvider.urlRequest else {
            //error handling
            return
        }
        service.fetchDataToDisplay(forRequestType: request) {[weak self] (result, error) in
            if error != nil {
                self?.shouldReloadTableView?(false)
            }else {
                self?.processData(result)
            }
        }
    }
    
    func processData(_ data: SearchModel?) {
        guard let resultObject = data else {
            //error Handling
            return
        }
        if resultObject.geonames.count > 0 {
            dataArray = resultObject.geonames
            shouldReloadTableView?(true)
        }else {
            shouldReloadTableView?(false)
        }
    }
}
