//
//  DataManager.swift
//
//  Created by Matthew Roknich on 5/25/15.
//  Copyright (c) 2015 Matthew Roknich. All rights reserved.
//

import Foundation

class DataManager {
    var questionType: [String:[String]]
    
    var questionTypeList: [String] {
        var list: [String] = []
        for questionTypeName in questionType.keys {
            list.append(questionTypeName)
        }
        
        list.sort(<)
        
        return list
    }
    
    init() {
            // add default data
            questionType = [
                "Multiple Choice": [""],
                "Rank Preference" : [""],
                "Calendar Integration" : [""]
            ]
    }
    
    func addOption(questionType inquestionType: String, option: String) {
        if var options = questionType[inquestionType] {
            options.append(option)
            questionType[inquestionType] = options
        }
        
    }
    
    func removeOption(questionType inquestionType: String, option temp: String) {
        if var options = questionType[inquestionType] {
            var index = -1
            
            for (idx, option) in enumerate(options) {
                if option == temp {
                    index = idx
                    break
                }
            }
            
            if index != -1 {
                options.removeAtIndex(index)
                questionType[inquestionType] = options
            }
            
        }
    }
 /*
    class func urlForRace(race: String) -> NSURL {
        // replace spaces with _
        var safeString = race.stringByReplacingOccurrencesOfString(" ", withString: "_", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        return NSURL(string: "http://en.wikipedia.org/wiki/" + safeString)!
    }
   */
    struct Static {
        static var onceToken : dispatch_once_t = 0
        static var instance : DataManager? = nil
    }
    
    class var sharedInstance : DataManager {
        dispatch_once(&Static.onceToken) {
            Static.instance = DataManager()
        }
        return Static.instance!
    }
}

