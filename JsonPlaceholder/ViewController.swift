//
//  ViewController.swift
//  JsonPlaceholder
//
//  Created by 湯芯瑜 on 2017/11/1.
//  Copyright © 2017年 Hsin-Yu Tang. All rights reserved.
//

import UIKit

enum GeneralError: Error {

    case formURLFail
}

class ViewController: UIViewController {

    private var dataLoader: DataLoader? = nil
    private var requestToken: RequestToken? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataLoader = DataLoader()

        self.getData { (jsonModel, error) in
            if let error = error {
                print("[ViewController] Error: \(error.localizedDescription)")
            }

            if let jsonModel = jsonModel {
                print("""
                    =-=-=-=-=-=-=-= JsonModel =-=-=-=-=-=-=-=
                    userId: \(jsonModel.userId),
                    id:     \(jsonModel.id),
                    title:  \(jsonModel.title),
                    body:   \(jsonModel.body)
                    =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                    """)
            }
        }
    }
    
    private func getData(completionHandler: @escaping (JsonModel?, Error?) -> Swift.Void) {
        
        requestToken?.cancel()
        
        let urlString = Config.url.appending(Config.endpoint)
        guard let url = URL(string: urlString) else {
            completionHandler(nil, GeneralError.formURLFail)
            return
        }
        
        requestToken = dataLoader?.getData(url: url, completionHandler: { result in

            switch result {

            case .success(let jsonModel):

                completionHandler(jsonModel, nil)

            case .error(let error):

                completionHandler(nil, error)
            }
        })
    }

}

