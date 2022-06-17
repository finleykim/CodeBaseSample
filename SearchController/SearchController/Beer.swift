//
//  Beer.swift
//  SearchController
//
//  Created by Finley on 2022/06/17.
//

import Foundation

struct Beer: Decodable {
    let id : Int?
    let name, tagline, description, brewersTips, imgURL: String?
    let foodParing: [String]?
    
    
    enum CodingKeys: String, CodingKey{
        case id, name, tagline, description
        case brewersTips = "brewers_tips"
        case imgURL = "image_url"
        case foodParing = "food_pairing"
    }
}
