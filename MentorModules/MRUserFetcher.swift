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

public class MRUserFetcher {
    
    public init() {}

    public static func getUser(clientUserId: String, completion: @escaping (MRUser?, Error?) -> Void) {
        
        guard let url = URL(string: "\(APPURL.BaseURL)v1/users/\(clientUserId)") else {
            completion(nil, MRError.urlInvalid)
            return
        }
        
        let headers: HTTPHeaders = ["x-api-key" : MRSessionManager.shared().apiKey!]
        Alamofire.request(url, method: .put, parameters: nil, encoding: URLEncoding.default, headers: headers).validate().responseJSON { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let clientUserId = json["nartoUserId"].stringValue
                let edrivingUserId = json["edrivingUserId"].stringValue
                let user = MRUser(clientUserId: clientUserId, edrivingUserId: edrivingUserId)
                completion(user, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
}
