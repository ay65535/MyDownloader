//
//  Utility.swift
//  MyDownloader
//
//  Created by ay65535 on 2014/08/08.
//
//

import Foundation

/// http://stackoverflow.com/questions/24044851/how-do-you-use-string-substringwithrange-or-how-do-ranges-work-in-swift
extension String {
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = advance(self.startIndex, r.startIndex)
            let endIndex = advance(startIndex, r.endIndex - r.startIndex)
            
            return self[Range(start: startIndex, end: endIndex)]
        }
    }
}

/// https://www.facebook.com/SwiftUG/posts/251938944998168
//extension String{
//    subscript(subRange: Range<Int>) -> String! {
//        get {
//            var s = self.bridgeToObjectiveC();
//            var r = NSRange(location:subRange.startIndex,length:subRange.endIndex)
//            return s.substringWithRange(r)
//        }
//    }
//}