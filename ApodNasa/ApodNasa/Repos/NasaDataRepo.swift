//
//  NasaDataRepo.swift
//  ApodNasa
//
//  Created by Nitin Bhatia on 13/02/23.
//

import Foundation

enum ErrorCodes : Int {
    case noConnection = -1001
}

class NasaDataRepo {
    
    func getApod(completionHandler: @escaping((data:NasaApod?, error: ErrorModel?)) -> Void) {
        let url = ApiEndPoints.NasaApod.rawValue
        
        if (!NetworkManager.shared.isReachable || Calendar.current.isDateInToday(UserDefaults.standard.LastestVisit)) && UserDefaults.standard.NasaApodObj != nil {
            let error = NetworkManager.shared.isReachable ? nil : ErrorModel(code: ErrorCodes.noConnection.rawValue, message: "No Connection", domain: nil)
            completionHandler((NasaApod().getCachedData(),error))
            return
        }
        
        APICaller.shared.CallApi(url: url, method: .get, completionHandler: {result in
            if let data = result.data {
                var obj : NasaApod?
                
                if let json = try? JSONDecoder().decode([NasaApod].self, from: data) {
                    obj = json.first
                } else {
                    obj = try? JSONDecoder().decode(NasaApod.self, from: data)
                }
                obj?.clearCachedData()
                completionHandler((obj,nil))
            } else {
                completionHandler((nil,result.error!))
            }
        })
        
    }
}
