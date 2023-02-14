//
//  ErrorModel.swift
//  ApodNasa
//
//  Created by Nitin Bhatia on 13/02/23.
//

import Foundation

struct ErrorModel : Error {
    
    let code : Int?
    let message : String?
    let domain : String?
    
}
