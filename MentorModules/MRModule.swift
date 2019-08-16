//
//  MRModule.swift
//  MentorModules
//
//  Created by Jeffrey Wang on 7/26/19.
//

import Foundation

public class MRModule: NSObject {
    
    @objc public var productCode: String
    @objc public var category : String
    @objc public var name : String
    @objc public var link : String
    @objc public var createdOn : Int64
    @objc public var linkExpireOn : Int64
    
    init(productCode: String, category: String, name: String, link: String, createdOn: Int64, linkExpireOn: Int64) {
        self.productCode = productCode
        self.category = category
        self.name = name
        self.link = link
        self.createdOn = createdOn
        self.linkExpireOn = linkExpireOn
    }
}

extension MRModule {
    override public var description : String {
        var desc = ""
        desc += "productCode: \(productCode)"
        desc += "\ncategory: \(category)"
        desc += "\nname: \(name)"
        desc += "\nlink: \(link)"
        desc += "\ncreatedOn: \(createdOn)"
        desc += "\nlinkExpireOn: \(linkExpireOn)"
        return desc
    }
}
