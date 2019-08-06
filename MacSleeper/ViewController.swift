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
    //    var timer : Timer;
    
//    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
//        timer = Timer();
//    }
    var count = 0
    
    @IBAction func startButtonPressed(_ sender: Any) {
        let mins = minutesTextField.intValue
        Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(self.upd), userInfo: nil, repeats: true)
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
    
    @objc func upd() {
        if(self.count > 0) {
            self.count -= 1
            countDownLabel.stringValue = String(self.count)
        }
        if (self.count <= 0){
//            let source = "tell application \"Finder\"\nshut down\nend tell"
//            var source = "tell application \"Finder\" to sleep"
//            if (commandPopUpButton.selectedItem?.title == "Shut Down"){
//                source = "tell application \"Finder\" to shut down"
//            }
//            var error: NSDictionary?
//            let script = NSAppleScript(source: source)
            try{
            let task = NSUserAppleScriptTask.init(url: NSURL.fileURL(withPath:"/Users/ssd/Library/Application Scripts/io.ssd352.MacSleeper"))
            
            let script = NSAppleScript(contentsOf: NSURL.fileURL(withPath:"/Users/ssd/Library/Application Scripts/io.ssd352.MacSleeper"), error: nil)
            script?.executeAndReturnError(nil)
            }
//            os_log("%@", error!)
        }
    }

}

