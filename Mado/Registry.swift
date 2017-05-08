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
    
    init() {
        let left = ResizePref(title: "Left",
                              resizeSpec: ResizeSpec(xExpr: "0", yExpr: "0", wExpr: "W/2", hExpr: "H"),
                              shortcut: KeyboardShortcut(keyCode: 123, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        resizePrefs.append(left)

        let right = ResizePref(title: "Right",
                               resizeSpec: ResizeSpec(xExpr: "W/2", yExpr: "0", wExpr: "W/2", hExpr: "H"),
                               shortcut: KeyboardShortcut(keyCode: 124, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        resizePrefs.append(right)

        let up = ResizePref(title: "Up",
                            resizeSpec: ResizeSpec(xExpr: "0", yExpr: "H/2", wExpr: "W", hExpr: "H/2"),
                            shortcut: KeyboardShortcut(keyCode: 126, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        resizePrefs.append(up)
        
        let down = ResizePref(title: "Down",
                              resizeSpec: ResizeSpec(xExpr: "0", yExpr: "0", wExpr: "W", hExpr: "H/2"),
                              shortcut: KeyboardShortcut(keyCode: 125, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        resizePrefs.append(down)
        
        let topLeft = ResizePref(title: "Top Left",
                                 resizeSpec: ResizeSpec(xExpr: "0", yExpr: "H/2", wExpr: "W/2", hExpr: "H/2"),
                                 shortcut: KeyboardShortcut(keyCode: 32, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        resizePrefs.append(topLeft)
        
        let topRight = ResizePref(title: "Top Right",
                                  resizeSpec: ResizeSpec(xExpr: "W/2", yExpr: "H/2", wExpr: "W/2", hExpr: "H/2"),
                                  shortcut: KeyboardShortcut(keyCode: 34, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        resizePrefs.append(topRight)
        
        let bottomLeft = ResizePref(title: "Bottom Left",
                                    resizeSpec: ResizeSpec(xExpr: "0", yExpr: "0", wExpr: "W/2", hExpr: "H/2"),
                                    shortcut: KeyboardShortcut(keyCode: 38, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        resizePrefs.append(bottomLeft)
        
        let bottomRight = ResizePref(title: "Bottom Right",
                                     resizeSpec: ResizeSpec(xExpr: "W/2", yExpr: "0", wExpr: "W/2", hExpr: "H/2"),
                                     shortcut: KeyboardShortcut(keyCode: 40, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        resizePrefs.append(bottomRight)
        
        let leftThird = ResizePref(title: "Left Third",
                                   resizeSpec: ResizeSpec(xExpr: "0", yExpr: "0", wExpr: "W/3", hExpr: "H"),
                                   shortcut: KeyboardShortcut(keyCode: 2, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        resizePrefs.append(leftThird)
        
        let centerThird = ResizePref(title: "Center Third",
                                     resizeSpec: ResizeSpec(xExpr: "W/3", yExpr: "0", wExpr: "W/3", hExpr: "H"),
                                     shortcut: KeyboardShortcut(keyCode: 3, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        resizePrefs.append(centerThird)
        
        let rightThird = ResizePref(title: "Right Third",
                                    resizeSpec: ResizeSpec(xExpr: "2W/3", yExpr: "0", wExpr: "W/3", hExpr: "H"),
                                    shortcut: KeyboardShortcut(keyCode: 5, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        resizePrefs.append(rightThird)
        
        let leftTwoThirds = ResizePref(title: "Left Two Thirds",
                                       resizeSpec: ResizeSpec(xExpr: "0", yExpr: "0", wExpr: "2W/3", hExpr: "H"),
                                       shortcut: KeyboardShortcut(keyCode: 14, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        resizePrefs.append(leftTwoThirds)
        
        let rightTwoThirds = ResizePref(title: "Right Two Thirds",
                                       resizeSpec: ResizeSpec(xExpr: "W/3", yExpr: "0", wExpr: "2W/3", hExpr: "H"),
                                       shortcut: KeyboardShortcut(keyCode: 17, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        resizePrefs.append(rightTwoThirds)
        
        let center = ResizePref(title: "Center",
                                  resizeSpec: ResizeSpec(xExpr: "(W-w)/2", yExpr: "(H-h)/2", wExpr: "w", hExpr: "h"),
                                  shortcut: KeyboardShortcut(keyCode: 8, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        resizePrefs.append(center)

        let maximize = ResizePref(title: "Maximize",
                                  resizeSpec: ResizeSpec(xExpr: "0", yExpr: "0", wExpr: "W", hExpr: "H"),
                                  shortcut: KeyboardShortcut(keyCode: 36, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        resizePrefs.append(maximize)
    }
    
    func keyDown(event: CGEvent) -> Bool {
        let shortcut = KeyboardShortcut.from(CGEvent: event)
        print("Shortcut: \(shortcut)  KeyCode: \(shortcut.keyCode)")

        for resizePref in resizePrefs {
            if resizePref.shortcut == shortcut {
                resizePref.apply()
                return true
            }
        }
        
        return false
    }
}
