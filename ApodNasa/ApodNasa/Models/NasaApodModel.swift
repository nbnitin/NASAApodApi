//
//  NasaApodModel.swift
//  ApodNasa
//
//  Created by Nitin Bhatia on 13/02/23.
//

import Foundation

struct NasaApod : Codable {
    let copyright : String?
    let date : String?
    let explanation : String?
    let hdurl : String?
    let media_type : String?
    let url : String?
    let title : String?
    let service_version : String?
    
    init() {
        copyright = nil
        date = nil
        explanation = nil
        hdurl = nil
        media_type = nil
        url = nil
        title = nil
        service_version = nil
    }
}

extension NasaApod {
    func cacheData() {
        UserDefaults.standard.NasaApodObj = self
    }
    
    func getCachedData() -> NasaApod? {
        return UserDefaults.standard.NasaApodObj
    }
    
    func clearCachedData() {
        UserDefaults.standard.NasaApodObj = nil
        UserDefaults.standard.NasaApodImages = nil
    }
}
