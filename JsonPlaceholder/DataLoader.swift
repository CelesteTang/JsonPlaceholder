//
//  DataLoader.swift
//  JsonPlaceholder
//
//  Created by 湯芯瑜 on 2017/11/1.
//  Copyright © 2017年 Hsin-Yu Tang. All rights reserved.
//

import Foundation

enum NetworkError: Error {

    case dataTaskError
    
    case parseError
}

enum Result<T> {

    case success(T)
    
    case error(Error)
}

class DataLoader {

    let session = URLSession.shared
    
    @discardableResult
    func getData(url: URL, headers: [String: String]? = nil, completionHandler: @escaping (Result<JsonModel>) -> Void) -> RequestToken {
        
        let request: URLRequest = {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            return request
        }()

        
        let task = session.dataTask(with: request) { (data, _, error) in

            switch (data, error) {
                
            case (_, let error?):
                
                completionHandler(.error(error))
                
            case (let data?, _):

                let decoder = JSONDecoder()

                do {

                    let jsonModel = try decoder.decode(JsonModel.self, from: data)
                    
                    completionHandler(.success(jsonModel))
                    
                } catch {
                    
                    completionHandler(.error(error))

                }

            case (nil, nil):
                
                completionHandler(.error(NetworkError.dataTaskError))

            default:

                break
            
            }
        }
        
        task.resume()
        
        return RequestToken(task: task)
    }
}
