//
//  MyDownloader.swift
//  MyDownloader
//
//  Created by ay65535 on 2014/08/04.
//
//

import Cocoa

class MyDownloader: NSObject {
    
    let dlpath: String
    let datpath: String
    let test_txt: String
    let user_agent: String
    let headers: Dictionary<String, String>
    //var error: NSError!
    
    init() {
        println("MyDownloader")
        dlpath = "~/test".stringByExpandingTildeInPath
        datpath = "~/test".stringByExpandingTildeInPath
        test_txt = "~/test/test.txt".stringByExpandingTildeInPath
        user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.77.4 (KHTML, like Gecko) Version/7.0.5 Safari/537.77.4"
        headers = ["User-Agent": user_agent]
    }
    
    init(datpath: String) {
        println("MyDownloader")
        dlpath = "~/test".stringByExpandingTildeInPath
        self.datpath = datpath.stringByExpandingTildeInPath
        test_txt = "~/test/test.txt".stringByExpandingTildeInPath
        user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.77.4 (KHTML, like Gecko) Version/7.0.5 Safari/537.77.4"
        headers = ["User-Agent": user_agent]
        
    }
    
    func getSubjecttxt() -> String {
        if let subject_txt = NSString.stringWithContentsOfFile(test_txt, encoding: NSShiftJISStringEncoding, error: nil) {
            return subject_txt
        } else {
            return ""
        }
        
        // 1行ずつ文字列を列挙
        // var strings: [String] = []
        // str.enumerateLinesUsingBlock({line, stop in
        //     NSLog("%@", line)
        //     strings += line
        // })
    }
    
    func grepSubjects(subjectTxt: String) -> String {
        var subjects: String = ""
        let regex: NSRegularExpression = NSRegularExpression.regularExpressionWithPattern(
            "<>.* \\([0-9]",
            options: NSRegularExpressionOptions.CaseInsensitive,
            error: nil)
        
        var matches: [NSTextCheckingResult] = regex.matchesInString(
            subjectTxt,
            options: NSMatchingOptions(0),
            range: NSMakeRange(0, subjectTxt.utf16count)) as [NSTextCheckingResult]
        
        for match in matches {
            subjects += "\(subjectTxt[match.range.location + 2...match.range.location + match.range.length - 4])\n"
        }
        
        return subjects
    }
    
    func getDat(datpath: String) -> String {
        let datFullpath = datpath.stringByExpandingTildeInPath
        if let dat = NSString.stringWithContentsOfFile(datFullpath, encoding: NSShiftJISStringEncoding, error: nil) {
            return dat
        } else {
            return ""
        }
    }
    
    func grepUrls(dat: String) -> String {
        var urls: String = ""
        let regex: NSRegularExpression = NSRegularExpression.regularExpressionWithPattern(
            "ttps?://[-_.!~*a-zA-Z0-9;/?:@&=+$,%#]+\\.[jpgb][pnim][egfp]g?",
            options: NSRegularExpressionOptions.CaseInsensitive,
            error: nil)
        
        var matches: [NSTextCheckingResult] = regex.matchesInString(
            dat,
            options: NSMatchingOptions(0),
            range: NSMakeRange(0, dat.utf16count)) as [NSTextCheckingResult]
        
        for match in matches {
            urls += "h\(dat[match.range])\n"
        }
        
        return urls
    }
}
