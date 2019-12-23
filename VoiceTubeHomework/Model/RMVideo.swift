//
//  RMVideo.swift
//  VoiceTubeHomework
//
//  Created by ShanOvO on 2019/12/23.
//  Copyright © 2019 ShanOvO. All rights reserved.
//

import Foundation
import RealmSwift

class RMVideo: Object {
    
    override class func primaryKey() -> String? {
        return "title"
    }
    
    @objc dynamic var title = ""
    @objc dynamic var img = ""
    
    func generalize() -> Video {
        return Video(title: title, img: img)
    }
}
