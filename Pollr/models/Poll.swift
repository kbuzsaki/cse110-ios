//
//  Poll.swift
//  Pollr
//
//  Created by Ran Tao on 5/15/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//

import Foundation

typealias Time = String
typealias PropertyList = [NSObject: AnyObject]

class Poll: Model {
    private(set) var inflated: Bool = false
    private static var CACHE = [Int: Poll]()
    
    var id: Int?
    var creator: User?
    var created: Time?
    var last_modified: Time?
    var group: Group?
    var name: String?
    var questions = [Question]()
    
    private init() {
    }
    
    private init(id: Int) {
        self.id! = id
    }
    
    private init(propertyList plist: PropertyList) {
        updateFrom(propertyList: plist)
    }
    
    /* Smart constructor for id or propertylist, checks cache. */
    static func initFrom(object: AnyObject) -> Poll {
        if let id = object as? Int {
            return initFrom(id)
        } else if let plist = object as? PropertyList {
            return initFrom(propertyList: plist)
        }
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
    static func initFrom(propertyList plist: PropertyList) -> Poll {
        if let id = plist["id"] {
            var poll = initFrom(id: id)
            poll.updateFrom(propertyList: plist)
            return Poll
        } else {
            return Poll(plist)
        }
    }
    
    func updateFrom(propertyList plist: PropertyList) {
        id = plist["id"] ?? id
        group = plist["group"] ?? group
        creator = plist["creator"] ?? creator
        name = plist["name"] ?? name
        created = plist["created"] ?? created
        questions = plist["questions"] ?? questions
    }
    
    func toPropertyList() -> PropertyList {
        return [
            "id"            : id,
            "group"         : group,
            "creator"       : creator,
            "name"          : name,
            "created"       : created,
            "questions"     : questions.map { $0.toPropertyList() }
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