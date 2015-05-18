//
//  Group.swift
//  modelr
//
//  Created by Ran Tao on 5/17/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//

import Foundation

typealias Time = String
typealias PropertyList = [NSObject: AnyObject]

class Group: Model {
    private(set) var inflated: Bool = false
    private static var CACHE = [Int: Group]()
    
    var id: Int?
    var name: String?
    var members = [User]()
    
    private init() {
    }
    
    private init(id: Int) {
        self.id! = id
    }
    
    private init(propertyList plist: PropertyList) {
        updateFrom(propertyList: plist)
    }
    
    /* Smart constructor for id or propertylist, checks cache. */
    static func initFrom(object: AnyObject) -> Group {
        if let id = object as? Int {
            return initFrom(id)
        } else if let plist = object as? PropertyList {
            return initFrom(propertyList: plist)
        }
    }
    
    /* Constructor from id, checks cache. */
    static func initFrom(id: Int) -> Group {
        if let group = CACHE[id] {
            return group
        } else {
            var group = Group(id: id)
            CACHE[id] = group
            return group
        }
    }
    
    /* Constructor from property list, checks cache. */
    static func initFrom(propertyList plist: PropertyList) -> Group {
        if let id = plist["id"] {
            var group = initFrom(id: id)
            group.updateFrom(propertyList: plist)
            return group
        } else {
            return Group(plist)
        }
    }
    
    func updateFrom(propertyList plist: PropertyList) {
        id = plist["id"] ?? id
    }
    
    func toPropertyList() -> PropertyList {
        return [
            "id"            : id,
        ]
    }
    
    func inflate() {
        if !inflated {
            // TODO: Make rest request.
        }
    }
    
    func refresh() {
        inflated = false
        inflate()
    }
}