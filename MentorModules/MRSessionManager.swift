//
//  MRSessionManager.swift
//  MentorModules
//
//  Created by Jeffrey Wang on 7/26/19.
//

import Foundation

public class MRSessionManager {
    
    private static var sharedSession: MRSessionManager = {
        let sharedSession = MRSessionManager()
        return sharedSession
    }()
    
    public var apiKey: String?
    public var clientUserId: String?
    public var langauge: String?
    public var country: String?
    public var timezone: String?
    public var deviceId: String?
    let cacheManager = MRCacheManager()
    
    private init() {}
    
    public class func shared() -> MRSessionManager {
        return sharedSession
    }
    
    public class func initSDK(apiKey: String, clientUserId: String, langauge: String, country: String, timezone: String) {
        sharedSession.apiKey = apiKey
        sharedSession.clientUserId = clientUserId
        sharedSession.langauge = langauge
        sharedSession.country = country
        sharedSession.timezone = timezone
        sharedSession.deviceId = getDeviceId()
    }
    
    class func getDeviceId() -> String {
        if let deviceId = UserDefaults.standard.string(forKey: DEFAULTS.deviceIdUserDefaultsKey) {
            return deviceId
        } else {
            let uuid = UUID().uuidString
            UserDefaults.standard.set(uuid, forKey: DEFAULTS.deviceIdUserDefaultsKey)
            return uuid
        }
    }
    
    public class func getUser(clientUserId: String, completion: @escaping (MRUser?, Error?) -> Void) {
        guard sharedSession.apiKey != nil else {
            completion(nil, MRError.missingAPIKey)
            return
        }
        
        MRUserFetcher.getUser(clientUserId: clientUserId) { (user, error) in
            completion(user, error)
        }
    }
    
    public class func getModules(clientUserId: String, completion: @escaping (Array<MRModule>?, Error?) -> Void) {
        guard sharedSession.apiKey != nil else {
            completion(nil, MRError.missingAPIKey)
            return
        }
        
        if sharedSession.cacheManager.requiresSync() {
            MRModuleFetcher.getModules(clientUserId: clientUserId) { (modules, error) in
                sharedSession.cacheManager.setModules(modules: modules)
                completion(modules, error)
            }
        } else {
            completion(sharedSession.cacheManager.modules, nil)
        }
    }

}

extension MRSessionManager: CustomStringConvertible {
    public var description : String {
        return "apiKey = \(apiKey!)\nclientUserId = \(String(describing: clientUserId!))\nlangauge = \(String(describing: langauge!))\ncountry = \(country!)\ntimezone = \(timezone!)\ndeviceId = \(deviceId!)"
    }
}
