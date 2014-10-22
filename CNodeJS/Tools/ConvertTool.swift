//
//  ConvertTool.swift
//  CNodeJS
//
//  Created by why on 10/20/14.
//  Copyright (c) 2014 why. All rights reserved.
//

import UIKit

class ConvertTool: NSObject {
    
    class func getTopicFromDic(topicDic: [String:AnyObject]) -> TopicModel {

        var topic = TopicModel()
        
        if let temp = topicDic["id"] as? String {
            topic.id = temp
        }
        
        if let temp = topicDic["author_id"] as? String {
            topic.authorId = temp
        }
        
        if let temp = topicDic["tab"] as? String {
            topic.tab = temp
        }
        
        if let temp = topicDic["content"] as? String {
            topic.content = temp
        }
        
        if let temp = topicDic["title"] as? String {
            topic.title = temp
        }
        
        if let temp = topicDic["last_reply_at"] as? String {
            topic.lastTime = temp
        }
        
        if let temp = topicDic["good"] as? Bool {
            topic.good = temp
        }
        
        if let temp = topicDic["top"] as? Bool {
            topic.top = temp
        }
        
        if let temp = topicDic["author"] as? [String:AnyObject] {
            var author = Author()
            author.loginName = temp["loginname"] as String
            author.avatarUrl = temp["avatar_url"] as String
            topic.author = author
        }
        
        
        if let temp = topicDic["replies"] as? [[String:AnyObject]] {
            for item in temp {
                var reply = Reply()
                reply.id = item["id"] as? String
                reply.content = item["content"] as? String
                reply.ups = item["ups"] as? [String]
                reply.createAt = item["create_at"] as? String
                
                
                if let tempAuthor = item["author"] as? [String:AnyObject] {
                    var author = Author()
                    author.loginName = tempAuthor["loginname"] as String
                    author.avatarUrl = tempAuthor["avatar_url"] as String
                    reply.author = author
                }

                
                topic.replies.append(reply)
            }
        }
        
        return topic
    }
}
