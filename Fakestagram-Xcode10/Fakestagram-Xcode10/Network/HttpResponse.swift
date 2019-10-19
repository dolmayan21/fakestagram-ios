//
//  File.swift
//  Fakestagram-Xcode10
//
//  Created by Ruben Alejandro Leon Del Villar on 11/10/19.
//  Copyright © 2019 unam. All rights reserved.
//

import Foundation

class HttpResponse {
    let httpUrlResponse: HTTPURLResponse

    init(response: URLResponse?) {
        self.httpUrlResponse = response as! HTTPURLResponse
    }

    lazy var status: StatusCode = {
        return StatusCode(rawValue: self.httpUrlResponse.statusCode)
    }()

    func isSuccessful() -> Bool {
        return status == StatusCode.success
    }
}
