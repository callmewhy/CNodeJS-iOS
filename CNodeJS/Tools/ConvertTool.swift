//
//  ConvertTool.swift
//  CNodeJS
//
//  Created by why on 10/20/14.
//  Copyright (c) 2014 why. All rights reserved.
//

import UIKit

class ConvertTool: NSObject {
    class func dictionaryToTopic(topicDic:NSDictionary) -> TopicModel {
        var topic = TopicModel()
        topic.id = topicDic.objectForKey("id") as? String
        topic.authorId = topicDic.objectForKey("author_id") as? String
        topic.tab = topicDic.objectForKey("tab") as? String
        topic.content = topicDic.objectForKey("content") as? String
        topic.title = topicDic.objectForKey("title") as? String
        topic.lastTime = topicDic.objectForKey("last_reply_at") as? String
        topic.good = topicDic.objectForKey("good") as? Bool
        topic.top = topicDic.objectForKey("top") as? Bool
        
        var authorDic = topicDic.objectForKey("author") as NSDictionary
        var author = Author()
        author.loginnName = authorDic.objectForKey("loginname") as String
        author.avatarUrl = authorDic.objectForKey("avatar_url") as String
        topic.author = author
        
        return topic
    }
}
