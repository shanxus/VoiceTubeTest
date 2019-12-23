//
//  Video.swift
//  VoiceTubeHomework
//
//  Created by ShanOvO on 2019/12/17.
//  Copyright © 2019 ShanOvO. All rights reserved.
//

import Foundation

class Video: Codable {
    var title: String
    var img: String
    
    init(title: String, img: String) {
        self.title = title
        self.img = img
    }
}
