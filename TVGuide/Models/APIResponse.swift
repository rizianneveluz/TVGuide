//
//  APIResponse.swift
//  TVGuide
//
//  Created by Rizianne Veluz on 12/08/2018.
//  Copyright © 2018 Rizianne Veluz. All rights reserved.
//

import Foundation

struct APIResponse: Decodable {
    let count: Int
    let results: [Show]
}
