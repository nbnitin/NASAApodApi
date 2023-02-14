//
//  NasaData.swift
//  ApodNasa
//
//  Created by Nitin Bhatia on 13/02/23.
//

import Foundation

class NasaDataViewModel {
    private let repo = NasaDataRepo()
    
    func getApod() async -> (data: NasaApod?, error: ErrorModel?) {
        await withCheckedContinuation({continuity in
            repo.getApod(completionHandler: {res in
                continuity.resume(returning: (res.data,res.error))
            })
        })
        
    }
    
}
