//
//  MRModules.swift
//  MentorModules
//
//  Created by Jeffrey Wang on 8/13/19.
//

import Foundation

public class MRModules {
    
    public init() {}
    
    public func initSDK(apiKey: String, clientUserId: String, completion: @escaping (MRUser?, Error?) -> Void) {
        MRSessionManager.initSDK(apiKey: apiKey, clientUserId: clientUserId, langauge: nil, countryCode: nil, timezone: nil)
        MRSessionManager.getUser(completion: completion)
    }
    
    public func initSDK(apiKey: String, clientUserId: String, langauge: String, countryCode: String, timezone: String, completion: @escaping (MRUser?, Error?) -> Void) {
        MRSessionManager.initSDK(apiKey: apiKey, clientUserId: clientUserId, langauge: langauge, countryCode: countryCode, timezone: timezone)
        MRSessionManager.getUser(completion: completion)
    }
    
    public func getModules(clientUserId: String, completion: @escaping (Array<MRModule>?, Error?) -> Void) {
        MRSessionManager.getModules(clientUserId: clientUserId, completion: completion)
    }
}
