//
//  ListingModel.swift
//  iOSProficiencyPOC
//
//  Created by Soham Bhowmik on 05/09/19.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit

struct ListingModel: Codable {
    let title: String?
    let info: [ListingInfo]?
    
    enum CodingKeys: String, CodingKey
    {
        case title
        case info = "rows"
    }
}

struct ListingInfo: Codable {
    let title: String?
    let description: String?
    let imageURLString: String?
    
    enum CodingKeys: String, CodingKey
    {
        case title
        case description
        case imageURLString = "imageHref"
    }
}

