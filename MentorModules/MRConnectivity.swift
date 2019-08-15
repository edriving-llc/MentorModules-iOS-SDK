//
//  MRConnectivity.swift
//  MentorModules
//
//  Created by Jeffrey Wang on 8/15/19.
//

import Foundation
import Alamofire

struct MRConnectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}
