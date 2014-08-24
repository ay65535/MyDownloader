//
//  MDDataGetter.swift
//  MyDownloader
//
//  Created by ay65535 on 2014/08/10.
//
//

import Cocoa

class MDDataGetter: NSURLSession {
    
    var session: NSURLSession!
    
    override init() {
        super.init()
        session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    }
    
    func downloadContents() {
        let url  = NSURL.URLWithString("https://devimages.apple.com.edgekey.net/assets/elements/icons/128x128/Xcode6.png")
        session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task    = session.dataTaskWithURL(url, completionHandler: {
            (data, resp, err) in
            //println(NSString(data: data, encoding:NSUTF8StringEncoding))
        })
        
        task.resume()
    }
}
