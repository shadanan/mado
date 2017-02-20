//
//  AdhocResize.swift
//  Mado
//
//  Created by Shad Sharma on 2/16/17.
//  Copyright © 2017 Shad Sharma. All rights reserved.
//

import Cocoa

class AdhocResize: NSViewController {
    var window: AppWindow?
    
    convenience init(window: AppWindow?) {
        self.init(nibName: "AdhocResize", bundle: nil)!
        self.window = window
    }
}
