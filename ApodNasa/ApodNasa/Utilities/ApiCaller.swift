//
//  ApiCaller.swift
//  ApodNasa
//
//  Created by Nitin Bhatia on 13/02/23.
//

import Foundation

typealias ApiCallerResponse = (data: Data?, response: URLResponse?, error: ErrorModel?)

enum ApiCallerMethod : String {
    case get = "get"
    case post = "post"
}

final class APICaller {
    
    private init(){}
    
    static let shared = APICaller()
    
    func CallApi(url:String, method: ApiCallerMethod, completionHandler: @escaping (ApiCallerResponse) -> Void) {
        
        guard let url = URL(string: url) else {
            let res : ApiCallerResponse
            res.data = nil
            res.response = nil
            res.error = ErrorModel(code: 0, message: "Invalid URL", domain: url)
            completionHandler(res)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            let res : ApiCallerResponse
            res.data = data
            res.response = response
            res.error = ErrorModel(code: (response as? HTTPURLResponse)?.statusCode, message: error?.localizedDescription, domain: nil)
            completionHandler(res)
        })
        
        task.resume()
        
    }

    
    
}
