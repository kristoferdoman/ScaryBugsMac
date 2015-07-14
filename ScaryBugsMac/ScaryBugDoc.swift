//
//  ScaryBugDoc.swift
//  ScaryBugsMac
//
//  Created by Kristofer Doman on 2015-07-09.
//  Copyright (c) 2015 Kristofer Doman. All rights reserved.
//

import Foundation
import AppKit

class ScaryBugDoc: NSObject {
    var data: ScaryBugData
    var thumbImage: NSImage?
    var fullImage: NSImage?
    
    override init() {
        self.data = ScaryBugData()
    }
    
    init(title: String, rating: Double, thumbImage: NSImage?, fullImage: NSImage?) {
        self.data = ScaryBugData(title: title, rating: rating)
        self.thumbImage = thumbImage
        self.fullImage = fullImage
    }
    
    required convenience init(coder decoder: NSCoder) {
        self.init()
        self.data = decoder.decodeObjectForKey("data") as! ScaryBugData
        self.thumbImage = decoder.decodeObjectForKey("thumbImage") as! NSImage?
        self.fullImage = decoder.decodeObjectForKey("fullImage") as! NSImage?
    }
}

// MARK: - NSCoding

extension ScaryBugDoc: NSCoding {
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.data, forKey: "data")
        coder.encodeObject(self.thumbImage, forKey: "thumbImage")
        coder.encodeObject(self.fullImage, forKey: "fullImage")
    }
}
