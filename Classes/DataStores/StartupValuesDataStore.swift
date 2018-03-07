//
//  StartupValuesDataStore.swift
//  SportKit
//
//  Created by Marquez Gallegos on 1/25/18.
//  Copyright © 2018 Marquez Gallegos. All rights reserved.
//

import Foundation

public class StartupValuesDataStore : DataStore {
    
    public func getStartupValues ( completion: @escaping (StartupValues?, Error?) -> Void) {
        
        let operation = "common/startupValues"
        let parameters = ["appId": "com.softacular.Sportacular",
                          "appVersion": "7.1.1",
                          "countryCode": "US",
                          "deviceType": "PHONE",
                          "deviceVersion": "11.2.2",
                          "platform": "IPHONE",
                          "tz": "America/Los_Angeles"]
        
        self.getData(type: StartupValues.self, operation: operation, parameters: parameters, completion: completion)
    }
}
