//
//  MyTest.swift
//  MyTest
//
//  Created by ay65535 on 2014/08/04.
//
//

import Cocoa

class MyTest: NSObject {
    
    let dlpath: NSString
    let datpath: NSString
    let test_txt: NSString
    let user_agent: String
    let headers: Dictionary<String, String>
    
    init() {
        dlpath = "/Users/Shared/MyTest"
        datpath = "/Users/Shared/MyTest"
        test_txt = "/Users/Shared/MyTest/test.txt"
        user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.77.4 (KHTML, like Gecko) Version/7.0.5 Safari/537.77.4"
        headers = ["User-Agent": user_agent]
        
    }
    
    func get() -> String {
        return NSString.stringWithContentsOfFile(test_txt, encoding: NSShiftJISStringEncoding, error: nil)
        
        // 1行ずつ文字列を列挙
        // var strings: [String] = []
        // str.enumerateLinesUsingBlock({line, stop in
        //     NSLog("%@", line)
        //     strings += line
        // })
    }
}