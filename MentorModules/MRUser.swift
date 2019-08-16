//
//  MRUser.swift
//  MentorModules
//
//  Created by Jeffrey Wang on 7/26/19.
//

import Foundation

public class MRUser: NSObject {
    
    @objc public var clientUserId: String
    @objc public var edrivingUserId: String
    
    init(clientUserId: String, edrivingUserId: String) {
        self.clientUserId = clientUserId
        self.edrivingUserId = edrivingUserId
    }
}
