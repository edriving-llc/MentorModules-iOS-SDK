//
//  MRModuleFetcher.swift
//  MentorModules
//
//  Created by Jeffrey Wang on 7/26/19.
//

import Foundation
import Alamofire
import SwiftyJSON

public class MRModuleFetcher {
    
    public init() {}
    
    public static func getModules(clientUserId: String, completion: @escaping (Array<MRModule>?, Error?) -> Void) {
        
        guard let url = URL(string: "\(APPURL.BaseURL)v1/users/\(clientUserId)/modules") else {
            completion(nil, MRError.urlInvalid)
            return
        }
        
        let headers: HTTPHeaders = ["x-api-key" : MRSessionManager.shared().apiKey!,
        ]
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).validate().responseJSON { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                var modules = Array<MRModule>()
                for dict in json.arrayValue {
                    let courseCode = dict["course_code"].stringValue
                    let courseMasterCode = dict["course_master_code"].stringValue
                    let prescribeTS = dict["prescribe_ts"].int64Value
                    let url = dict["url"].stringValue
                    let urlExpireTS = dict["url_expire_ts"].int64Value
                    let module = MRModule(courseCode: courseCode, courseMasterCode: courseMasterCode, prescribeTS: prescribeTS, url: url, urlExpireTS: urlExpireTS)
                    modules.append(module)
                }
                completion(modules, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
}
