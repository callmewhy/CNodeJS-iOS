//
//  DetailViewController.swift
//  CNodeJS
//
//  Created by why on 10/21/14.
//  Copyright (c) 2014 why. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var contentWebView: UIWebView!
    @IBOutlet weak var contentWebViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var replyTableView: UITableView!
    @IBOutlet weak var replyTableViewHeight: NSLayoutConstraint!
    
    
    
    var topic: TopicModel?
    
    var replyDataSource: ArrayDataSource?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFromTopic()
    }
    
    func setupFromTopic() {
        // get title
        titleLabel.text = topic?.title
        
        // get tab name
        var tabName = ""
        if let tab = topic?.tab {
            if let name = TAB_DIC[tab] {
                tabName = name
            }
        }
        
        // get author name
        var authorName = ""
        if let name = topic?.author?.loginName {
            authorName = name
        }
        
        // assembly info label
        infoLabel.text = "作者：\(authorName)    来自：\(tabName)"
        
        // set content view
        if let content = topic?.content as String? {
            let outputHtml: String = MMMarkdown.HTMLStringWithMarkdown(topic?.content, error: nil)
            contentWebView.loadHTMLString(outputHtml, baseURL: NSURL(string: "https://cnodejs.org/"))
        }
    }
    
    func setupReplyTableView() {
        var cellConfigureClosure: CellConfigureClosure = { cell,item in
            let myCell = cell as ReplyTableViewCell
            let myItem = item as Reply
            myCell.timeLabel.text = myItem.createAt
            myCell.contentLabel.text = myItem.content
            myCell.nameLabel.text = myItem.author?.loginName
        }
        replyDataSource = ArrayDataSource(anItems:topic!.replies, aCellIdentifier: "replyCell", aConfigureClosure: cellConfigureClosure)
        replyTableView.dataSource = replyDataSource
        replyTableViewHeight.constant = CGFloat(topic!.replies.count * 50)
        replyTableView.reloadData()
        replyTableView.hidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - UIWebViewDelegate
    func webViewDidFinishLoad(webView: UIWebView) {
        var frame = webView.frame
        var fittingSize = webView.sizeThatFits(CGSizeZero)
        contentWebViewHeight.constant = fittingSize.height
        
        if let id = topic?.id {
            TopicStore.sharedInstance.loadTopic(topicId: id, finishedClosure: {
                self.topic = TopicStore.sharedInstance.getTopic(topicId: id)
                self.setupReplyTableView()
            })
        }
    }

    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        println(request.URL.description)
        if (request.URL.description.hasPrefix("https://cnodejs.org/")) {
            return true
        }
        
        UIApplication.sharedApplication().openURL(request.URL)
        return false
        
    }
    


    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
