//
//  TopicStore.swift
//  CNodeJS
//
//  Created by why on 10/20/14.
//  Copyright (c) 2014 why. All rights reserved.
//

import Alamofire
import SwiftyJSON

private let _sharedTopicStore = TopicStore()

enum TopicType:Int {
    case AllType    = 0
    case ShareType  = 1
    case AskType    = 2
    case JobType    = 3
}

enum LoadMode:Int {
    case Refresh    = 0
    case LoadMore   = 1
}

class TopicStore: NSObject {
    
    // topic data
    private var topicArray = [[TopicModel](),[TopicModel](),[TopicModel](),[TopicModel]()]
    private var topicDictionay = [String:TopicModel]()
    
    // current page number
    private var nowPages = [1,1,1,1]

    // singleton
    class var sharedInstance : TopicStore {
        return _sharedTopicStore
    }
    
    subscript(index: Int) -> [TopicModel] {
        get {
            return topicArray[index]
        }
    }
    
    func loadTopics(type type:TopicType, mode:LoadMode, finishedClosure:()->Void) {
        
        if(mode == .Refresh) {
            nowPages[type.rawValue] = 1
            self.topicArray[type.rawValue].removeAll(keepCapacity: false)
        }else if(mode == .LoadMore) {
            nowPages[type.rawValue] += 1
        }
        
        let url = "https://cnodejs.org/api/v1/topics?page=\(nowPages[type.rawValue])&tab=\(TAB_KEYS[type.rawValue])"
        
        Alamofire.request(Method.GET, url).responseSwiftyJSON(completionHandler: { (_, _, json, _) -> Void in
            let dataJson = json["data"]
            for (_, subJson): (String, JSON) in dataJson {
                let newTopic = ConvertTool.getTopicFromJSON(subJson)
                self.topicArray[type.rawValue].append(newTopic)
            }
            
            finishedClosure()
        })
    }
    
    
    func loadTopic(topicId topicId: String, finishedClosure:()->Void) {
        
        let url = "https://cnodejs.org/api/v1/topic/\(topicId)"
        
        Alamofire.request(Method.GET, url).responseSwiftyJSON(completionHandler: {(_, _, json, _) -> Void in
                let dataJson = json["data"]
                let newTopic = ConvertTool.getTopicFromJSON(dataJson)
                self.topicDictionay[newTopic.id!] = newTopic
                finishedClosure()
        })
    }
    
    func getTopic(topicId topicId: String) -> TopicModel? {
        return topicDictionay[topicId]
    }
    
}
