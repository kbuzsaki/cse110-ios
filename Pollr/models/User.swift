//
//  User.swift
//  Pollr
//
//  Created by Ran Tao on 5/17/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//

import Foundation

typealias Time = String
typealias PropertyList = [NSObject: AnyObject]

class User: Model {
    private(set) var inflated: Bool = false
    private static var CACHE = [Int: User]()
    
    var id: Int?
    var hash: String?
    var name: String?
    var groups = [Group]()
    
    private init() {
    }
    
    private init(id: Int) {
        self.id = id
    }
    
    private init(propertyList plist: PropertyList) {
        updateFrom(propertyList: plist)
    }
    
    /* Smart constructor for id or propertylist, checks cache. */
    static func initFrom(object: AnyObject) -> User {
        if let id = object as? Int {
            return initFrom(id)
        } else if let plist = object as? PropertyList {
            return initFrom(propertyList: plist)
        }
    }
    
    /* Constructor from id, checks cache. */
    static func initFrom(id: Int) -> User {
        if let poll = CACHE[id] {
            return poll
        } else {
            var poll = User(id: id)
            CACHE[id] = poll
            return poll
        }
    }
    
    /* Constructor from property list, checks cache. */
    static func initFrom(propertyList plist: PropertyList) -> User {
        if let id = plist["id"] {
            var poll = initFrom(id: id)
            poll.updateFrom(propertyList: plist)
            return User
        } else {
            return User(plist)
        }
    }
    
    func updateFrom(propertyList plist: PropertyList) {
        id = plist["id"] ?? id
    }
    
    func toPropertyList() -> PropertyList {
        return [
            "id"            : id
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