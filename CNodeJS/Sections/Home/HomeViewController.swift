//
//  HomeViewController.swift
//  CNodeJS
//
//  Created by why on 10/20/14.
//  Copyright (c) 2014 why. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var segmentedControl: HMSegmentedControl!
    @IBOutlet weak var myTableView: UITableView!
    
    var refreshControl = UIRefreshControl()
    
    var myDataSource: ArrayDataSource?
    
    var isLoadingMore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup UI
        setupSementedControl()
        setupTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Setup UI
    func setupSementedControl() {
        
        // Content
        segmentedControl.sectionTitles = TAB_VALUES
        
        // Type
        segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown
        
        // Size
        segmentedControl.selectionIndicatorHeight = 2
        
        // Color
        segmentedControl.textColor                  = SEGMENT_TEXT_COLOR
        segmentedControl.selectionIndicatorColor    = MAIN_COLOR
        segmentedControl.selectedTextColor          = MAIN_COLOR
        segmentedControl.backgroundColor            = SEGMENT_BACKGROUND_COLOR
        
        // Closure
        segmentedControl.indexChangeBlock = { sIndex in
            self.switchDataSource(index: sIndex);
        }
        
        self.switchDataSource();
    }

    func setupTableView() {
        
        // add refresh control
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新")
        refreshControl.addTarget(self, action: Selector("pullDown"), forControlEvents: .ValueChanged)

        myTableView.addSubview(refreshControl)
        
        // set data source
        var cellConfigureClosure: CellConfigureClosure = { cell,item in
            let myCell = cell as TopicTableViewCell
            let myItem = item as TopicModel
            myCell.titleLabel.text = myItem.title
            myCell.lastTimeLabel.text = myItem.lastTime
            myCell.authorLabel.text = myItem.author?.loginName
        }
        myDataSource = ArrayDataSource(anItems:TopicStore.sharedInstance[segmentedControl.selectedSegmentIndex], aCellIdentifier: "topicCell", aConfigureClosure: cellConfigureClosure)
        myTableView.dataSource = myDataSource
    }
    
    // MARK: - uitableview
    // switch data source while switching tab
    func switchDataSource(index : NSInteger = 0) {
        if (TopicStore.sharedInstance[index].count > 0) {
            self.updateDataSource();
        } else {
            HUDTool.showTextView("正在加载数据请稍后...")
            self.refreshTableData();
        }
    }
    
    // refresh control pull down
    func pullDown() {
        refreshTableData()
    }
    
    // refresh tablew data from api
    func refreshTableData() {
        TopicStore.sharedInstance.loadTopics(type: TopicType(rawValue: segmentedControl.selectedSegmentIndex)!, mode:.Refresh, finishedClosure:{
            self.updateDataSource()
            self.refreshControl.endRefreshing()
            HUDTool.hideView(false)
        })
    }
    
    // update datasource
    func updateDataSource() {
        var myDataSource = myTableView.dataSource as ArrayDataSource
        myDataSource.items = TopicStore.sharedInstance[segmentedControl.selectedSegmentIndex]
        myTableView.reloadData()
    }
    
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if let count = myDataSource?.items.count {
            if indexPath.row == count - 5 && !isLoadingMore {
                isLoadingMore = true
                TopicStore.sharedInstance.loadTopics(type: TopicType(rawValue: segmentedControl.selectedSegmentIndex)!, mode:.LoadMore, finishedClosure:{
                    self.isLoadingMore = false
                    self.updateDataSource()
                })
            }
        }
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let id = segue.identifier as String!
        switch id {
        case "goDetail" :
            let selIndexPath = myTableView.indexPathForSelectedRow()!
            myTableView.deselectRowAtIndexPath(selIndexPath, animated: false)
            var detailVC = segue.destinationViewController as DetailViewController
            var currentArray = TopicStore.sharedInstance[segmentedControl.selectedSegmentIndex]
            detailVC.topic = currentArray[selIndexPath.row] as TopicModel
        default:
            println("default segue")
        }

    }
    
}
