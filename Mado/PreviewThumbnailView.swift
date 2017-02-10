//
//  PreviewThumbnailView.swift
//  Mado
//
//  Created by Shad Sharma on 2/4/17.
//  Copyright © 2017 Shad Sharma. All rights reserved.
//

import Cocoa

@IBDesignable
class PreviewThumbnailView: NSView {
    @IBInspectable var radius: CGFloat = 2.0
    var xpos: CGFloat? = nil
    var ypos: CGFloat? = nil
    var width: CGFloat? = nil
    var height: CGFloat? = nil
    
    func setInner(xpos: CGFloat, ypos: CGFloat, width: CGFloat, height: CGFloat) {
        self.xpos = xpos
        self.ypos = ypos
        self.width = width
        self.height = height
        setNeedsDisplay(bounds)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        let outer = NSBezierPath.init(roundedRect: bounds, xRadius: radius, yRadius: radius)
        NSColor.lightGray.set()
        outer.fill()
        
        if let xpos = xpos, let ypos = ypos, let width = width, let height = height {
            let innerBounds = NSRect(x: bounds.width * xpos, y: bounds.height * ypos, width: bounds.width * width, height: bounds.height * height)
            let inner = NSBezierPath.init(roundedRect: innerBounds, xRadius: radius, yRadius: radius)
            NSColor.black.set()
            inner.fill()
        }
    }
}
