//
//  MyDownloader.swift
//  MyDownloader
//
//  Created by ay65535 on 2014/08/04.
//
//

import Cocoa

class MyDownloader: NSObject {
    
    var dlpath: String
    var datpath: String
    let test_txt: String
    let user_agent: String
    let headers: Dictionary<String, String>
    //var error: NSError!
    
    override init() {
        println("MyDownloader")
        dlpath = "~/test".stringByExpandingTildeInPath
        datpath = "~/test".stringByExpandingTildeInPath
        test_txt = "~/test/test.txt".stringByExpandingTildeInPath
        user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.77.4 (KHTML, like Gecko) Version/7.0.5 Safari/537.77.4"
        headers = ["User-Agent": user_agent]
        super.init()
    }
    
    init(aDatpath: String) {
        println("MyDownloader")
        dlpath = "~/test".stringByExpandingTildeInPath
        datpath = aDatpath.stringByExpandingTildeInPath
        test_txt = "~/test/test.txt".stringByExpandingTildeInPath
        user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.77.4 (KHTML, like Gecko) Version/7.0.5 Safari/537.77.4"
        headers = ["User-Agent": user_agent]
        super.init()
        
    }
    
    func getSubjecttxt() -> String {
        if let subject_txt = NSString.stringWithContentsOfFile(test_txt, encoding: NSShiftJISStringEncoding, error: nil) {
            return subject_txt
        } else {
            return ""
        }
    }
    
    func grepSubjects(subjectTxt: String) -> String {
        
        var subjects: String = ""
        var subString: String = ""
        
        subjectTxt.enumerateLines { (line, stop) -> () in
            if let range = line.rangeOfString("<>.* \\([0-9]", options: .RegularExpressionSearch) {
                subString = line.substringWithRange(range)
                
                // <> TITLE (99)
                // |||      ||||
                // 3文字進めて4文字末尾切った
                subString = subString.substringWithRange(Range<String.Index>(start: subString.startIndex.successor().successor(), end: subString.endIndex.predecessor().predecessor().predecessor()))
                
                subjects += "\(subString)\n"
            }
        }
        
        return subjects
    }
    
    func grepSubjectAtDatname(datpath: String, subjectTxt: String) -> String {
        if datpath.isEmpty {
            return ""
        }
        let datname: String = datpath.lastPathComponent
        var subject: String = ""
        
        // 1行ずつ文字列を列挙
        subjectTxt.enumerateLines { (line, stop) -> () in
            if line.hasPrefix(datname) {
                if let range = line.rangeOfString("<>.* \\([0-9]", options: .RegularExpressionSearch) {
                    let subString = line.substringWithRange(range)
                    subject = subString.substringWithRange(Range<String.Index>(start: subString.startIndex.successor().successor(), end: subString.endIndex.predecessor().predecessor().predecessor()))
                } else {
                    subject = ""
                }
            }
        }
        
        return subject
    }
    
    func grepSubjectAtDatname(datpath: String, subjectTxt: String) -> (subjects: String, subject: String) {
        var subjects: String = ""
        var subject: String = ""
        
        if datpath.isEmpty {
            // 1行ずつ文字列を列挙
            subjectTxt.enumerateLines { (line, stop) -> () in
                if let range = line.rangeOfString("<>.* \\([0-9]", options: .RegularExpressionSearch) {
                    var subString = line.substringWithRange(range)
                    subString = subString.substringWithRange(Range<String.Index>(start: subString.startIndex.successor().successor(), end: subString.endIndex.predecessor().predecessor().predecessor()))
                    subjects += subString + "\n"
                }
            }
        } else {
            let datname: String = datpath.lastPathComponent
            // 1行ずつ文字列を列挙
            subjectTxt.enumerateLines { (line, stop) -> () in
                if let range = line.rangeOfString("<>.* \\([0-9]", options: .RegularExpressionSearch) {
                    var subString = line.substringWithRange(range)
                    subString = subString.substringWithRange(Range<String.Index>(start: subString.startIndex.successor().successor(), end: subString.endIndex.predecessor().predecessor().predecessor()))
                    subjects += subString + "\n"
                    if line.hasPrefix(datname) {
                        subject = subString
                    }
                }
            }
        }
        
        return (subjects, subject)
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
        var subString: String = ""
        
        dat.enumerateLines { (line, stop) -> () in
            var index: String.Index = "".startIndex
            // 1行につき50個まで検索可能
            for i in 1...50 {
                if let range = line.rangeOfString("ttps?://[-_.!~*a-zA-Z0-9;/?:@&=+$,%#]+\\.[jpgb][pnim][egfp]g?",
                    options: .RegularExpressionSearch,
                    range: Range<String.Index>(start:index, end: line.endIndex)) {
                        urls += "h\(line.substringWithRange(range))\n"
                        index = range.endIndex
                } else {
                    break
                }
            }
        }
        return urls
    }
    
    func getDatAndGrepURLs(datpath: String) -> (dat: String, URLs: String) {
        let datFullpath = datpath.stringByExpandingTildeInPath
        if let dat = NSString.stringWithContentsOfFile(datFullpath, encoding: NSShiftJISStringEncoding, error: nil) {
            return (dat, grepUrls(dat))
        } else {
            return ("", "")
        }
    }
}
