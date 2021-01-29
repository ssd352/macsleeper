//
//  ViewController.swift
//  MacSleeper
//
//  Created by SS D on 2018-06-30.
//  Copyright © 2018 SS D. All rights reserved.
//

import Cocoa
import os.log
import Automator

class ViewController: NSViewController {
    
    @IBOutlet weak var countDownLabel: NSTextField!
    @IBOutlet weak var minutesTextField: NSTextField!
    @IBOutlet weak var commandPopUpButton: NSPopUpButton!
    
    var count = 0
    var sleepTimer : Timer?
    var minuteTimer: Timer?
    
    
    @IBAction func startButtonPressed(_ sender: Any) {
        self.countDownLabel.isHidden = false
        let mins = minutesTextField.doubleValue
        if let tmp = self.minuteTimer {
            tmp.invalidate()
        }
        if let tmp = self.sleepTimer {
            tmp.invalidate()
        }
        self.minuteTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(self.upd), userInfo: nil, repeats: true)
        self.sleepTimer = Timer.scheduledTimer(timeInterval: mins * 60, target: self, selector: #selector(self.sleep), userInfo: nil, repeats: false)
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
        guard let workflowPath = Bundle.main.path(forResource: "Force-Quit", ofType: "workflow") else {
                print("Workflow resource not found")
                return
            }
        var source = "set volume with output muted\ntell application \"Finder\" to sleep"
        let workflowURL = URL(fileURLWithPath: workflowPath)
        if (commandPopUpButton.selectedItem?.title == "Shut Down"){
            source = "tell application \"Finder\" to shut down"
            do {
                    try AMWorkflow.run(at:workflowURL, withInput: nil)
            } catch {
                    print("Error running workflow: \(error)")
                }
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

