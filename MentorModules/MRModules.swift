//
//  MRModules.swift
//  MentorModules
//
//  Created by Jeffrey Wang on 8/13/19.
//

import Foundation

public class MRModules {
    
    public init() {}
    
    public func initSDK(apiKey: String, clientUserId: String, langauge: String, countryCode: String, timezone: String) {
        MRSessionManager.initSDK(apiKey: apiKey, clientUserId: clientUserId, langauge: langauge, countryCode: countryCode, timezone: timezone)
    }
    
    public func getUser(clientUserId: String, completion: @escaping (MRUser?, Error?) -> Void) {
        MRSessionManager.getUser(clientUserId: clientUserId, completion: completion)
    }
    
    public func getModules(clientUserId: String, completion: @escaping (Array<MRModule>?, Error?) -> Void) {
        MRSessionManager.getModules(clientUserId: clientUserId, completion: completion)
    }
}
