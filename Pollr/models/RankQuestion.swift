//
//  RankQuestion.swift
//  Pollr
//
//  Created by Ran Tao on 5/26/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//

import Foundation

class RankQuestion: Question {
    private static var CACHE = [Int: RankQuestion]()
    
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
    override class func initFrom(object: AnyObject) -> RankQuestion {
        if let id = object as? Int {
            return initFrom(id)
        } else if let plist = object as? [NSObject: AnyObject] {
            return initFrom(propertyList: plist)
        }
        return RankQuestion()
    }
    
    /* Constructor from id, checks cache. */
    override class func initFrom(id: Int) -> RankQuestion {
        if let question = CACHE[id] {
            return question
        } else {
            var question = RankQuestion(id: id)
            CACHE[id] = question
            return question
        }
    }
    
    /* Constructor from property list, checks cache. */
    override class func initFrom(propertyList plist: [NSObject: AnyObject]) -> RankQuestion {
        if let id = plist["id"] as? Int {
            var question = initFrom(id)
            question.updateFrom(propertyList: plist)
            return question
        } else {
            return RankQuestion(propertyList: plist)
        }
    }
    override func updateFrom(propertyList plist: [NSObject: AnyObject]) {
        super.updateFrom(propertyList: plist)
    }
    
    override func toPropertyList() -> [NSObject: AnyObject] {
        var plist = super.toPropertyList()
        return plist
    }
}
