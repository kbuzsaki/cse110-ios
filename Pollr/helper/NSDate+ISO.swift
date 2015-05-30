//
//  NSDate+ISO.swift
//  Pollr
//
//  Created by Ran Tao on 5/27/15.
//  Copyright (c) 2015 Kabir. All rights reserved.
//

import Foundation

public extension NSDate {
    
    public class func ISOStringFromDate(date: NSDate) -> String {
        var dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        return dateFormatter.stringFromDate(date).stringByAppendingString("Z")
    }
    
    public class func dateFromISOString(string: String) -> NSDate? {
        var dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return dateFormatter.dateFromString(string)
    }
    
    public class func dateFrom(object: AnyObject?) -> NSDate? {
        if let str = object as? String {
            return dateFromISOString(str)
        }
        return nil
    }
}