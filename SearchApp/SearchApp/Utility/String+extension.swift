//
//  String+extension.swift
//  SearchApp
//
//  Created by Rahul Kamra on 25/04/21.
//

import Foundation

extension String {
 func getCleanedURL() -> URL? {
    guard self.isEmpty == false else {
        return nil
    }
    if let url = URL(string: self) {
        return url
    } else {
        if let urlEscapedString = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) , let escapedURL = URL(string: urlEscapedString){
            return escapedURL
        }
    }
    return nil
 }
}

