//
//  File.swift
//  Fakestagram-Xcode10
//  Created by Ruben Alejandro Leon Del Villar on 11/10/19.
//  Copyright © 2019 unam. All rights reserved.
//

import Foundation

struct Account: Codable {
    let id: String?
    let name: String
    let deviceNumber: String
    let deviceModel: String
}
