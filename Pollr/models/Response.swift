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
    var user: User?
    
    init() {
    }
    
    private init(id: Int) {
        self.id! = id
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
        user = plist["user"] != nil ? User.initFrom(plist["user"]!) : user
    }
    
    func toPropertyList() -> [NSObject: AnyObject] {
        var plist = [NSObject: AnyObject]()
        if let id = id { plist["id"] = id }
        if let userid = user?.id { plist["user"] = userid }
        return plist
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