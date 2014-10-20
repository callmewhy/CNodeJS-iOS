//
//  ArrayDataSource.swift
//  CNodeJS
//
//  Created by why on 10/20/14.
//  Copyright (c) 2014 why. All rights reserved.
//


typealias CellConfigureClosure = (cell:AnyObject, item:AnyObject) -> Void


class ArrayDataSource: NSObject, UITableViewDataSource {
    
    
    var items: [AnyObject]?
    var cellIdentifier: NSString?
    var configureClosure: CellConfigureClosure?
    
    init(anItems:[AnyObject], aCellIdentifier:NSString, aConfigureClosure:CellConfigureClosure) {
        items = anItems
        cellIdentifier = aCellIdentifier
        configureClosure = aConfigureClosure
    }
    
    func itemAtIndex(index:NSIndexPath) -> AnyObject {
        return items![index.row]
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier!, forIndexPath: indexPath) as UITableViewCell
        var item: AnyObject = itemAtIndex(indexPath)
        configureClosure!(cell: cell, item: item)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items!.count
    }
    
    
    
    
}
