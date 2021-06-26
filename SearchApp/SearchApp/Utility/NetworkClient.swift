//
//  NetworkClient.swift
//  SearchApp
//
//  Created by Rahul Kamra on 25/04/21.
//

import Foundation

protocol NetworkClientProtocol {
    func fetchDataToDisplay(forRequestType requestType : URLRequest, completionHandler : @escaping (SearchModel?,Error?) -> ())
}

class NetworkClient: NetworkClientProtocol {
    let session = URLSession.shared

    func fetchDataToDisplay(forRequestType requestType: URLRequest, completionHandler: @escaping (SearchModel?, Error?) -> ()) {
        let task = session.dataTask(with: requestType) { (data, response, error) in
            guard error == nil, let dataObject = data else {
                completionHandler(nil,error)
                return
            }
            do {
                let modelObj = try JSONDecoder().decode(SearchModel.self, from: dataObject)
                completionHandler(modelObj,nil)
            }catch {
                completionHandler(nil,error)
                print(error)
            }
        }
        task.resume()
    }
}
