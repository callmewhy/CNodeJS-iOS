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
    
    var myDataSource: ArrayDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup UI
        setupSementedControl()
        setupTableView()
        
        // Load data
        self.refreshTableData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Setup UI
    func setupSementedControl() {
        
        // Content
        segmentedControl.sectionTitles = ["全部","分享","问答","招聘"]
        
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
            self.checkTableData()
        }
    }

    func setupTableView() {
        var cellConfigureClosure: CellConfigureClosure = { cell,item in
            let myCell = cell as TopicTableViewCell
            let myItem = item as TopicModel
            myCell.titleLabel.text = myItem.title
            myCell.lastTimeLabel.text = myItem.lastTime
            myCell.authorLabel.text = myItem.author?.loginnName
        }
        myDataSource = ArrayDataSource(anItems:TopicStore.sharedInstance.topicArray[segmentedControl.selectedSegmentIndex], aCellIdentifier: "topicCell", aConfigureClosure: cellConfigureClosure)
        myTableView.dataSource = myDataSource
        
        checkTableData()
        
    }
    
    // check data of current type
    func checkTableData() {
        var nowIndex = segmentedControl.selectedSegmentIndex
        if(TopicStore.sharedInstance.topicArray[nowIndex].count == 0) {
            TopicStore.sharedInstance.loadData(TopicType(rawValue: nowIndex)!, finishedClosure:{
                self.refreshTableData()
            })
        }else{
            refreshTableData()
        }
    }
    
    // update datasource
    func refreshTableData() {
        var myDataSource = myTableView.dataSource as ArrayDataSource
        myDataSource.items = TopicStore.sharedInstance.topicArray[segmentedControl.selectedSegmentIndex]
        myTableView.reloadData()
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
