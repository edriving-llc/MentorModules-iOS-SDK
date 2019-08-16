//
//  MRModuleFetcher.swift
//  MentorModules
//
//  Created by Jeffrey Wang on 7/26/19.
//

import Foundation
import Alamofire
import SwiftyJSON

class MRModuleFetcher {
    
    static func getModules(clientUserId: String, completion: @escaping (Array<MRModule>?, Error?) -> Void) {
        if !MRConnectivity.isConnectedToInternet {
            completion(nil, MRError.noNetwork)
            return
        }
        
        guard let url = URL(string: "\(MRSessionManager.shared().baseURL)v1/users/\(clientUserId)/modules") else {
            completion(nil, MRError.invalidURL)
            return
        }
        
        let headers: HTTPHeaders = MRSessionManager.getHeaders()
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                var modules = Array<MRModule>()
                for dict in json.arrayValue {
                    let productCode = dict["productCode"].stringValue
                    let category = dict["category"].stringValue
                    let name = dict["name"].stringValue
                    let link = dict["link"].stringValue
                    let createdOn = dict["createdOn"].int64Value
                    let linkExpireOn = dict["linkExpireOn"].int64Value
                    let module = MRModule(productCode: productCode, category: category, name: name, link: link, createdOn: createdOn, linkExpireOn: linkExpireOn)
                    modules.append(module)
                }
                completion(modules, nil)
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
