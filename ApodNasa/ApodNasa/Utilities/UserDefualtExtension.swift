//
//  UserDefualtExtension.swift
//  ApodNasa
//
//  Created by Nitin Bhatia on 13/02/23.
//

import UIKit

enum UserDefaultsKeys : String {
    case NasaApod = "nasaApod"
    case NasaApodImages = "nasaApodImages"
    case LatestVisit = "latestVisit"
}

extension UserDefaults {
    var NasaApodObj: NasaApod? {
        get {
            return  UserDefaults.getDecodedObject(forKey: UserDefaultsKeys.NasaApod.rawValue)
        }
        set(newValue) {
            if newValue == nil {
                removeObject(forKey: UserDefaultsKeys.NasaApod.rawValue)
            } else {
                UserDefaults.saveObject(object: newValue!, forKey: UserDefaultsKeys.NasaApod.rawValue)
            }
        }
    }
    
    var NasaApodImages : [String:Data?]? {
        get {
            return UserDefaults.standard.value(forKey: UserDefaultsKeys.NasaApodImages.rawValue) as? [String : Data]
        }
        set(newValue) {
            if newValue == nil {
                removeObject(forKey: UserDefaultsKeys.NasaApodImages.rawValue)
            } else {
                UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.NasaApodImages.rawValue)
            }
        }
    }
    
    var LastestVisit : Date {
        get {
            return UserDefaults.standard.value(forKey: UserDefaultsKeys.LatestVisit.rawValue) as! Date
        }
        set(newValue) {
            if newValue == nil {
                removeObject(forKey: UserDefaultsKeys.LatestVisit.rawValue)
            } else {
                UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.LatestVisit.rawValue)
            }
        }
    }
    
    class func saveObject<T: Encodable>(object: T, forKey key: String) {
        let encoder = JSONEncoder()
        let defaults = UserDefaults.standard
        do {
            let  encodedObject = try encoder.encode(object)
            defaults.set(encodedObject, forKey: key)
        } catch(let error) {
            debugPrint("Error while Encoding Object for Key: \(key). Error is \(error.localizedDescription)")
        }
    }
    
    private class func getDecodedObject<T: Decodable>(forKey key: String) -> T? {
        var decodedObject: T?
        let defaults = UserDefaults.standard
        if let bookmarkData = defaults.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            do {
                decodedObject = try decoder.decode(T.self, from: bookmarkData)
            } catch {
                debugPrint("Error while Decoding Object for Key: \(key).")
            }
        }
        return decodedObject
    }
}


