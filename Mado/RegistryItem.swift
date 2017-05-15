//
//  RegistryItem.swift
//  Mado
//
//  Created by Shad Sharma on 5/14/17.
//  Copyright © 2017 Shad Sharma. All rights reserved.
//

import Cocoa

protocol RegistryItem {
    func makeMenuItem() -> NSMenuItem
    func matches(shortcut: KeyboardShortcut) -> Bool
    func apply()

    func encode() -> [String: Any]
    static func decode(encodedRegistryItem: [String: Any]) -> RegistryItem?
}

func decode(encodedRegistryItem: [String: Any]) -> RegistryItem? {
    if encodedRegistryItem["type"] as? String == "Resize" {
        return Resize.decode(encodedRegistryItem: encodedRegistryItem)
    } else if encodedRegistryItem["type"] as? String == "Separator" {
        return Separator.decode(encodedRegistryItem: encodedRegistryItem)
    }
    
    return nil
}

class Resize: NSObject, RegistryItem {
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
    
    func matches(shortcut: KeyboardShortcut) -> Bool {
        return self.shortcut == shortcut
    }
    
    func apply() {
        if let frontMost = AppWindow.frontmost() {
            frontMost.resize(spec: resizeSpec)
        }
    }
    
    func encode() -> [String : Any] {
        return [
            "type": "Resize",
            "title": title,
            "xExpr": resizeSpec.xExpr,
            "yExpr": resizeSpec.yExpr,
            "wExpr": resizeSpec.wExpr,
            "hExpr": resizeSpec.hExpr,
            "keyCode": shortcut.keyCode,
            "shiftDown": shortcut.shiftDown,
            "controlDown": shortcut.controlDown,
            "optionDown": shortcut.optionDown,
            "commandDown": shortcut.commandDown]
    }

    static func decode(encodedRegistryItem: [String: Any]) -> RegistryItem? {
        if let title = encodedRegistryItem["title"] as? String,
            let xExpr = encodedRegistryItem["xExpr"] as? String,
            let yExpr = encodedRegistryItem["yExpr"] as? String,
            let wExpr = encodedRegistryItem["wExpr"] as? String,
            let hExpr = encodedRegistryItem["hExpr"] as? String,
            let keyCode = encodedRegistryItem["keyCode"] as? Int,
            let shiftDown = encodedRegistryItem["shiftDown"] as? Bool,
            let controlDown = encodedRegistryItem["controlDown"] as? Bool,
            let optionDown = encodedRegistryItem["optionDown"] as? Bool,
            let commandDown = encodedRegistryItem["commandDown"] as? Bool {
            
            return Resize(
                title: title,
                resizeSpec: ResizeSpec(xExpr: xExpr, yExpr: yExpr, wExpr: wExpr, hExpr: hExpr),
                shortcut: KeyboardShortcut(keyCode: keyCode, shiftDown: shiftDown, controlDown: controlDown, optionDown: optionDown, commandDown: commandDown))
        }
        
        return nil
    }
}

class Separator: NSObject, RegistryItem {
    static let separator = Separator()

    func makeMenuItem() -> NSMenuItem {
        return NSMenuItem.separator()
    }

    func matches(shortcut: KeyboardShortcut) -> Bool {
        return false
    }
    
    func apply() {
        return
    }

    func encode() -> [String : Any] {
        return ["type": "Separator"]
    }
    
    static func decode(encodedRegistryItem: [String : Any]) -> RegistryItem? {
        return separator
    }
}
