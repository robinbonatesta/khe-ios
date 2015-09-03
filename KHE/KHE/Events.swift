//
//  Events.swift
//  KHE
//
//  Created by Paul Dilyard on 9/2/15.
//  Copyright (c) 2015 HacKSU. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

//
// A class representing what you receive when you call messages
//
class Events {
    
    class Response: Mappable {
        var events: [Event] = []
        
        class func newInstance(map: Map) -> Mappable? {
            var response = Response()
            response.events <- map["events"]
            return response
        }
        
        func mapping(map: Map) {
            events <- map["events"]
        }
    }
    
    class Event: Mappable {
        var id: String = ""
        var title: String = ""
        var description: String = ""
        var start: String = ""
        var end: String = ""
        var type: String = ""
        var icon: String = ""
        var location: String = ""
        var group: String = ""
        var notify: Bool = false
        
        class func newInstance(map: Map) -> Mappable? {
            var event = Event()
            event.id <- map["_id"]
            event.title <- map["title"]
            event.description <- map["description"]
            event.start <- map["start"]
            event.end <- map["end"]
            event.type <- map["type"]
            event.icon <- map["icon"]
            event.location <- map["location"]
            event.group <- map["group"]
            event.notify <- map["notify"]
            return event
        }
        
        func mapping(map: Map) {
            id <- map["_id"]
            title <- map["title"]
            description <- map["description"]
            start <- map["start"]
            end <- map["end"]
            type <- map["type"]
            icon <- map["icon"]
            location <- map["location"]
            group <- map["group"]
            notify <- map["notify"]
        }
    }
    
    static func get(callback: (Error?, Response) -> Void) {
        Alamofire
            .request(.GET, "http://api.khe.pdilyard.com/v1.0/events")
            .responseObject { (response: Response?, error: NSError?) in
                if let response = response {
                    response.events = response.events.sorted({ (a, b) -> Bool in
                        return a.start > b.start
                    })
                    callback(nil, response)
                } else {
                    callback(Error(), Response())
                }
        }
    }
    
}
