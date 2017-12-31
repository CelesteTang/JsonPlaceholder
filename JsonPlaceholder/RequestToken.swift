//
//  RequestToken.swift
//  JsonPlaceholder
//
//  Created by 湯芯瑜 on 2017/11/1.
//  Copyright © 2017年 Hsin-Yu Tang. All rights reserved.
//

import Foundation
class RequestToken {

    private weak var task: URLSessionTask?
    
    init(task: URLSessionTask) {

        self.task = task
    }
    
    func cancel() {

        task?.cancel()
    }
}
