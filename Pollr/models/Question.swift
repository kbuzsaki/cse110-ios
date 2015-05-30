//
//  Question.swift
//  Pollr
//
//  Created by Ran Tao on 5/17/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//

import Foundation

class Question: Model {
    private(set) var inflated: Bool = false
    private static var CACHE = [Int: Question]()
    
    var id: Int?
    var createdAt: NSDate?
    var updatedAt: NSDate?
    var poll: Poll?
    var title: String?
    var type: String?
    var options: [String]?
    var responses: [Response]?
    
    init() {
    }
    
    private init(id: Int) {
        self.id = id
    }
    
    private init(propertyList plist: [NSObject: AnyObject]) {
        updateFrom(propertyList: plist)
    }
    
    /* Smart constructor for id or propertylist, checks cache. */
    class func initFrom(object: AnyObject) -> Question {
        if let choiceQuestionObject = object as? ChoiceQuestion {
            return ChoiceQuestion.initFrom(choiceQuestionObject)
        }
        if let id = object as? Int {
            return initFrom(id)
        } else if let plist = object as? [NSObject: AnyObject] {
            return initFrom(propertyList: plist)
        }
        return Question()
    }
    
    /* Constructor from id, checks cache. */
    class func initFrom(id: Int) -> Question {
        if let question = CACHE[id] {
            return question
        } else {
            var question = Question(id: id)
            CACHE[id] = question
            return question
        }
    }
    
    /* Constructor from property list, checks cache. */
    class func initFrom(propertyList plist: [NSObject: AnyObject]) -> Question {
        if let id = plist["id"] as? Int {
            var question = initFrom(id)
            question.updateFrom(propertyList: plist)
            return question
        } else {
            return Question(propertyList: plist)
        }
    }
    
    func updateFrom(propertyList plist: [NSObject: AnyObject]) {
        id = plist["id"] as? Int ?? id
        updatedAt = NSDate.dateFrom(plist["updatedAt"]) ?? updatedAt
        createdAt = NSDate.dateFrom(plist["createdAt"]) ?? createdAt
        poll = plist["poll"] != nil ? Poll.initFrom(plist["poll"]!) : poll
        title = plist["title"] as? String ?? title
        type = plist["type"] as? String ?? type
        options = plist["options"] as? [String] ?? options
        responses = (plist["responses"] as? [AnyObject])?.map { Response.initFrom($0) } ?? responses
        setInflatedIfFullyInflated()
    }
    
    func toPropertyList() -> [NSObject: AnyObject] {
        var plist = [NSObject: AnyObject]()
        if let id = id                  { plist["id"] = id }
        if let pollid = poll?.id        { plist["poll"] = pollid }
        if let title = title            { plist["title"] = title }
        if let type = type              { plist["type"] = type }
        if let options = options        { plist["options"] = options }
        if let responses = responses    { plist["responses"] = responses.map{ $0.toPropertyList() } }
        return plist
    }
    
    func inflate() -> NSError? {
        if !inflated, let id = id  {
            var client = RestClient()
            var (error, plist) = client.get(RestRouter.getQuestion(id))
            
            // Flatten the content
            if let content = plist?["content"] as? [NSObject: AnyObject] {
                for (key, value) in content {
                    plist?[key] = value
                }
            }
            
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
            poll,
            title,
            responses
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