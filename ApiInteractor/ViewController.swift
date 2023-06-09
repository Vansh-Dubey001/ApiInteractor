//
//  ViewController.swift
//  ApiInteractor
//
//  Created by Vansh Dubey on 08/06/23.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let obj = ApiInteractor()
        let objrequest = obj.request(urlpath: .resendOtp, method: .post)
        obj.fetchData(_url: objrequest) { result in
            print("Api result", result)
            switch result {
                
            case .success(let str):
                for i in str {
                    print("m system status code: \(i.value)")
                }
            case .failure(let err):
                print("errror",err)
            }
            
        }
    }
    
}
