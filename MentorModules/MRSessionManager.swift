//
//  MRSessionManager.swift
//  MentorModules
//
//  Created by Jeffrey Wang on 7/26/19.
//

import Foundation

public class MRSessionManager {
    
    static let deviceIdUserDefaultsKey = "com.edriving.mentormodulessdk.deviceId"
    private static var sharedSession: MRSessionManager = {
        let sharedSession = MRSessionManager()
        return sharedSession
    }()
    
    public var apiKey: String?
    public var deviceId: String?
    
    private init() {}
    
    public class func shared() -> MRSessionManager {
        return sharedSession
    }
    
    public class func setAPIKey(apiKey: String) {
        sharedSession.apiKey = apiKey
        sharedSession.deviceId = getDeviceId()
    }
    
    class func getDeviceId() -> String {
        if let deviceId = UserDefaults.standard.string(forKey: MRSessionManager.deviceIdUserDefaultsKey) {
            return deviceId
        } else {
            let uuid = UUID().uuidString
            UserDefaults.standard.set(uuid, forKey: MRSessionManager.deviceIdUserDefaultsKey)
            return uuid
        }
    }
    
    public class func getUser(clientUserId: String) throws -> (MRUser?) {
        guard let apiKey = sharedSession.apiKey else {
            throw MRError.missingAPIKey
        }
        
        MRUserFetcher.getUser(clientUserId: clientUserId) { (user) in
            print("\(user)")
        }
        
        return nil
    }
}
