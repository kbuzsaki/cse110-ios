//  RestRouter.swift
//  Pollr
//
//  Created by Kabir Gogia on 5/17/15.
//  Copyright (c) 2015 Kabir. All rights reserved.



//The RestRouter is a wrapper for the routes provided by the restful api. It will convert
//Object Oriented Queries into routes that are expected to passed into the RestClient

import Foundation

class RestRouter {
    
    static let URL_BASE = "http://128.54.180.125/api"
    
    
    //GET
    static func getGroup(id: Int) -> String {
        return URL_BASE + "/group/\(id)"
    }
    
    static func getUser(id: Int) -> String {
        return URL_BASE + "/user/\(id)"
    }
    
    static func getPoll(id: Int) -> String {
        return URL_BASE + "/poll/\(id)"
    }
    
    static func getQuestion(id: Int) -> String {
        return URL_BASE + "/question\(id)";
    }
    
    static func getResponse(id: Int) -> String {
        return URL_BASE + "/response/\(id)"
    }
    
    //POST
    static func postPoll() -> String {
        return URL_BASE + "/poll/create/"
    }
    
    static func postResponse() -> String {
        return URL_BASE + "/response/create"
    }
    
}