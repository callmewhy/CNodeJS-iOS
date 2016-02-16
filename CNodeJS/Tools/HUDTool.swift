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
        PKHUD.sharedHUD.contentView = PKHUDTextView(text: textString)
        PKHUD.sharedHUD.show()
    }
    
    class func showProcessView() {
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
    }
    
    class func hideView(animated: Bool) {
        PKHUD.sharedHUD.hide(animated: animated)
    }
}
