//
//  MRAuth.swift
//  MentorModulesSDK
//
//  Created by Jeffrey Wang on 7/25/19.
//  Copyright © 2019 eDriving. All rights reserved.
//

import Foundation

class MRAuth {
    
    static let deviceIdUserDefaultsKey = "com.edriving.mentormodulessdk.deviceId"
    
    func getDeviceId() -> String {
        if let deviceId = UserDefaults.standard.string(forKey: MRAuth.deviceIdUserDefaultsKey) {
            return deviceId
        } else {
            let uuid = UUID().uuidString
            UserDefaults.standard.set(uuid, forKey: MRAuth.deviceIdUserDefaultsKey)
            return uuid
        }
    }
    
}
