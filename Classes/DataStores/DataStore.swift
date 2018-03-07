//
//  DataStore.swift
//  SportKit
//
//  Created by Marquez Gallegos on 1/25/18.
//  Copyright © 2018 Marquez Gallegos. All rights reserved.
//

import Foundation

public class DataStore {
    
    public func getData<T:Codable>(type:T.Type, operation:String, parameters:[String: String], completion: @escaping (T?, Error?) -> Void) {
        
        let baseURLString = "\(SportConfigurationManager.defaultConfiguration().baseURL)/\(operation)"
        let queryString = self.sortedParameterString(parameters: parameters)
        guard let url = URL(string: "\(baseURLString)?\(queryString)") else {
            return
        }

        #if DEBUG
        print(url.absoluteString)
        #endif
            
        let task = self.urlSession().dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(nil, error)
            } else {
                guard let data = data else {
                    completion(nil, nil)
                    return
                }
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                do {
                    let jsonObject = try decoder.decode(type, from: data)
                    DispatchQueue.main.async {
                        completion(jsonObject, nil)
                    }
                } catch {
                    completion(nil, nil)
                }
            }
        }
        
        task.resume()
    }
    
    private func urlSession () -> URLSession {
        return URLSession.shared
    }
    
    private func sortedParameterString ( parameters:[String: String]) -> String {
        let sortedKeys = parameters.sorted(by: <)
        return sortedKeys.map { "\($0)=\($1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"}.joined(separator: "&")
    }
    
}
