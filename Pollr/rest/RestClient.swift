//
//  RestClient.swift
//  Pollr
//
//  Created by Kabir Gogia on 5/17/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//


// RestClient is a wrapper for the restful API backing Pollr
// Data is passed to and from this wrapper using a [NSObject: AnyObject]
// These key value pairs can be written and read as JSON Objects easily
// using the NSJSONSerialization class provided by Swift

import Foundation

class RestClient {
    
    
    //MARK: Get
    func get(route: String) -> (NSError?, [NSObject: AnyObject]?) {
        
        let url = NSURL(string: route)!
        var request = NSURLRequest(URL: url)
        var response: NSURLResponse?
        var error: NSError?
        var urlData = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)!
        
        if let error = error {
            println(error.localizedDescription)
            return (error, nil)
        }
        
        var retValue = NSJSONSerialization.JSONObjectWithData(urlData, options: nil, error: &error) as? [NSObject: AnyObject]
        
        if let error = error {
            println(error.localizedDescription)
            return (error, nil)
        }
        
        return (error, retValue)
    }
    
    
    //MARK: Put
    func put(route: String, data: [NSObject: AnyObject]) -> NSError? {
         return putOrPost(route, data: data, method: "PUT")
    }
    
    //MARK: Post
    func post(route: String, data: [NSObject: AnyObject]) -> NSError? {
         return putOrPost(route, data: data, method: "POST")
    }
    
    
    private func putOrPost(route: String, data: [NSObject: AnyObject], method: String) -> NSError? {
        
        let url = NSURL(string: route)!
        var request = NSMutableURLRequest(URL: url)
        var response: NSURLResponse?
        var error: NSError?
        
        //convert data to JSON
        var jsonObject = NSJSONSerialization.dataWithJSONObject(data, options: nil, error: &error)
        
        if let error = error {
            println("ERROR: Failed to convert data to JSON: \(error.localizedDescription)")
            return error
        }
        
        //prepare request as post and attach json object
        
        request.HTTPMethod = method
        request.HTTPBody = jsonObject
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var urlData = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        
        if let error = error {
            println("ERROR: Could not post: \(error.localizedDescription)")
            return error
        }
        
        return nil
    }
    
    
}