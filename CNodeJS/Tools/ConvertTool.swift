//
//  ConvertTool.swift
//  CNodeJS
//
//  Created by why on 10/20/14.
//  Copyright (c) 2014 why. All rights reserved.
//

import UIKit

class ConvertTool: NSObject {
    
    /**
    Add dictionary to the topic object
    
    :param: topicDic dictionary with data
    :param: oldTopic target topic object
    
    :returns: new topic object with new data
    */
    class func addDicToTopic(topicDic:NSDictionary, oldTopic:TopicModel) -> TopicModel {

        if let temp = topicDic.objectForKey("id") as? String {
            oldTopic.id = temp
        }
        
        if let temp = topicDic.objectForKey("author_id") as? String {
            oldTopic.authorId = temp
        }
        
        if let temp = topicDic.objectForKey("tab") as? String {
            oldTopic.tab = temp
        }
        
        if let temp = topicDic.objectForKey("content") as? String {
            oldTopic.content = temp
        }
        
        if let temp = topicDic.objectForKey("title") as? String {
            oldTopic.title = temp
        }
        
        if let temp = topicDic.objectForKey("last_reply_at") as? String {
            oldTopic.lastTime = temp
        }
        
        if let temp = topicDic.objectForKey("good") as? Bool {
            oldTopic.good = temp
        }
        
        if let temp = topicDic.objectForKey("top") as? Bool {
            oldTopic.top = temp
        }
        
        if let temp = topicDic.objectForKey("author") as? NSDictionary {
            var author = Author()
            author.loginName = temp.objectForKey("loginname") as String
            author.avatarUrl = temp.objectForKey("avatar_url") as String
            oldTopic.author = author
        }
        
        return oldTopic
    }
}
