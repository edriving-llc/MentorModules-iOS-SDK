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
    
    static func getUser(clientUserId: String, language: String, countryCode: String, timezone: String, completion: @escaping (MRUser?, Error?) -> Void) {
        
        guard let url = URL(string: "\(MRSessionManager.shared().baseURL)v1/users/\(clientUserId)?language=\(language)&countryCode=\(countryCode)&timezone=\(timezone)") else {
            completion(nil, MRError.urlInvalid)
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
                completion(nil, error)
            }
        }
    }
    
}
