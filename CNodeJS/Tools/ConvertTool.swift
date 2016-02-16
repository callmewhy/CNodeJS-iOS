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

        let topic = TopicModel()
        
        topic.id        = json["id"].string
        topic.authorId  = json["author_id"].string
        topic.tab       = json["tab"].string
        topic.content   = json["content"].string
        topic.title     = json["title"].string
        topic.lastTime  = ConvertTool.getStringFromTime(json["last_reply_at"].stringValue)
        topic.good      = json["good"].bool
        topic.top       = json["top"].bool
        
        var authorJson = json["author"]
        let author = Author()
        author.loginName = authorJson["loginname"].string
        
        if let avatarUrl = authorJson["avatar_url"].string {
            author.avatarUrl = avatarUrl.hasPrefix("//") ? "http:" + avatarUrl : avatarUrl
        }
        
        topic.author = author
        
        
        let replyJson = json["replies"]
        for (_, replyJSON): (String, JSON) in replyJson {
            let reply = Reply()
            reply.id = replyJSON["id"].string
            reply.content = replyJSON["content"].string
            reply.ups = replyJSON["ups"].arrayObject as? [String]
            reply.createAt = ConvertTool.getStringFromTime(replyJSON["create_at"].string!)
            let replyAuthorJson = replyJSON["author"]
            let replyAuthor = Author()
            replyAuthor.loginName = replyAuthorJson["loginname"].string
            replyAuthor.avatarUrl = replyAuthorJson["avatar_url"].string
            reply.author = replyAuthor
            
            topic.replies.append(reply)
        }
        
        return topic
    }
    
    
    class func getStringFromTime(timeString: String) -> String {
        
        let dateStr = timeString.substringWithRange(Range<String.Index>(start: timeString.startIndex, end: timeString.startIndex.advancedBy(10)))
        let timeStr = timeString.substringWithRange(Range<String.Index>(start: timeString.startIndex.advancedBy(11), end: timeString.startIndex.advancedBy(16)))
        
        return dateStr + " " + timeStr

    }
}
