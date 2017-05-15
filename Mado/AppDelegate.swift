//
//  AppDelegate.swift
//  Mado
//
//  Created by Shad Sharma on 2/4/17.
//  Copyright © 2017 Shad Sharma. All rights reserved.
//

import Cocoa
import Carbon
import Antlr4

func eventCallback(proxy: CGEventTapProxy, type: CGEventType, event: CGEvent, refcon: UnsafeMutableRawPointer?) -> Unmanaged<CGEvent>? {
    
    if type == .keyDown {
        let appDelegate = NSApp.delegate as! AppDelegate
        
        // If the adhoc resize view is visible and Esc is pressed, close the view
        let key = KeyboardShortcut.from(CGEvent: event)
        if key.keyCode == kVK_Escape && appDelegate.adhocResizeView != nil {
            appDelegate.closeAdhocResizeView(nil)
            return nil
        }
        
        // If the shortcut registry matched, eat the event
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
    var statusMenu = NSMenu()

    let store = NSUbiquitousKeyValueStore.default()
    let registry = Registry()

    var eventTap: CFMachPort?
    var adhocResizeView: NSPopover?
    
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
        for resizePref in registry.registryItems {
            let menuItem = resizePref.makeMenuItem()
            statusMenu.addItem(menuItem)
        }
        
        // Add Quit
        statusMenu.addItem(NSMenuItem.separator())
        
        let quitMenuItem = NSMenuItem()
        quitMenuItem.title = "Quit"
        quitMenuItem.target = self
        quitMenuItem.action = #selector(quit)
        statusMenu.addItem(quitMenuItem)
        
        if let button = statusItem.button {
            button.target = self
            button.action = #selector(statusItemAction)
        }
    }
    
    func statusItemAction(_ sender: AnyObject?) {
        if adhocResizeView != nil {
            closeAdhocResizeView(sender)
            return
        }
        
        if let event = NSApp.currentEvent, event.modifierFlags.contains(.option) {
            showAdhocResizeView(sender)
        } else {
            statusItem.popUpMenu(statusMenu)
        }
    }
    
    func showAdhocResizeView(_ sender: AnyObject?) {
        if let button = statusItem.button {
            let appWindow = AppWindow.frontmost()
            
            let adhocResizeView = NSPopover()
            adhocResizeView.contentViewController = AdhocResize(window: appWindow)
            adhocResizeView.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            self.adhocResizeView = adhocResizeView
        }
    }
    
    func closeAdhocResizeView(_ sender: AnyObject?) {
        if let adhocResizeView = adhocResizeView {
            adhocResizeView.performClose(sender)
        }
        
        adhocResizeView = nil
    }
    
    func quit() {
        NSApp.terminate(self)
    }
}
