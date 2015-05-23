//
//  User.swift
//  Pollr
//
//  Created by Ran Tao on 5/17/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//

import Foundation

class User: Model {
    private static var CACHE = [Int: User]()
    private(set) var inflated: Bool = false
    
    var id: Int?
    var hash: String?
    var name: String?
    var groups: [Group]?
    
    private init() {
    }
    
    private init(id: Int) {
        self.id = id
    }
    
    private init(propertyList plist: [NSObject: AnyObject]) {
        updateFrom(propertyList: plist)
    }
    
    /* Smart constructor for id or propertylist, checks cache. */
    static func initFrom(object: AnyObject) -> User {
        if let id = object as? Int {
            return initFrom(id)
        } else if let plist = object as? [NSObject: AnyObject] {
            return initFrom(propertyList: plist)
        }
        return User()
    }
    
    /* Constructor from id, checks cache. */
    static func initFrom(id: Int) -> User {
        if let user = CACHE[id] {
            return user
        } else {
            var user = User(id: id)
            CACHE[id] = user
            return user
        }
    }
    
    /* Constructor from property list, checks cache. */
    static func initFrom(propertyList plist: [NSObject: AnyObject]) -> User {
        if let id = plist["id"] as? Int {
            var user = initFrom(id)
            user.updateFrom(propertyList: plist)
            return user
        } else {
            return User(propertyList: plist)
        }
    }
    
    func updateFrom(propertyList plist: [NSObject: AnyObject]) {
        id = plist["id"] as? Int ?? id
        hash = plist["hash"] as? String ?? hash
        name = plist["name"] as? String ?? name
        groups = (plist["groups"] as? [AnyObject])?.map { Group.initFrom($0) } ?? groups
    }
    
    func toPropertyList() -> [NSObject: AnyObject] {
        var plist = [NSObject: AnyObject]()
        if let id = id          { plist["id"] = id }
        if let hash = hash      { plist["hash"] = hash }
        if let name = name      { plist["name"] = name }
        if let groups = groups  { plist["groups"] = groups.map { $0.toPropertyList() } }
        return plist
    }
    
    func inflate() -> NSError? {
        if !inflated, let id = id  {
            var client = RestClient()
            var (error, plist) = client.get(RestRouter.getUser(id))
            
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