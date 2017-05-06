//
//  AccessibilityElement.swift
//  MadoSize
//
//  Created by Shad Sharma on 7/3/16.
//  Copyright © 2016 Shad Sharma. All rights reserved.
//

import Cocoa
import Foundation

class AppWindow: CustomStringConvertible {
    let app: NSRunningApplication
    let appElement: AXUIElement
    let windowElement: AXUIElement
    
    static func frontmost() -> AppWindow? {
        guard let frontmostApplication = NSWorkspace.shared().frontmostApplication else {
            return nil
        }
        
        let appElement = AXUIElementCreateApplication(frontmostApplication.processIdentifier)

        var result: AnyObject?
        guard AXUIElementCopyAttributeValue(appElement, kAXFocusedWindowAttribute as CFString, &result) == .success else {
            return nil
        }
        
        let windowElement = result as! AXUIElement
        return AppWindow(app: frontmostApplication, appElement: appElement, windowElement: windowElement)
    }
    
    var primaryScreenHeight: CGFloat {
        get {
            if let screens = NSScreen.screens() {
                return screens[0].frame.maxY
            } else {
                return 0
            }
        }
    }
    
    init(app: NSRunningApplication, appElement: AXUIElement, windowElement: AXUIElement) {
        self.app = app
        self.appElement = appElement
        self.windowElement = windowElement
    }
    
    fileprivate func value(_ attribute: String, type: AXValueType) -> AXValue? {
        guard CFGetTypeID(windowElement) == AXUIElementGetTypeID() else {
            return nil
        }
        
        var result: AnyObject?
        guard AXUIElementCopyAttributeValue(windowElement, attribute as CFString, &result) == .success else {
            return nil
        }
        
        let value = result as! AXValue
        guard AXValueGetType(value) == type else {
            return nil
        }
        
        return value
    }
    
    fileprivate func setValue(_ value: AXValue, attribute: String) {
        let status = AXUIElementSetAttributeValue(windowElement, attribute as CFString, value)

        if status != .success {
            print("Failed to set \(attribute)=\(value)")
        }
    }
    
    fileprivate var appOrigin: CGPoint? {
        get {
            guard let positionValue = value(kAXPositionAttribute, type: .cgPoint) else {
                return nil
            }
            
            var position = CGPoint()
            AXValueGetValue(positionValue, .cgPoint, &position)
            
            return position
        }
        
        set {
            var origin = newValue
            guard let positionRef = AXValueCreate(.cgPoint, &origin) else {
                print("Failed to create positionRef")
                return
            }
            
            setValue(positionRef, attribute: kAXPositionAttribute)
        }
    }
    
    var origin: CGPoint? {
        get {
            guard let appOrigin = appOrigin, let size = size else {
                return nil
            }
            
            return CGPoint(x: appOrigin.x, y: primaryScreenHeight - size.height - appOrigin.y)
        }
        
        set {
            if let newOrigin = newValue, let size = size {
                appOrigin = CGPoint(x: newOrigin.x, y: primaryScreenHeight - size.height - newOrigin.y)
            }
        }
    }
    
    var size: CGSize? {
        get {
            guard let sizeValue = value(kAXSizeAttribute, type: .cgSize) else {
                return nil
            }
            
            var size = CGSize()
            AXValueGetValue(sizeValue, .cgSize, &size)
            
            return size
        }
        
        set {
            var size = newValue
            guard let sizeRef = AXValueCreate(.cgSize, &size) else {
                print("Failed to create sizeRef")
                return
            }
            
            setValue(sizeRef, attribute: kAXSizeAttribute)
        }
    }
    
    var globalFrame: CGRect? {
        get {
            guard let origin = appOrigin, let size = size else {
                return nil
            }
            
            return CGRect(origin: CGPoint(x: origin.x, y: primaryScreenHeight - size.height - origin.y), size: size)
        }
        
        set {
            if let frame = newValue {
                appOrigin = CGPoint(x: frame.origin.x, y: primaryScreenHeight - frame.size.height - frame.origin.y)
                size = frame.size
            }
        }
    }
    
    var frame: CGRect? {
        get {
            guard let screen = screen(), let globalFrame = globalFrame else {
                return nil
            }
            
            return CGRect(origin: globalFrame.origin - screen.frame.origin, size: globalFrame.size)
        }
        
        set {
            if let screen = screen(), let localFrame = newValue {
                globalFrame = CGRect(origin: localFrame.origin + screen.frame.origin, size: localFrame.size)
            }
        }
    }
    
    func resize(spec: ResizeSpec) {
        if let visibleFrame = screen()?.visibleFrame, let origin = origin, let size = size {
            let W = Double(visibleFrame.width)
            let H = Double(visibleFrame.height)
            let X = Double(visibleFrame.origin.x)
            let Y = Double(visibleFrame.origin.y)
            let x = Double(origin.x)
            let y = Double(origin.y)
            let w = Double(size.width)
            let h = Double(size.height)
            
            if let nx = Expr.evaluate(exprStr: spec.xExpr, W: W, H: H, x: x, y: y, w: w, h: h),
                let ny = Expr.evaluate(exprStr: spec.yExpr, W: W, H: H, x: x, y: y, w: w, h: h),
                let nw = Expr.evaluate(exprStr: spec.wExpr, W: W, H: H, x: x, y: y, w: w, h: h),
                let nh = Expr.evaluate(exprStr: spec.hExpr, W: W, H: H, x: x, y: y, w: w, h: h) {
                globalFrame = CGRect(x: nx + X, y: ny + Y, width: nw, height: nh)
            }
        }
    }
    
    func activateWithOptions(_ options: NSApplicationActivationOptions) {
        app.activate(options: options)
    }
    
    func screen() -> NSScreen? {
        guard let screens = NSScreen.screens(), let screenFrame = globalFrame else {
            return nil
        }
        
        var result: NSScreen? = nil
        var area: CGFloat = 0

        for screen in screens {
            let overlap = screen.frame.intersection(screenFrame)
            if overlap.width * overlap.height > area {
                area = overlap.width * overlap.height
                result = screen
            }
        }
        
        return result
    }
    
    var appTitle: String? {
        get {
            guard CFGetTypeID(appElement) == AXUIElementGetTypeID() else {
                return nil
            }
            
            var result: AnyObject?
            guard AXUIElementCopyAttributeValue(appElement, kAXTitleAttribute as CFString, &result) == .success else {
                return nil
            }
            
            return result as? String
        }
    }
    
    var windowTitle: String? {
        get {
            guard CFGetTypeID(windowElement) == AXUIElementGetTypeID() else {
                return nil
            }
            
            var result: AnyObject?
            guard AXUIElementCopyAttributeValue(windowElement, kAXTitleAttribute as CFString, &result) == .success else {
                return nil
            }
            
            return result as? String
        }
    }
    
    var description: String {
        get {
            return "\(String(describing: appTitle)): \(String(describing: windowTitle)) - Frame: \(String(describing: frame))"
        }
    }
}

func +(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func -(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}
