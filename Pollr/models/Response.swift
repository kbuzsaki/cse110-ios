//
//  Response.swift
//  Pollr
//
//  Created by Ran Tao on 5/17/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//

import Foundation

class Response: Model {
    private(set) var inflated: Bool = false
    private static var CACHE = [Int: Response]()
    
    var id: Int?
    var createdAt: NSDate?
    var updatedAt: NSDate?
    var responder: User?
    var question: Question?
    var choices: [String]?

    init() {
    }
    
    private init(id: Int) {
        self.id = id
    }
    
    private init(propertyList plist: [NSObject: AnyObject]) {
        updateFrom(propertyList: plist)
    }
    
    /* Smart constructor for id or propertylist, checks cache. */
    class func initFrom(object: AnyObject) -> Response {
        if let id = object as? Int {
            return initFrom(id)
        } else if let plist = object as? [NSObject: AnyObject] {
            return initFrom(propertyList: plist)
        }
        return Response()
    }
    
    /* Constructor from id, checks cache. */
    class func initFrom(id: Int) -> Response {
        if let response = CACHE[id] {
            return response
        } else {
            var response = Response(id: id)
            CACHE[id] = response
            return response
        }
    }

    /* Constructor from property list, checks cache. */
    class func initFrom(propertyList plist: [NSObject: AnyObject]) -> Response {
        if let id = plist["id"] as? Int {
            var response = initFrom(id)
            response.updateFrom(propertyList: plist)
            return response
        } else {
            return Response(propertyList: plist)
        }
    }
    
    func updateFrom(propertyList plist: [NSObject: AnyObject]) {
        id = plist["id"] as? Int ?? id
        updatedAt = NSDate.dateFrom(plist["updatedAt"]) ?? updatedAt
        createdAt = NSDate.dateFrom(plist["createdAt"]) ?? createdAt
        responder = plist["user"] != nil ? User.initFrom(plist["user"]!) : responder
        question = plist["question"] != nil ? Question.initFrom(plist["question"]!) : question
        choices = plist["choices"] as? [String] ?? choices
        setInflatedIfFullyInflated()
    }
    
    func toPropertyList() -> [NSObject: AnyObject] {
        var plist = [NSObject: AnyObject]()
        if let id = id                              { plist["id"] = id }
        if let responderid = responder?.id               { plist["responder"] = responderid }
        if let questionid = question?.id            { plist["question"] = questionid }
        if let choices = choices                    { plist["choices"] = choices }
        return plist
    }
    
    func putResponse() -> NSError? {
        if let responderId = responder?.id,
                let questionId = question?.id,
                let choices = choices {
            var plist = [NSObject: AnyObject]()
            var responseObject = [NSObject: AnyObject]()
            plist["response"] = responseObject
            
            responseObject["responder"] = responderId
            responseObject["question"] = questionId
            responseObject["choices"] = choices
    
            var client = RestClient()
            var (error, returnData) = client.post(RestRouter.putResponse(questionId: questionId), data: plist)
            
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
            var (error, plist) = client.get(RestRouter.getResponse(id))
            
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
            responder,
            question,
            choices
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