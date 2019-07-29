//
//  MRUser.swift
//  MentorModules
//
//  Created by Jeffrey Wang on 7/26/19.
//

import Foundation

public class MRUser {
    
    var clientUserId: String
    var edrivingUserId: String
    
    init(clientUserId: String, edrivingUserId: String) {
        self.clientUserId = clientUserId
        self.edrivingUserId = edrivingUserId
    }
}
