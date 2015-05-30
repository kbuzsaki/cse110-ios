//
//  Group.swift
//  modelr
//
//  Created by Ran Tao on 5/17/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//

import Foundation

extension Array {
    static func compact(array: [T?]) -> [T] {
        return array.filter { $0 != nil }.map{ $0! }
    }
}

class Group: Model {
    private(set) var inflated: Bool = false
    private static var CACHE = [Int: Group]()
    
    var id: Int?
    var createdAt: NSDate?
    var updatedAt: NSDate?
    var name: String?
    var members: [User]?
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
    class func initFrom(object: AnyObject) -> Group {
        if let id = object as? Int {
            return initFrom(id)
        } else if let plist = object as? [NSObject: AnyObject] {
            return initFrom(propertyList: plist)
        }
        return Group()
    }
    
    /* Constructor from id, checks cache. */
    class func initFrom(id: Int) -> Group {
        if let group = CACHE[id] {
            return group
        } else {
            var group = Group(id: id)
            CACHE[id] = group
            return group
        }
    }
    
    /* Constructor from property list, checks cache. */
    class func initFrom(propertyList plist: [NSObject: AnyObject]) -> Group {
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
        updatedAt = NSDate.dateFrom(plist["updatedAt"]) ?? updatedAt
        createdAt = NSDate.dateFrom(plist["createdAt"]) ?? createdAt
        name = plist["name"] as? String ?? name
        members = (plist["members"] as? [AnyObject])?.map { User.initFrom($0) } ?? members
        polls = (plist["polls"] as? [AnyObject])?.map { Poll.initFrom($0) } ?? polls
    }
    
    func toPropertyList() -> [NSObject: AnyObject] {
        var plist = [NSObject: AnyObject]()
        if let id = id                  { plist["id"] = id }
        if let name = name              { plist["name"] = name }
        if let members = members        { plist["members"] = Array.compact(members.map { $0.id }) }
        if let polls = polls            { plist["polls"] = polls.map { $0.toPropertyList() } }
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