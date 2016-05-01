//
//  extensions.swift
//  SitStay
//
//  Created by Philip Gilbreth on 4/30/16.
//  Copyright © 2016 GroupA. All rights reserved.
//

import Foundation

//Extensions are magical

extension String {
    func convertToDictionary() -> [String: String]? {
        let data = self.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: false)
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
            if let dict = json as? [String: String]{
                return dict
            }
            return nil
        }
        catch {
            print(error)
        }
        return nil
    }
}

extension String
{
    func toDateTime() -> NSDate
    {
        //Create Date Formatter
        let dateFormatter = NSDateFormatter()
        
        //dateFormatter.locale = NSLocale(localeIdentifier: "us")
        
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        //Parse into NSDate
        let dateFromString : NSDate = dateFormatter.dateFromString(self)!
        
        
        //Return Parsed Date
        return dateFromString
    }
}

public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs === rhs || lhs.compare(rhs) == .OrderedSame
}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedAscending
}

extension NSDate: Comparable { }