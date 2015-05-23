//
//  Group.swift
//  modelr
//
//  Created by Ran Tao on 5/17/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//

import Foundation

class Group: Model {
    private(set) var inflated: Bool = false
    private static var CACHE = [Int: Group]()
    
    var id: Int?
    var name: String?
    var members: [User]?
    var updatedAt: String?
    var polls: [Poll]?
    
    private init() {
    }
    
    private init(id: Int) {
        self.id = id
    }
    
    private init(propertyList plist: [NSObject: AnyObject]) {
        updateFrom(propertyList: plist)
    }
    
    /* Smart constructor for id or propertylist, checks cache. */
    static func initFrom(object: AnyObject) -> Group {
        if let id = object as? Int {
            return initFrom(id)
        } else if let plist = object as? [NSObject: AnyObject] {
            return initFrom(propertyList: plist)
        }
        return Group()
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
    static func initFrom(propertyList plist: [NSObject: AnyObject]) -> Group {
        if let id = plist["id"] as? Int {
            var group = initFrom(id)
            group.updateFrom(propertyList: plist)
            return group
        } else {
            return Group(propertyList: plist)
        }
    }
    
    func updateFrom(propertyList plist: [NSObject: AnyObject]) {
        id = plist["id"] as? Int ?? id
        name = plist["name"] as? String ?? name
        members = (plist["members"] as? [AnyObject])?.map { User.initFrom($0) } ?? members
        updatedAt = (plist["updatedAt"] as? String ?? name)
    }
    
    func toPropertyList() -> [NSObject: AnyObject] {
        var plist = [NSObject: AnyObject]()
        if let id = id              { plist["id"] = id }
        if let name = name          { plist["name"] = name }
        if let members = members    { plist["members"] = members.map { $0.toPropertyList() } }
        if let updatedAt = updatedAt{ plist["updatedAt"] = updatedAt }
        return plist
    }

    
    func inflate() -> NSError? {
        if !inflated, let id = id  {
            var client = RestClient()
            var (error, plist) = client.get(RestRouter.getGroup(id)) //(error?, data?)
            
            if let error = error {
                return error
            }
            
            if let plist = plist {
                updateFrom(propertyList: plist)
                inflated = true
            }
        }
        
        return nil
    }
    
    func refresh() -> NSError? {
        inflated = false
        return inflate()
    }
}