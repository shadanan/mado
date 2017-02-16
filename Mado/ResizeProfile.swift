//
//  ResizeProfileController.swift
//  Mado
//
//  Created by Shad Sharma on 2/5/17.
//  Copyright © 2017 Shad Sharma. All rights reserved.
//

import Cocoa

class ResizeProfile {
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var xposField: NSTextField!
    @IBOutlet weak var yposField: NSTextField!
    @IBOutlet weak var widthField: NSTextField!
    @IBOutlet weak var heightField: NSTextField!
    @IBOutlet weak var preview: Thumbnail!
    
    func evaluate(field: NSTextField) -> Double? {
        if let val = Expr.evaluate(exprStr: field.stringValue, W: 1920, H: 1080, x: 480, y: 270, w: 1280, h: 720) {
            field.layer?.borderWidth = 0
            return val
        } else {
            field.layer?.borderColor = NSColor.red.cgColor
            field.layer?.borderWidth = 2
            return nil
        }
    }
    
    @IBAction func evaluateSizeAndPosition(_ sender: Any?) {
        let xpos = evaluate(field: xposField)
        let ypos = evaluate(field: yposField)
        let width = evaluate(field: widthField)
        let height = evaluate(field: heightField)
        
        if let xpos = xpos, let ypos = ypos, let width = width, let height = height {
            preview.setInner(xpos: CGFloat(xpos/1920), ypos: CGFloat(ypos/1080),
                             width: CGFloat(width/1920), height: CGFloat(height/1080))
        }
    }    
}
