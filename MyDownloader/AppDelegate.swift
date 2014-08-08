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
    @IBOutlet var scrollView2: NSScrollView
    @IBOutlet var scrollView3: NSScrollView
    
    var txtView : NSTextView {
    get {
        return scrollView.contentView.documentView as NSTextView
    }
    }
    
    var txtView2 : NSTextView {
    get {
        return scrollView2.contentView.documentView as NSTextView
    }
    }
    
    var txtView3 : NSTextView {
    get {
        return scrollView3.contentView.documentView as NSTextView
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
        var text = mydownloader.getSubjecttxt()
        updateSubjectTxtView(text)
        var dat = mydownloader.getDat(txtField.stringValue)
        updateDatTxtView(dat)
        var urls = mydownloader.grepUrls(dat)
        updateUrlTxtView(urls)
        
    }
    
    func updateSubjectTxtView(text: String) {
        txtView.insertText(text)
    }
    
    func updateDatTxtView(dat: String) {
        txtView2.insertText(dat)
    }
    
    func updateUrlTxtView(urls: String) {
        txtView3.insertText(urls)
    }
}

