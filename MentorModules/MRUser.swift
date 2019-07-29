//
//  MRUser.swift
//  MentorModules
//
//  Created by Jeffrey Wang on 7/26/19.
//

import Foundation

public class MRUser {
    
    public var clientUserId: String
    public var edrivingUserId: String
    
    init(clientUserId: String, edrivingUserId: String) {
        self.clientUserId = clientUserId
        self.edrivingUserId = edrivingUserId
    }
}
