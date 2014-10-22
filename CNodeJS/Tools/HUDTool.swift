//
//  HUDTool.swift
//  CNodeJS
//
//  Created by why on 10/22/14.
//  Copyright (c) 2014 why. All rights reserved.
//

import PKHUD

class HUDTool: NSObject {
    
    class func showTextView(textString: String) {
        HUDController.sharedController.contentView = HUDContentView.TextView(text: textString)
        HUDController.sharedController.show()
    }
    
    
    class func showProcessView() {
        HUDController.sharedController.contentView = HUDContentView.ProgressView()
        HUDController.sharedController.show()
    }
    
    class func hideView(animated: Bool) {
        HUDController.sharedController.hide(animated: animated)
    }
   
}
