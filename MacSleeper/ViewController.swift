//
//  ViewController.swift
//  MacSleeper
//
//  Created by SS D on 2018-06-30.
//  Copyright © 2018 SS D. All rights reserved.
//

import Cocoa
import os.log

class ViewController: NSViewController {
    
    @IBOutlet weak var countDownLabel: NSTextField!
    @IBOutlet weak var minutesTextField: NSTextField!
    @IBOutlet weak var commandPopUpButton: NSPopUpButton!
    
    var count = 0
    
    @IBAction func startButtonPressed(_ sender: Any) {
        self.countDownLabel.isHidden = false
        let mins = minutesTextField.doubleValue
        Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(self.upd), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: mins * 60, target: self, selector: #selector(self.sleep), userInfo: nil, repeats: false)
        self.count = Int(mins)
        countDownLabel.stringValue = String(self.count)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @objc func sleep(){
        var source = "set volume with output muted\ntell application \"Finder\" to sleep"
        if (commandPopUpButton.selectedItem?.title == "Shut Down"){
            source = "tell application \"Finder\" to shut down"
        }
        let script = NSAppleScript(source: source)
        script?.executeAndReturnError(nil)
    }
    
    @objc func upd() {
        if(self.count > 0) {
            self.count -= 1
            countDownLabel.stringValue = String(self.count)
        }
    }

}

