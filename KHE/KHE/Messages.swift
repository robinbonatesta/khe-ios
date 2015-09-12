//
//  Messages.swift
//  KHE
//
//  Created by Paul Dilyard on 8/7/15.
//  Copyright (c) 2015 HacKSU. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

//
// A class representing what you receive when you call messages
//
class Messages {
    
    class Response: Mappable {
        var messages: [Message] = []
        
        class func newInstance(map: Map) -> Mappable? {
            var resp = Response()
            resp.messages <- map["messages"]
            return resp
        }
        
        func mapping(map: Map) {
            messages <- map["messages"]
        }
    }
    
    class Message: Mappable {
        var id: String = ""
        var created: String = ""
        var text: String = ""
        
        class func newInstance(map: Map) -> Mappable? {
            var message = Message()
            message.id <- map["_id"]
            message.created <- map["created"]
            message.text <- map["text"]
            return message
        }
        
        func mapping(map: Map) {
            id <- map["_id"]
            created <- map["created"]
            text <- map["text"]
        }
    }
    
    static func get(callback: (Error?, Response) -> Void) {
        Alamofire
            .request(.GET, "http://api.khe.pdilyard.com/v1.0/messages")
            .responseObject { (response: Response?, error: NSError?) in
                if let response = response {
                    response.messages = response.messages.sorted({ (a, b) -> Bool in
                        return a.created > b.created
                    })
                    callback(nil, response)
                } else {
                    callback(Error(), Response())
                }
            }
    }
    
}
