//
//  TopicModel.swift
//  CNodeJS
//
//  Created by why on 10/20/14.
//  Copyright (c) 2014 why. All rights reserved.
//


class Author {
    var avatarUrl = ""
    var loginnName = ""
}

class TopicModel: NSObject {
    var id: String?
    var authorId: String?
    var tab: String?
    var content: String?
    var title: String?
    var lastTime: String?
    var good: Bool?
    var top: Bool?
    var author: Author?
    var replies: String?
    
}
