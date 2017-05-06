//
//  AdhocResize.swift
//  Mado
//
//  Created by Shad Sharma on 2/16/17.
//  Copyright © 2017 Shad Sharma. All rights reserved.
//

import Cocoa

class AdhocResize: NSViewController {
    @IBOutlet weak var xPosTextField: NSTextField!
    @IBOutlet weak var yPosTextField: NSTextField!
    @IBOutlet weak var widthTextField: NSTextField!
    @IBOutlet weak var heightTextField: NSTextField!
    @IBOutlet weak var titleLabel: NSTextField!

    var window: AppWindow?
    var timer: Timer?
    
    convenience init(window: AppWindow?) {
        self.init(nibName: "AdhocResize", bundle: nil)!
        self.window = window
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        load(self)
        
        NSApp.activate(ignoringOtherApps: true)
        timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(updateWindow), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear() {
        if let timer = timer {
            timer.invalidate()
        }
    }

    func updateWindow(_ sender: Any) {
        if let window = AppWindow.frontmost(), window.appTitle != "Mado" {
            self.window = window
            load(sender)
        }
    }
    
    func load(_ sender: Any) {
        if let window = window, let title = window.appTitle, let frame = window.frame {
            controls(enable: true)
            titleLabel.stringValue = title
            xPosTextField.stringValue = Int(frame.origin.x).description
            yPosTextField.stringValue = Int(frame.origin.y).description
            widthTextField.stringValue = Int(frame.size.width).description
            heightTextField.stringValue = Int(frame.size.height).description
        } else {
            titleLabel.stringValue = "No Active Window"
            controls(enable: false)
        }
    }

    func controls(enable: Bool) {
        xPosTextField.isEnabled = enable
        yPosTextField.isEnabled = enable
        widthTextField.isEnabled = enable
        heightTextField.isEnabled = enable
    }

    @IBAction func fieldChanged(_ sender: Any) {
        guard let window = window else {
            return
        }
        
        let resizeSpec = ResizeSpec(xExpr: xPosTextField.stringValue,
                                    yExpr: yPosTextField.stringValue,
                                    wExpr: widthTextField.stringValue,
                                    hExpr: heightTextField.stringValue)
        
        window.resize(spec: resizeSpec)
        load(sender)
    }
}
