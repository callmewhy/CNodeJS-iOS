//
//  TopicModel.swift
//  CNodeJS
//
//  Created by why on 10/20/14.
//  Copyright (c) 2014 why. All rights reserved.
//

import Foundation

class Author: NSObject {
    var avatarUrl: String?
    var loginName: String?
}



class Reply: NSObject {
    var id: String?
    var author: Author?
    var content: String?
    var ups: [String]?
    var createAt: String?
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
    var replies: [Reply] = []
    
}
