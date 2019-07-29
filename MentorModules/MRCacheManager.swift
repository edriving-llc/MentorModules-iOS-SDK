//
//  MRCacheManager.swift
//  MentorModules
//
//  Created by Jeffrey Wang on 7/29/19.
//

import Foundation

class MRCacheManager {
    
    private let expireTime: Int = 12600000 // 3.5 hours
    var lastSyncTime: Int64 = 0
    var modules: Array<MRModule>?
    
    public init() {}
    
    func setModules(modules: Array<MRModule>?) {
        self.lastSyncTime = getCurrentTimeInMilliseconds()
        self.modules = modules
    }
    
    func getCurrentTimeInMilliseconds() -> Int64 {
        return Int64(NSDate().timeIntervalSince1970 * 1000)
    }
    
    func requiresSync() -> Bool {
        let currentTime = getCurrentTimeInMilliseconds()
        let diff = currentTime - lastSyncTime
        if diff > expireTime {
            return true
        }
        return false
    }
}
