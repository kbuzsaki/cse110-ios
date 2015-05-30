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
    var createdAt: NSDate?
    var updatedAt: NSDate?
    
    var creator: User?
    var group: Group?
    var name: String?
    var questions: [Question]?
    var hash: String?
    
    private init() {
    }
    
    private init(id: Int) {
        self.id = id
    }
    
    private init(propertyList plist: [NSObject: AnyObject]) {
        updateFrom(propertyList: plist)
    }
    
    /* Smart constructor for id or propertylist, checks cache. */
    class func initFrom(object: AnyObject) -> Poll {
        if let id = object as? Int {
            return initFrom(id)
        } else if let plist = object as? [NSObject: AnyObject] {
            return initFrom(propertyList: plist)
        }
        
        return Poll()
    }
    
    /* Constructor from id, checks cache. */
    class func initFrom(id: Int) -> Poll {
        if let poll = CACHE[id] {
            return poll
        } else {
            var poll = Poll(id: id)
            CACHE[id] = poll
            return poll
        }
    }
    
    /* Constructor from property list, checks cache. */
    class func initFrom(propertyList plist: [NSObject: AnyObject]) -> Poll {
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
        updatedAt = NSDate.dateFrom(plist["updatedAt"]) ?? updatedAt
        createdAt = NSDate.dateFrom(plist["createdAt"]) ?? createdAt
        group = plist["group"] != nil ? Group.initFrom(plist["group"]!) : group
        creator = plist["creator"] != nil ? User.initFrom(plist["creator"]!) : creator
        name = plist["name"] as? String ?? name
        questions = (plist["questions"] as? [AnyObject])?.map { Question.initFrom($0) } ?? questions
        hash = plist["hash"] as? String ?? hash
        setInflatedIfFullyInflated()
    }
    
    func toPropertyList() -> [NSObject: AnyObject] {
        var plist = [NSObject: AnyObject]()
        if let id = id                  { plist["id"] = id }
        if let groupid = group?.id      { plist["group"] = groupid }
        if let creator = creator        { plist["creator"] = creator }
        if let name = name              { plist["name"] = name }
        if let questions = questions    { plist["questions"] = questions.map { $0.toPropertyList() } }
        return plist
    }
    
    func postPoll() -> NSError? {
        var plist = [NSObject: AnyObject]()
        var pollObject = [NSObject: AnyObject]()
        plist["post"] = pollObject
        
        // If group is not specified, a new group will be created.
        if let groupid = group?.id {
            pollObject["group"] = groupid
        }
        
        if let id = id,
                let creatorid = creator?.id,
                let name = name,
                let questions = questions {
            pollObject["id"] = id
            pollObject["creator"] = creatorid
            
            if questions.count > 0 {
                pollObject["questions"] = questions.map {
                    (var question) -> [NSObject: AnyObject] in
                    if let question = question as? ChoiceQuestion {
                        return question.toPropertyList()
                    } else if let question = question as? RankQuestion {
                        return question.toPropertyList()
                    }
                    return [NSObject: AnyObject]() // Shouldn't reach this case.
                }
            }
                    
            var client = RestClient()
            var (error, returnData) = client.post(RestRouter.postPoll(), data: plist)
            
            if let error = error {
                return error
            } else if let data = returnData {
                updateFrom(propertyList: data)
            }
        }
        return nil
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
            }
        }
        
        return nil
    }
    
    func refresh() -> NSError? {
        inflated = false
        return inflate()
    }
    
    func setInflatedIfFullyInflated() -> Bool {
        inflated = checkFeildsAreInflated()
        return inflated
    }
    
    func checkFeildsAreInflated() -> Bool {
        let mandatoryFields: [AnyObject?] = [
            id,
            createdAt,
            updatedAt,
            creator,
            group,
            name,
            questions
        ]
        var fullyInflated = true
        for field in mandatoryFields {
            if field == nil {
                fullyInflated = false
                break
            }
        }
        return fullyInflated
    }
}