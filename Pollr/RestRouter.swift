//  RestRouter.swift
//  Pollr
//
//  Created by Kabir Gogia on 5/17/15.
//  Copyright (c) 2015 Kabir. All rights reserved.



//The RestRouter is a wrapper for the routes provided by the restful api. It will convert
//Object Oriented Queries into routes that are expected to passed into the RestClient

import Foundation

class RestRouter {
    
    let URL_BASE = "http://128.54.180.125/api"
    
    
    //GET
    func getGroup(groupId:Int) -> String {
        return URL_BASE + "/group/\(groupId)"
    }
    
    func getUser(userId:Int) -> String {
        return URL_BASE + "/user/\(userId)"
    }
    
    func getPoll(pollId:Int) -> String {
        return URL_BASE + "/poll/\(pollId)"
    }
    
    func getQuestion(questionId:Int) -> String {
        return URL_BASE + "/question\(questionId)";
    }
    
    func getResponse(responseId:Int) -> String {
        return URL_BASE + "/response/\(responseId)"
    }
    
    
    //POST
    func postPoll() -> String {
        return URL_BASE + "/poll/create/"
    }
    
    func postResponse() -> String {
        return URL_BASE + "/response/create"
    }
    
}