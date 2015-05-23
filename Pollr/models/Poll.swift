//
//  Poll.swift
//  Pollr
//
//  Created by Ran Tao on 5/15/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//

import Foundation

class Poll: Model {
    private(set) var inflated: Bool = false
    private static var CACHE = [Int: Poll]()
    
    var id: Int?
    var creator: User?
    var created: String?
    var last_modified: String?
    var group: Group?
    var name: String?
    var questions: [Question]?
    
    private init() {
    }
    
    private init(id: Int) {
        self.id = id
    }
    
    private init(propertyList plist: [NSObject: AnyObject]) {
        updateFrom(propertyList: plist)
    }
    
    /* Smart constructor for id or propertylist, checks cache. */
    static func initFrom(object: AnyObject) -> Poll {
        if let id = object as? Int {
            return initFrom(id)
        } else if let plist = object as? [NSObject: AnyObject] {
            return initFrom(propertyList: plist)
        }
        
        return Poll()
    }
    
    /* Constructor from id, checks cache. */
    static func initFrom(id: Int) -> Poll {
        if let poll = CACHE[id] {
            return poll
        } else {
            var poll = Poll(id: id)
            CACHE[id] = poll
            return poll
        }
    }
    
    /* Constructor from property list, checks cache. */
    static func initFrom(propertyList plist: [NSObject: AnyObject]) -> Poll {
        if let id = plist["id"] as? Int {
            var poll = initFrom(id)
            poll.updateFrom(propertyList: plist)
            return poll
        } else {
            return Poll(propertyList: plist)
        }
    }
    
    func updateFrom(propertyList plist: [NSObject: AnyObject]) {
        id = plist["id"] as? Int ?? id
        group = plist["group"] != nil ? Group.initFrom(plist["group"]!) : group
        creator = plist["creator"] != nil ? User.initFrom(plist["creator"]!) : creator
        name = plist["name"] as? String ?? name
        created = plist["created"] as? String ?? created
        questions = (plist["questions"] as? [AnyObject])?.map { Question.initFrom($0) } ?? questions
    }
    
    func toPropertyList() -> [NSObject: AnyObject] {
        var plist = [NSObject: AnyObject]()
        if let id = id                  { plist["id"] = id }
        if let group = group            { plist["group"] = group }
        if let creator = creator        { plist["creator"] = creator }
        if let name = name              { plist["name"] = name }
        if let created = created        { plist["created"] = created }
        if let questions = questions    { plist["questions"] = questions.map { $0.toPropertyList() } }
        return plist
    }
        
    func inflate() -> NSError? {
        if !inflated, let id = id  {
            var client = RestClient()
            var (error, plist) = client.get(RestRouter.getPoll(id))
            
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