//
//  AppDelegate.swift
//  MyDownloader
//
//  Created by ay65535 on 2014/08/04.
//
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var txtField: NSTextField!
    @IBOutlet weak var scrollView: NSScrollView!
    @IBOutlet weak var grepSbjecttxtScrollView: NSScrollView!
    @IBOutlet weak var scrollView2: NSScrollView!
    @IBOutlet weak var scrollView3: NSScrollView!
    @IBOutlet weak var scrollView4: NSScrollView!
    @IBOutlet weak var imageView: NSImageView!
    
    var txtView : NSTextView {
        get {
            return scrollView.contentView.documentView as NSTextView
        }
    }
    
    var grepSbjecttxtTxtView : NSTextView {
        get {
            return grepSbjecttxtScrollView.contentView.documentView as NSTextView
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
        var datpath = mydownloader.readUserDefaults().datpath
        updateTxtField(datpath)
        mydownloader.initDataGetter()
    }
    
    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
        mydownloader.writeUserDefaultsToFile(debug: true, datpath: txtField.stringValue)
    }
    
    override func controlTextDidEndEditing(obj: NSNotification!) {
        println("controlTextDidEndEditing\nobj.object.stringValue: \(obj.object.stringValue)")
        println("txtField.stringValue: \(txtField.stringValue)")
        if (mydownloader != nil) {
            mydownloader.writeUserDefaultsToFile(debug: true, datpath: obj.object.stringValue)
        }
    }
    
    @IBAction func btnClicked(sender: AnyObject) {
        mydownloader.datpath = txtField.stringValue
        var datpath = mydownloader.datpath
        
        var subjectTxt = mydownloader.getSubjecttxt()
        
        //var subjects = mydownloader.grepSubjects(subjectTxt)
        var (subjects, subject) = mydownloader.grepSubjectAtDatname(datpath, subjectTxt: subjectTxt)
        updateSubjectView(subjects)
        updateGrepSubjectView(subject)
        
        var dat = mydownloader.getDat(datpath)
        updateDatTxtView(dat)
        
        var urls = mydownloader.grepUrls(dat)
        updateUrlTxtView(urls)
        
        mydownloader.downloadContents()
    }
    
    func updateTxtField(aDatpath: String) {
        txtField.stringValue = aDatpath
    }
    
    func updateSubjectView(text: String) {
        txtView.insertText(text)
    }
    
    func updateGrepSubjectView(subjects: String) {
        grepSbjecttxtTxtView.insertText(subjects)
    }
    
    func updateDatTxtView(dat: String) {
        txtView2.insertText(dat)
    }
    
    func updateUrlTxtView(urls: String) {
        txtView3.insertText(urls)
    }
}

