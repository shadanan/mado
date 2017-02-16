//
//  AppDelegate.swift
//  Mado
//
//  Created by Shad Sharma on 2/4/17.
//  Copyright © 2017 Shad Sharma. All rights reserved.
//

import Cocoa
import Antlr4

func eventCallback(proxy: CGEventTapProxy, type: CGEventType, event: CGEvent, refcon: UnsafeMutableRawPointer?) -> Unmanaged<CGEvent>? {
    
    if type == .keyDown {
        let appDelegate = NSApplication.shared().delegate as! AppDelegate
        if appDelegate.registry.keyDown(event: event) {
            return nil
        }
    }
    
    return Unmanaged.passRetained(event)
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    let statusImage = NSImage(named: "StatusItem")!
    let store = NSUbiquitousKeyValueStore.default()
    let registry = Registry()
    var eventTap: CFMachPort?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let eventTap = CGEvent.tapCreate(tap: .cgSessionEventTap, place: .headInsertEventTap, options: .defaultTap, eventsOfInterest: CGEventMask(1 << CGEventType.keyDown.rawValue), callback: eventCallback, userInfo: nil) {
            // Initialize global key press notifications.
            let runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0)
            CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, .commonModes)
            self.eventTap = eventTap
            enable()
        } else {
            // If we couldn't enable notifications, we probably don't have permission.
            let alert = NSAlert()
            alert.messageText = "Mado requires permission to use Accessibility features."
            alert.informativeText = "To proceed, you will need to give Mado permission to use Accessibility. Click the Grant Access button and you will be presented with a dialog that takes you to System Preferences. After granting access, relaunch Mado."
            alert.addButton(withTitle: "Grant Access")
            alert.addButton(withTitle: "Cancel")
            
            let response = alert.runModal()
            if response == 1000 {
                let options = NSDictionary(object: kCFBooleanTrue, forKey: kAXTrustedCheckOptionPrompt.takeUnretainedValue() as NSString) as CFDictionary
                AXIsProcessTrustedWithOptions(options)
            }
            
            NSApp.terminate(self)
        }
        
        // Insert code here to initialize your application
        statusImage.size = NSMakeSize(20, 20)
        statusItem.image = statusImage
        
        loadMenu()
    }

    func enable() {
        if let eventTap = eventTap {
            CGEvent.tapEnable(tap: eventTap, enable: true)
        }
    }
    
    func disable() {
        if let eventTap = eventTap {
            CGEvent.tapEnable(tap: eventTap, enable: false)
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        disable()
    }
    
    func loadMenu() {
        statusItem.menu = NSMenu()
        if let menu = statusItem.menu {
            for resizePref in registry.resizePrefs {
                let menuItem = resizePref.makeMenuItem()
                menu.addItem(menuItem)
            }
            
            // Add Quit
            menu.addItem(NSMenuItem.separator())
            
            let quitMenuItem = NSMenuItem()
            quitMenuItem.title = "Quit"
            quitMenuItem.target = self
            quitMenuItem.action = #selector(quit)
            menu.addItem(quitMenuItem)
        }
    }
    
    func quit() {
        NSApp.terminate(self)
    }
}
