//
//  ChoiceQuestion.swift
//  Pollr
//
//  Created by Ran Tao on 5/26/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//

import Foundation

class ChoiceQuestion: Question {
    private static var CACHE = [Int: ChoiceQuestion]()
    
    var allowMultiple = true
    var allowCustom = true
    var options: [String]?
    var responses: [ChoiceResponse]?
    
    override init() {
    }
    
    private init(id: Int) {
        super.init()
        self.id = id
    }
    
    private init(propertyList plist: [NSObject: AnyObject]) {
        super.init()
        updateFrom(propertyList: plist)
    }
    
    /* Smart constructor for id or propertylist, checks cache. */
    override class func initFrom(object: AnyObject) -> ChoiceQuestion {
        if let id = object as? Int {
            return initFrom(id)
        } else if let plist = object as? [NSObject: AnyObject] {
            return initFrom(propertyList: plist)
        }
        return ChoiceQuestion()
    }
    
    /* Constructor from id, checks cache. */
    override class func initFrom(id: Int) -> ChoiceQuestion {
        if let question = CACHE[id] {
            return question
        } else {
            var question = ChoiceQuestion(id: id)
            CACHE[id] = question
            return question
        }
    }
    
    /* Constructor from property list, checks cache. */
    override class func initFrom(propertyList plist: [NSObject: AnyObject]) -> ChoiceQuestion {
        if let id = plist["id"] as? Int {
            var question = initFrom(id)
            question.updateFrom(propertyList: plist)
            return question
        } else {
            return ChoiceQuestion(propertyList: plist)
        }
    }
    override func updateFrom(propertyList plist: [NSObject: AnyObject]) {
        super.updateFrom(propertyList: plist)
        allowMultiple = plist["allow_multiple"] as? Bool ?? allowMultiple
        allowCustom = plist["allow_custom"] as? Bool ?? allowCustom
        options = plist["options"] as? [String] ?? options
        responses = (plist["responses"] as? [AnyObject])?.map { ChoiceResponse.initFrom($0) } ?? responses
    }
    
    override func toPropertyList() -> [NSObject: AnyObject] {
        var plist = super.toPropertyList()
        plist["allowMultiple"] = allowMultiple
        plist["allowCustom"] = allowCustom
        if let options = options        { plist["options"] = options }
        if let responses = responses    { plist["responses"] = responses.map{ $0.toPropertyList() } }
        return plist
    }
}
