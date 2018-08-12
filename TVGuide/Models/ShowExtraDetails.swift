//
//  ShowExtraDetails.swift
//  TVGuide
//
//  Created by Rizianne Veluz on 12/08/2018.
//  Copyright © 2018 Rizianne Veluz. All rights reserved.
//

import Foundation

struct ShowExtraDetails: Decodable {
    var poster: String
    var plot: String
    
    private enum CodingKeys: String, CodingKey {
        case poster = "Poster"
        case plot = "Plot"
    }
}
