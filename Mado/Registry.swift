//
//  Registry.swift
//  Mado
//
//  Created by Shad Sharma on 2/14/17.
//  Copyright © 2017 Shad Sharma. All rights reserved.
//

import Cocoa

class Registry {
    var registryItems: [RegistryItem] = []
    
    init() {
        load()
    }
    
    func save() {
        print("Save registry")

        var encodedRegistry: [[String: Any]] = []

        for registryItem in registryItems {
            encodedRegistry.append(registryItem.encode())
        }

        UserDefaults.standard.set(encodedRegistry, forKey: "registry")
    }
    
    func load() {
        print("Load registry")

        if let encodedRegistry = UserDefaults.standard.array(forKey: "registry") as? [[String: Any]] {
            registryItems.removeAll()

            for encodedRegistryItem in encodedRegistry {
                if let registryItem = decode(encodedRegistryItem: encodedRegistryItem) {
                    registryItems.append(registryItem)
                } else {
                    print("Failed to decode: \(encodedRegistryItem)")
                    reset()
                    return
                }
            }
        } else {
            reset()
        }
    }
    
    func reset() {
        print("Reset registry")

        registryItems.removeAll()
        
        let left = Resize(
            title: "Left",
            resizeSpec: ResizeSpec(xExpr: "0", yExpr: "0", wExpr: "W/2", hExpr: "H"),
            shortcut: KeyboardShortcut(keyCode: 123, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        registryItems.append(left)
        
        let right = Resize(
            title: "Right",
            resizeSpec: ResizeSpec(xExpr: "W/2", yExpr: "0", wExpr: "W/2", hExpr: "H"),
            shortcut: KeyboardShortcut(keyCode: 124, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        registryItems.append(right)
        
        let up = Resize(
            title: "Up",
            resizeSpec: ResizeSpec(xExpr: "0", yExpr: "H/2", wExpr: "W", hExpr: "H/2"),
            shortcut: KeyboardShortcut(keyCode: 126, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        registryItems.append(up)
        
        let down = Resize(
            title: "Down",
            resizeSpec: ResizeSpec(xExpr: "0", yExpr: "0", wExpr: "W", hExpr: "H/2"),
            shortcut: KeyboardShortcut(keyCode: 125, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        registryItems.append(down)
        
        registryItems.append(Separator.separator)
        
        let topLeft = Resize(
            title: "Top Left",
            resizeSpec: ResizeSpec(xExpr: "0", yExpr: "H/2", wExpr: "W/2", hExpr: "H/2"),
            shortcut: KeyboardShortcut(keyCode: 32, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        registryItems.append(topLeft)
        
        let topRight = Resize(
            title: "Top Right",
            resizeSpec: ResizeSpec(xExpr: "W/2", yExpr: "H/2", wExpr: "W/2", hExpr: "H/2"),
            shortcut: KeyboardShortcut(keyCode: 34, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        registryItems.append(topRight)
        
        let bottomLeft = Resize(
            title: "Bottom Left",
            resizeSpec: ResizeSpec(xExpr: "0", yExpr: "0", wExpr: "W/2", hExpr: "H/2"),
            shortcut: KeyboardShortcut(keyCode: 38, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        registryItems.append(bottomLeft)
        
        let bottomRight = Resize(
            title: "Bottom Right",
            resizeSpec: ResizeSpec(xExpr: "W/2", yExpr: "0", wExpr: "W/2", hExpr: "H/2"),
            shortcut: KeyboardShortcut(keyCode: 40, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        registryItems.append(bottomRight)
        
        registryItems.append(Separator.separator)
        
        let leftThird = Resize(
            title: "Left Third",
            resizeSpec: ResizeSpec(xExpr: "0", yExpr: "0", wExpr: "W/3", hExpr: "H"),
            shortcut: KeyboardShortcut(keyCode: 2, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        registryItems.append(leftThird)
        
        let centerThird = Resize(
            title: "Center Third",
            resizeSpec: ResizeSpec(xExpr: "W/3", yExpr: "0", wExpr: "W/3", hExpr: "H"),
            shortcut: KeyboardShortcut(keyCode: 3, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        registryItems.append(centerThird)
        
        let rightThird = Resize(
            title: "Right Third",
            resizeSpec: ResizeSpec(xExpr: "2W/3", yExpr: "0", wExpr: "W/3", hExpr: "H"),
            shortcut: KeyboardShortcut(keyCode: 5, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        registryItems.append(rightThird)
        
        let leftTwoThirds = Resize(
            title: "Left Two Thirds",
            resizeSpec: ResizeSpec(xExpr: "0", yExpr: "0", wExpr: "2W/3", hExpr: "H"),
            shortcut: KeyboardShortcut(keyCode: 14, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        registryItems.append(leftTwoThirds)
        
        let rightTwoThirds = Resize(
            title: "Right Two Thirds",
            resizeSpec: ResizeSpec(xExpr: "W/3", yExpr: "0", wExpr: "2W/3", hExpr: "H"),
            shortcut: KeyboardShortcut(keyCode: 17, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        registryItems.append(rightTwoThirds)
        
        registryItems.append(Separator.separator)
        
        let center = Resize(
            title: "Center",
            resizeSpec: ResizeSpec(xExpr: "(W-w)/2", yExpr: "(H-h)/2", wExpr: "w", hExpr: "h"),
            shortcut: KeyboardShortcut(keyCode: 8, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        registryItems.append(center)
        
        let maximize = Resize(
            title: "Maximize",
            resizeSpec: ResizeSpec(xExpr: "0", yExpr: "0", wExpr: "W", hExpr: "H"),
            shortcut: KeyboardShortcut(keyCode: 36, shiftDown: false, controlDown: true, optionDown: true, commandDown: false))
        registryItems.append(maximize)
        
        save()
    }
    
    func keyDown(event: CGEvent) -> Bool {
        let shortcut = KeyboardShortcut.from(CGEvent: event)
        print("Shortcut: \(shortcut)  KeyCode: \(shortcut.keyCode)")

        for resizePref in registryItems {
            if resizePref.matches(shortcut: shortcut) {
                resizePref.apply()
                return true
            }
        }
        
        return false
    }
}
