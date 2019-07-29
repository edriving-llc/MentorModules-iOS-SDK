//
//  MRModule.swift
//  MentorModules
//
//  Created by Jeffrey Wang on 7/26/19.
//

import Foundation

public class MRModule {
    
    public var courseCode: String
    public var courseMasterCode: String
    public var prescribeTS: Int64
    public var url: String
    public var urlExpireTS: Int64
    
    init(courseCode: String, courseMasterCode: String, prescribeTS: Int64, url: String, urlExpireTS: Int64) {
        self.courseCode = courseCode
        self.courseMasterCode = courseMasterCode
        self.prescribeTS = prescribeTS
        self.url = url
        self.urlExpireTS = urlExpireTS
    }
}

extension MRModule: CustomStringConvertible {
    public var description : String {
        return "\nurl = \(url)"
    }
}
