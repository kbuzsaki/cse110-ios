//
//  Response.swift
//  Pollr
//
//  Created by Ran Tao on 5/17/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//

import Foundation

typealias Time = String
typealias PropertyList = [NSObject: AnyObject]

class Response: Model {
    private(set) var inflated: Bool = false
    private static var CACHE = [Int: Response]()
    
    var id: Int?
    
    private init() {
    }
    
    private init(id: Int) {
        self.id! = id
    }
    
    private init(propertyList plist: PropertyList) {
        updateFrom(propertyList: plist)
    }
    
    /* Smart constructor for id or propertylist, checks cache. */
    static func initFrom(object: AnyObject) -> Response {
        if let id = object as? Int {
            return initFrom(id)
        } else if let plist = object as? PropertyList {
            return initFrom(propertyList: plist)
        }
    }
    
    /* Constructor from id, checks cache. */
    static func initFrom(id: Int) -> Response {
        if let response = CACHE[id] {
            return response
        } else {
            var response = Response(id: id)
            CACHE[id] = response
            return response
        }
    }
    
    /* Constructor from property list, checks cache. */
    static func initFrom(propertyList plist: PropertyList) -> Response {
        if let id = plist["id"] {
            var response = initFrom(id: id)
            response.updateFrom(propertyList: plist)
            return response
        } else {
            return Response(plist)
        }
    }
    
    func updateFrom(propertyList plist: PropertyList) {
        // TODO
    }
    
    func toPropertyList() -> PropertyList {
        return [
            // TODO
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