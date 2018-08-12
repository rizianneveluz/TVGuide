//
//  Show.swift
//  TVGuide
//
//  Created by Rizianne Veluz on 12/08/2018.
//  Copyright © 2018 Rizianne Veluz. All rights reserved.
//

import Foundation
import UIKit.UIImage

struct Show: Decodable {
    var title: String
    var startTime: String
    var endTime: String
    var rating: String
    var channel: String
    
    private enum CodingKeys: String, CodingKey {
        case title = "name"
        case startTime = "start_time"
        case endTime = "end_time"
        case rating
        case channel
    }
    
    static func getIconForRating(_ rating: String) -> UIImage {
        switch rating {
        case Rating.AV.rawValue:
            return #imageLiteral(resourceName: "AV")
        case Rating.G.rawValue:
            return #imageLiteral(resourceName: "G")
        case Rating.M.rawValue:
            return #imageLiteral(resourceName: "M")
        case Rating.MA.rawValue:
            return #imageLiteral(resourceName: "MA")
        case Rating.NR.rawValue:
            return #imageLiteral(resourceName: "NR")
        case Rating.PG.rawValue:
            return #imageLiteral(resourceName: "PG")
        default:
            return #imageLiteral(resourceName: "default")
        }
    }
    
    static func getIconForChannel(_ channel: String) -> UIImage {
        switch channel {
        case Channel.SevenTwo.rawValue:
            return #imageLiteral(resourceName: "SevenTwo")
        case Channel.SevenMate.rawValue:
            return #imageLiteral(resourceName: "SevenMate")
        case Channel.ABC1.rawValue:
            return #imageLiteral(resourceName: "ABC1")
        case Channel.Eleven.rawValue:
            return #imageLiteral(resourceName: "Eleven")
        case Channel.Nine.rawValue:
            return #imageLiteral(resourceName: "Nine")
        case Channel.One.rawValue:
            return #imageLiteral(resourceName: "One")
        case Channel.SBS2.rawValue:
            return #imageLiteral(resourceName: "SBS2")
        case Channel.SBSOne.rawValue:
            return #imageLiteral(resourceName: "SBSOne")
        case Channel.Seven.rawValue:
            return #imageLiteral(resourceName: "Seven")
        case Channel.Ten.rawValue:
            return #imageLiteral(resourceName: "Ten")
        default:
            return #imageLiteral(resourceName: "default")
        }
    }
}

private enum Rating: String {
    case AV
    case G
    case M
    case MA
    case NR
    case PG
}

private enum Channel: String {
    case SevenTwo
    case SevenMate
    case ABC1
    case Eleven
    case Nine
    case One
    case SBS2
    case SBSOne
    case Seven
    case Ten
}
