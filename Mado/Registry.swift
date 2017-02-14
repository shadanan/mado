//
//  Registry.swift
//  Mado
//
//  Created by Shad Sharma on 2/14/17.
//  Copyright © 2017 Shad Sharma. All rights reserved.
//

import Cocoa

class Registry {
    var resizePrefs: [ResizePref] = []
    var monitor: Any!
    
    init() {
        monitor = NSEvent.addGlobalMonitorForEvents(matching: .keyDown, handler: self.keyDown)
        
        let left = ResizePref(title: "Left", xExpr: "0", yExpr: "0", wExpr: "W/2", hExpr: "H", shortcut: KeyboardShortcut(keyCode: 123, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        resizePrefs.append(left)

        let right = ResizePref(title: "Right", xExpr: "W/2", yExpr: "0", wExpr: "W/2", hExpr: "H", shortcut: KeyboardShortcut(keyCode: 124, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        resizePrefs.append(right)

        let maximize = ResizePref(title: "Maximize", xExpr: "0", yExpr: "0", wExpr: "W", hExpr: "H", shortcut: KeyboardShortcut(keyCode: 36, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        resizePrefs.append(maximize)
    }
    
    func keyDown(event: NSEvent) {
        print(event)
        let shortcut = KeyboardShortcut.from(NSEvent: event)
        for resizePref in resizePrefs {
            if resizePref.shortcut == shortcut {
                resizePref.apply()
            }
        }
    }
    
    deinit {
        NSEvent.removeMonitor(monitor)
    }
}
