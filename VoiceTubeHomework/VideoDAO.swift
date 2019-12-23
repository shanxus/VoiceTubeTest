//
//  VideoDAO.swift
//  VoiceTubeHomework
//
//  Created by ShanOvO on 2019/12/23.
//  Copyright © 2019 ShanOvO. All rights reserved.
//

import Foundation
import RealmSwift

class VideoDAO: NSObject {
    
    var observationTokens: [NotificationToken] = []
    
    
    func observe() {
        
        let realm = try! Realm()
        let results = realm.objects(RMVideo.self)
        let token = results.observe { (changes: RealmCollectionChange<Results<RMVideo>>) in
            switch changes {
            case .initial(let results):
                print("123")
            case .update(let results, let deletion, let insertion, let modification):
                print("22")
            case .error(let error):
                print("33")
            }
        }
        
        observationTokens.append(token)
    }
    
    
}
