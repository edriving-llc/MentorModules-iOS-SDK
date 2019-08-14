//
//  MRError.swift
//  MentorModules
//
//  Created by Jeffrey Wang on 7/26/19.
//

import Foundation

public enum MRError: Error, CustomStringConvertible {
    case missingAPIKey
    case urlInvalid
    case missingParameters
    
    public var description: String {
        get {
            switch self {
            case .missingAPIKey:
                return "missingAPIKey"
            case .urlInvalid:
                return "urlInvalid"
            case .missingParameters:
                return "missingParameters"
            }
        }
    }
}

extension MRError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .missingAPIKey:
            return NSLocalizedString("API Key is missing.", comment: "missingAPIKey")
        case .urlInvalid:
            return NSLocalizedString("URL is invalid.", comment: "urlInvalid")
        case .missingParameters:
            return NSLocalizedString("Parameters are missing.", comment: "missingParameters")
        }
    }
}
