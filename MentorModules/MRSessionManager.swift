//
//  MRSessionManager.swift
//  MentorModules
//
//  Created by Jeffrey Wang on 7/26/19.
//

import Foundation
import Alamofire

class MRSessionManager {
    
    private static var sharedSession: MRSessionManager = {
        let sharedSession = MRSessionManager()
        return sharedSession
    }()
    
    var apiKey: String?
    var clientUserId: String?
    var langauge: String?
    var countryCode: String?
    var timezone: String?
    var deviceId: String?
    var baseURL: String = ""
    
    private init() {}
    
    class func shared() -> MRSessionManager {
        return sharedSession
    }
    
    class func initSDK(apiKey: String, clientUserId: String, langauge: String, countryCode: String, timezone: String) {
        sharedSession.apiKey = apiKey
        sharedSession.clientUserId = clientUserId
        sharedSession.langauge = langauge
        sharedSession.countryCode = countryCode
        sharedSession.timezone = timezone
        sharedSession.deviceId = getDeviceId()
        if apiKey.hasPrefix("PROD") {
            sharedSession.baseURL = APPURL.prod
        } else {
            sharedSession.baseURL = APPURL.dev
        }
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
    
    class func getUser(clientUserId: String, completion: @escaping (MRUser?, Error?) -> Void) {
        guard sharedSession.apiKey != nil else {
            completion(nil, MRError.missingAPIKey)
            return
        }
        
        guard let cUID = sharedSession.clientUserId, let lang = sharedSession.langauge, let cc = sharedSession.countryCode, let tz = sharedSession.timezone else {
            completion(nil, MRError.missingParameters)
            return
        }
        
        MRUserFetcher.getUser(clientUserId: cUID, language: lang, countryCode: cc, timezone: tz) { (user, error) in
            completion(user, error)
        }
    }
    
    class func getModules(clientUserId: String, completion: @escaping (Array<MRModule>?, Error?) -> Void) {
        guard sharedSession.apiKey != nil else {
            completion(nil, MRError.missingAPIKey)
            return
        }
        
        MRModuleFetcher.getModules(clientUserId: clientUserId) { (modules, error) in
            completion(modules, error)
        }
    }
    
    class func getHeaders() -> HTTPHeaders {
        return ["x-api-key" : MRSessionManager.shared().apiKey!,
                "device-id" : MRSessionManager.shared().deviceId!]
    }

}

extension MRSessionManager: CustomStringConvertible {
    var description : String {
        return "apiKey = \(apiKey!)\nclientUserId = \(String(describing: clientUserId!))\nlangauge = \(String(describing: langauge!))\ncountryCode = \(countryCode!)\ntimezone = \(timezone!)\ndeviceId = \(deviceId!)"
    }
}
