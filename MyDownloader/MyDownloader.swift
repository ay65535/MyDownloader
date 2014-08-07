//
//  MyDownloader.swift
//  MyDownloader
//
//  Created by ay65535 on 2014/08/04.
//
//

import Cocoa

class MyDownloader: NSObject {
    
    let dlpath: NSString
    let datpath: String
    let test_txt: NSString
    let user_agent: String
    let headers: Dictionary<String, String>
    
    init() {
        println("MyDownloader")
        dlpath = "/Users/Shared/test"
        datpath = "/Users/Shared/test"
        test_txt = "/Users/Shared/test/test.txt"
        user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.77.4 (KHTML, like Gecko) Version/7.0.5 Safari/537.77.4"
        headers = ["User-Agent": user_agent]
    }
    
    init(datpath: String) {
        println("MyDownloader")
        dlpath = "/Users/Shared/test"
        self.datpath = datpath
        test_txt = "/Users/Shared/test/test.txt"
        user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.77.4 (KHTML, like Gecko) Version/7.0.5 Safari/537.77.4"
        headers = ["User-Agent": user_agent]
        
    }
    
    func getSubjecttxt() -> String {
        return NSString.stringWithContentsOfFile(test_txt, encoding: NSShiftJISStringEncoding, error: nil)
        
        // 1行ずつ文字列を列挙
        // var strings: [String] = []
        // str.enumerateLinesUsingBlock({line, stop in
        //     NSLog("%@", line)
        //     strings += line
        // })
    }
    
    func getDat(datpath: String) -> String {
        if let dat = NSString.stringWithContentsOfFile(datpath, encoding: NSShiftJISStringEncoding, error: nil) {
            return dat
        } else {
            return "Error"
        }
    }
}
