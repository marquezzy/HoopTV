//
//  StartupValues.swift
//  SportKit
//
//  Created by Marquez Gallegos on 1/25/18.
//  Copyright © 2018 Marquez Gallegos. All rights reserved.
//

import Foundation

public struct StartupValues : Codable {
    let sports : [Sport]
    enum CodingKeys : String, CodingKey {
        case sports = "Sports"
    }
}
