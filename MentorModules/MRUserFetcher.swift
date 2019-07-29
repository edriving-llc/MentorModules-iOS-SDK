//
//  MRUserFetcher.swift
//  MentorModulesSDK
//
//  Created by Jeffrey Wang on 7/25/19.
//  Copyright © 2019 eDriving. All rights reserved.
//

import Foundation
import Alamofire

public class MRUserFetcher {
    
    public init() {}

    public static func getUser(clientUserId: String, completion: @escaping (MRUser?) -> Void) {
        
        guard let url = URL(string: "https://47y01h2snf.execute-api.us-west-2.amazonaws.com/dev/narto/v1/users/\(clientUserId)") else {
            completion(nil)
            return
        }
        
        let headers: HTTPHeaders = ["x-api-key" : MRSessionManager.shared().apiKey!]
        Alamofire.request(url, method: .put, parameters: nil, encoding: URLEncoding.default, headers: headers).validate().responseJSON { response in
            let result = response.result
            print("Error while fetching user")
            completion(nil)
            return
        }
        
        
        
//        let user = MRUser(clientUserId: "", edrivingUserId: "")
    }
    
}
