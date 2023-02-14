//
//  ViewController.swift
//  ApodNasa
//
//  Created by Nitin Bhatia on 13/02/23.
//

import UIKit

class ViewController: UIViewController {

    //outlets
    @IBOutlet weak var lblNoConnection: UILabel!
    @IBOutlet weak var activityInd: UIActivityIndicatorView!
    @IBOutlet weak var imgActivityInd: UIActivityIndicatorView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UITextView!
    @IBOutlet weak var imgAstro: UIImageView!
    
    //varaibles
    let vm = NasaDataViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgActivityInd.startAnimating()
        activityInd.startAnimating()
        
        Task {
            imgActivityInd.stopAnimating()
            
            let data = await vm.getApod()
            
            activityInd.stopAnimating()
            imgActivityInd.startAnimating()
            
            lblTitle.text = data.data?.title ?? ""
            lblDescription.text = data.data?.explanation ?? ""
            
            if let err = data.error {
                lblNoConnection.text = err.code == ErrorCodes.noConnection.rawValue ? "No Connection, You are seeing cached data" : err.message
            } else {
                lblNoConnection.isHidden = true
            }
            
            if let imgData = UserDefaults.standard.NasaApodImages?["hd"] as? Data {
                imgAstro.image = UIImage(data: imgData)
            } else {
                imgAstro.downloaded(from: data.data?.hdurl ?? "") { result in
                    if result.status {
                        UserDefaults.standard.NasaApodObj = data.data
                        UserDefaults.standard.NasaApodImages = ["hd": result.data]
                    }
                    self.imgActivityInd.stopAnimating()
                }
            }
            
            if let _ = data.error {
                print("you are seeing cached data due to no internet connection.")
            }
        }
    }


}

