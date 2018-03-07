//
//  SportConfigurationManager.swift
//  SportKit
//
//  Created by Marquez Gallegos on 1/25/18.
//  Copyright © 2018 Marquez Gallegos. All rights reserved.
//

import Foundation

public struct SportConfiguration {
    let baseURL : String
}

public class SportConfigurationManager {
    
    public class func defaultConfiguration () -> SportConfiguration {
        return SportConfiguration(baseURL: "https://mrest.protrade.com/api/v8")
    }
}
