//
//  ImageExtension.swift
//  ApodNasa
//
//  Created by Nitin Bhatia on 13/02/23.
//

import UIKit

extension UIImageView {
    func downloaded(from url: String, contentMode mode: ContentMode = .scaleAspectFit,completionHandler: @escaping((status:Bool,data:Data?))->Void) {
        contentMode = mode
        APICaller.shared.CallApi(url: url, method: .get) { data, response, error in
            guard
                
                let data = data,
                let image = UIImage(data: data)
            else { completionHandler((status:false,data: nil)); return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
                completionHandler((true, data: data))
            }
            
        }
    }
}
