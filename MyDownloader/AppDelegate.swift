//
//  AppDelegate.swift
//  MyDownloader
//
//  Created by ay65535 on 2014/08/04.
//
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet var window: NSWindow
    @IBOutlet var txtField: NSTextField
    @IBOutlet var scrollView: NSScrollView
    
    var txtView : NSTextView {
    get {
        return scrollView.contentView.documentView as NSTextView
    }
    }
    
    var mydownloader: MyDownloader!
    
    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        // Insert code here to initialize your application
        mydownloader = MyDownloader()
    }
    
    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
    }
    
    @IBAction func btnClicked(sender: AnyObject) {
        var text = mydownloader.get()
        update(text)
    }
    
    func update(text: String) {
        txtView.insertText(text)
    }
    
}

