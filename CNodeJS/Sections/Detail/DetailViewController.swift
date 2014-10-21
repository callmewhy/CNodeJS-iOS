//
//  DetailViewController.swift
//  CNodeJS
//
//  Created by why on 10/21/14.
//  Copyright (c) 2014 why. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var contentWebView: UIWebView!
    
    @IBOutlet weak var contentWebViewHeight: NSLayoutConstraint!
    var topic: TopicModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            var markdown = Markdown()
            let outputHtml: String = markdown.transform(content)
            contentWebView.loadHTMLString(outputHtml, baseURL: nil)
            contentWebViewHeight.constant = contentWebView.scrollView.contentSize.height
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
