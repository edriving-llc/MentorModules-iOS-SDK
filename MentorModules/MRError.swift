//
//  MRError.swift
//  MentorModules
//
//  Created by Jeffrey Wang on 7/26/19.
//

import Foundation

public enum MRError: Error, CustomStringConvertible {
    case notInitialized
    case noNetwork
    case invalidAPIKey
    case invalidURL
    
    public var description: String {
        get {
            switch self {
            case .notInitialized:
                return "notInitialized"
            case .noNetwork:
                return "noNetwork"
            case .invalidAPIKey:
                return "invalidAPIKey"
            case .invalidURL:
                return "invalidURL"
            }
        }
    }
}

extension MRError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notInitialized:
            return NSLocalizedString("SDK is not initialized yet.", comment: "notInitialized")
        case .noNetwork:
            return NSLocalizedString("No internet connection.", comment: "noNetwork")
        case .invalidAPIKey:
            return NSLocalizedString("API Key is invalid.", comment: "invalidAPIKey")
        case .invalidURL:
            return NSLocalizedString("URL is invalid.", comment: "invalidURL")
        }
    }
}
