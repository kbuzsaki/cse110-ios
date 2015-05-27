//
//  ChoiceResponse.swift
//  Pollr
//
//  Created by Ran Tao on 5/26/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//

import Foundation

class ChoiceResponse: Response {
    private static var CACHE = [Int: ChoiceResponse]()
    
    var question: ChoiceQuestion?
    var choices: [String]?
    
    override init() {
        super.init()
    }
    
    private init(id: Int) {
        super.init()
        self.id! = id
    }
    
    private init(propertyList plist: [NSObject: AnyObject]) {
        super.init()
        updateFrom(propertyList: plist)
    }
    
    /* Smart constructor for id or propertylist, checks cache. */
    override class func initFrom(object: AnyObject) -> ChoiceResponse {
        if let id = object as? Int {
            return initFrom(id)
        } else if let plist = object as? [NSObject: AnyObject] {
            return initFrom(propertyList: plist)
        }
        return ChoiceResponse()
    }
    
    /* Constructor from id, checks cache. */
    override class func initFrom(id: Int) -> ChoiceResponse {
        if let response = CACHE[id] {
            return response
        } else {
            var response = ChoiceResponse(id: id)
            CACHE[id] = response
            return response
        }
    }
    
    /* Constructor from property list, checks cache. */
    override class func initFrom(propertyList plist: [NSObject: AnyObject]) -> ChoiceResponse {
        if let id = plist["id"] as? Int {
            var response = initFrom(id)
            response.updateFrom(propertyList: plist)
            return response
        } else {
            return ChoiceResponse(propertyList: plist)
        }
    }
    
    override func updateFrom(propertyList plist: [NSObject: AnyObject]) {
        super.updateFrom(propertyList: plist)
        question = plist["question"] != nil ? ChoiceQuestion.initFrom(plist["question"]!) : question
        choices = plist["choices"] as? [String] ?? choices
    }
    
    override func toPropertyList() -> [NSObject: AnyObject] {
        var plist = super.toPropertyList()
        if let questionid = question?.id            { plist["question"] = questionid }
        if let choices = choices                    { plist["choices"] = choices }
        return plist
    }
}