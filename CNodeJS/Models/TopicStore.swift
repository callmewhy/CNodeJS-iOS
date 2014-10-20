//
//  TopicStore.swift
//  CNodeJS
//
//  Created by why on 10/20/14.
//  Copyright (c) 2014 why. All rights reserved.
//


private let _sharedTopicStore = TopicStore()

enum TopicType:Int {
    case AllType    = 0
    case ShareType  = 1
    case AskType    = 2
    case JobType    = 3
}

class TopicStore: NSObject {
    
    var topicArray: [[TopicModel]] = [[TopicModel]](count: 4, repeatedValue: [TopicModel]())
    
    class var sharedInstance : TopicStore {
        return _sharedTopicStore
    }
    
    subscript(i: TopicType) -> [TopicModel] {
        get {
            return topicArray[i.rawValue]
        }
    }
    
    func loadData(type:TopicType) {
        topicArray[type.rawValue].append(TopicModel())
    }
    
}
