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
    
    var apiKey: String? {
        didSet {
            if let aK = apiKey {
                if aK.hasPrefix("P") {
                    baseURL = APPURL.prod
                } else {
                    baseURL = APPURL.stage
                }
            }
        }
    }
    var clientUserId: String?
    var edrivingUserId: String?
    var langauge: String?
    var countryCode: String?
    var timezone: String?
    var deviceId: String?
    var baseURL: String = ""
    
    private init() {
        self.deviceId = MRSessionManager.getDeviceId()
    }
    
    class func shared() -> MRSessionManager {
        return sharedSession
    }
    
    class func initSDK(apiKey: String, clientUserId: String, langauge: String?, countryCode: String?, timezone: String?) {
        sharedSession.apiKey = apiKey
        sharedSession.clientUserId = clientUserId
        sharedSession.langauge = langauge
        sharedSession.countryCode = countryCode
        sharedSession.timezone = timezone
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
    
    class func getUser(completion: @escaping (MRUser?, Error?) -> Void) {
        if let cUID = sharedSession.clientUserId, let lang = sharedSession.langauge, let cc = sharedSession.countryCode, let tz = sharedSession.timezone {
            MRUserFetcher.getUser(clientUserId: cUID, language: lang, countryCode: cc, timezone: tz) { (user, error) in
                sharedSession.edrivingUserId = user?.edrivingUserId
                completion(user, error)
            }
        } else if let cUID = sharedSession.clientUserId {
            MRUserFetcher.getUser(clientUserId: cUID) { (user, error) in
                sharedSession.edrivingUserId = user?.edrivingUserId
                completion(user, error)
            }
        }
    }
    
    class func getModules(clientUserId: String, completion: @escaping (Array<MRModule>?, Error?) -> Void) {
        guard sharedSession.apiKey != nil else {
            completion(nil, MRError.notInitialized)
            return
        }
        
        MRModuleFetcher.getModules(clientUserId: clientUserId) { (modules, error) in
            completion(modules, error)
        }
    }
    
    class func getHeaders() -> HTTPHeaders {
        let aK = MRSessionManager.shared().apiKey!
        let truncatedAK = String(aK.suffix(aK.count - 1))
        return ["x-api-key" : truncatedAK,
                "device-id" : MRSessionManager.shared().deviceId!]
    }

}

extension MRSessionManager: CustomStringConvertible {
    var description : String {
        return "apiKey = \(apiKey!)\nclientUserId = \(String(describing: clientUserId!))\nlangauge = \(String(describing: langauge!))\ncountryCode = \(countryCode!)\ntimezone = \(timezone!)\ndeviceId = \(deviceId!)"
    }
}
