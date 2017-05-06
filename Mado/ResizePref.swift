//
//  ResizePref.swift
//  Mado
//
//  Created by Shad Sharma on 2/11/17.
//  Copyright © 2017 Shad Sharma. All rights reserved.
//

import Cocoa

class ResizePref: NSObject {
    var title: String
    var resizeSpec: ResizeSpec
    var shortcut: KeyboardShortcut
    
    init(title: String, resizeSpec: ResizeSpec, shortcut: KeyboardShortcut) {
        self.title = title
        self.resizeSpec = resizeSpec
        self.shortcut = shortcut
    }
    
    func makeMenuItem() -> NSMenuItem {
        let menuItem = NSMenuItem()
        menuItem.title = title
        menuItem.target = self
        menuItem.action = #selector(apply)
        menuItem.keyEquivalent = shortcut.character
        menuItem.keyEquivalentModifierMask = shortcut.keyEquivalentModifierMask
        
        let W: Double = 1920, H: Double = 1080, x: Double = 480, y: Double = 270, w: Double = 1280, h: Double = 720, TW: Double = 24, TH: Double = 14

        if let nx = Expr.evaluate(exprStr: resizeSpec.xExpr, W: W, H: H, x: x, y: y, w: w, h: h),
            let ny = Expr.evaluate(exprStr: resizeSpec.yExpr, W: W, H: H, x: x, y: y, w: w, h: h),
            let nw = Expr.evaluate(exprStr: resizeSpec.wExpr, W: W, H: H, x: x, y: y, w: w, h: h),
            let nh = Expr.evaluate(exprStr: resizeSpec.hExpr, W: W, H: H, x: x, y: y, w: w, h: h) {

            let menuItemView = Thumbnail(frame: NSRect(x: 0, y: 0, width: TW, height: TH))
            menuItemView.setInner(xpos: CGFloat(nx / W), ypos: CGFloat(ny / H), width: CGFloat(nw / W), height: CGFloat(nh / H))
            menuItem.image = menuItemView.render()
        }

        return menuItem
    }
    
    func apply() {
        if let frontMost = AppWindow.frontmost() {
            frontMost.resize(spec: resizeSpec)
        }
    }
}

class ResizeSpec: NSObject {
    var xExpr: String
    var yExpr: String
    var wExpr: String
    var hExpr: String

    init(xExpr: String, yExpr: String, wExpr: String, hExpr: String) {
        self.xExpr = xExpr
        self.yExpr = yExpr
        self.wExpr = wExpr
        self.hExpr = hExpr
    }
}
