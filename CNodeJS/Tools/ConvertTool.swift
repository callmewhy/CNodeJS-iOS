//
//  ConvertTool.swift
//  CNodeJS
//
//  Created by why on 10/20/14.
//  Copyright (c) 2014 why. All rights reserved.
//

import UIKit
import SwiftyJSON

class ConvertTool: NSObject {
    
    class func getTopicFromJSON(json: JSON) -> TopicModel {

        var topic = TopicModel()
        
        topic.id        = json["id"].string
        topic.authorId  = json["author_id"].string
        topic.tab       = json["tab"].string
        topic.content   = json["content"].string
        topic.title     = json["title"].string
        topic.lastTime  = ConvertTool.getStringFromTime(json["last_reply_at"].stringValue)
        topic.good      = json["good"].bool
        topic.top       = json["top"].bool
        
        var authorJson = json["author"]
        var author = Author()
        author.loginName = authorJson["loginname"].string
        
        if let avatarUrl = authorJson["avatar_url"].string {
            author.avatarUrl = avatarUrl.hasPrefix("//") ? "http:" + avatarUrl : avatarUrl
        }
        
        topic.author = author
        
        
        let replyJson = json["replies"]
        for (index: String, replyJSON: JSON) in replyJson {
            var reply = Reply()
            reply.id = replyJSON["id"].string
            reply.content = replyJSON["content"].string
            reply.ups = replyJSON["ups"].arrayObject as? [String]
            reply.createAt = ConvertTool.getStringFromTime(replyJSON["create_at"].string!)
            let replyAuthorJson = replyJSON["author"]
            var replyAuthor = Author()
            replyAuthor.loginName = replyAuthorJson["loginname"].string
            replyAuthor.avatarUrl = replyAuthorJson["avatar_url"].string
            reply.author = replyAuthor
            
            topic.replies.append(reply)
        }
        
        return topic
    }
    
    
    class func getStringFromTime(timeString: String) -> String {
        
        var dateStr = timeString.substringWithRange(Range<String.Index>(start: timeString.startIndex, end: advance(timeString.startIndex, 10)))
        var timeStr = timeString.substringWithRange(Range<String.Index>(start: advance(timeString.startIndex, 11), end: advance(timeString.startIndex, 16)))
        
        return dateStr + " " + timeStr

    }
}
