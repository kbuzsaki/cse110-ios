//
//  Question.swift
//  Pollr
//
//  Created by Ran Tao on 5/17/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//

import Foundation

typealias Time = String
typealias PropertyList = [NSObject: AnyObject]

class Question: Model {
    private(set) var inflated: Bool = false
    private static var CACHE = [Int: Question]()
    
    var id: Int?
    var poll: Poll?
    var title: String?
    var type: String?
    var responses = [Response]()
    
    private init() {
    }
    
    private init(id: Int) {
        self.id = id
    }
    
    private init(propertyList plist: PropertyList) {
        updateFrom(propertyList: plist)
    }
    
    /* Smart constructor for id or propertylist, checks cache. */
    static func initFrom(object: AnyObject) -> Question {
        if let id = object as? Int {
            return initFrom(id)
        } else if let plist = object as? PropertyList {
            return initFrom(propertyList: plist)
        }
    }
    
    /* Constructor from id, checks cache. */
    static func initFrom(id: Int) -> Question {
        if let question = CACHE[id] {
            return question
        } else {
            var question = Question(id: id)
            CACHE[id] = question
            return question
        }
    }
    
    /* Constructor from property list, checks cache. */
    static func initFrom(propertyList plist: PropertyList) -> Question {
        if let id = plist["id"] {
            var question = Question.initFrom(id: id)
            question.updateFrom(propertyList: plist)
            return Question
        } else {
            return Question(plist)
        }
    }
    
    func updateFrom(propertyList plist: PropertyList) {
        id = plist["id"] ?? id
    }
    
    func toPropertyList() -> PropertyList {
        return [
            "id"            : id,
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