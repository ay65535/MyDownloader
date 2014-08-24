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
    var images: [NSImage!]
    
    override init() {
        images = []
        session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        super.init()
    }
    
    func downloadImage(aUrl: String, anImageView: NSImageView!) {
        //let url = NSURL.URLWithString("https://devimages.apple.com.edgekey.net/assets/elements/icons/128x128/Xcode6.png")
        if aUrl.rangeOfString("http") == nil {
            return
        }
        
        let url = NSURL.URLWithString(aUrl)
        session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task = session.dataTaskWithURL(url, completionHandler: {
            (data, resp, err) in
            //println(NSString(data: data, encoding:NSUTF8StringEncoding))
            var image = NSImage(data: data)
            self.images.append(image)
            anImageView.image = image
        })
        
        let task2 = session.downloadTaskWithURL(url, completionHandler: {
            	(location, resp, error) in
            if location == nil {
                return
            }
            
            var manager = NSFileManager.defaultManager()
            var downloadsPath = NSSearchPathForDirectoriesInDomains(.DownloadsDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String
            var destURL = NSURL.fileURLWithPath(downloadsPath.stringByAppendingPathComponent(url.lastPathComponent))
            
            manager.moveItemAtURL(location, toURL: destURL!, error: nil)
        })
        
        task.resume()
        //task2.resume()
    }
}
