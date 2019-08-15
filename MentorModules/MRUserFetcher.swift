//
//  MRUserFetcher.swift
//  MentorModulesSDK
//
//  Created by Jeffrey Wang on 7/25/19.
//  Copyright © 2019 eDriving. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MRUserFetcher {
    
    static let userURL = "v1/users/"
    
    static func getUser(clientUserId: String, completion: @escaping (MRUser?, Error?) -> Void) {
        guard let url = URL(string: "\(MRSessionManager.shared().baseURL)\(userURL)\(clientUserId)") else {
            completion(nil, MRError.invalidURL)
            return
        }
        getUser(url: url, completion: completion)
    }
    
    static func getUser(clientUserId: String, language: String, countryCode: String, timezone: String, completion: @escaping (MRUser?, Error?) -> Void) {
        guard let url = URL(string: "\(MRSessionManager.shared().baseURL)\(userURL)\(clientUserId)?language=\(language)&countryCode=\(countryCode)&timezone=\(timezone)") else {
            completion(nil, MRError.invalidURL)
            return
        }
        getUser(url: url, completion: completion)
    }
    
    static func getUser(url: URL, completion: @escaping (MRUser?, Error?) -> Void) {
        if !MRConnectivity.isConnectedToInternet {
            completion(nil, MRError.noNetwork)
            return
        }
        
        let headers: HTTPHeaders = MRSessionManager.getHeaders()
        Alamofire.request(url, method: .put, parameters: nil, encoding: URLEncoding.default, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let clientUserId = json["nautoUserId"].stringValue
                let edrivingUserId = json["edrivingUserId"].stringValue
                let user = MRUser(clientUserId: clientUserId, edrivingUserId: edrivingUserId)
                completion(user, nil)
            case .failure(let error):
                if response.response?.statusCode == 403 {
                    completion(nil, MRError.invalidAPIKey)
                } else {
                    completion(nil, error)
                }
            }
        }
    }
    
}
