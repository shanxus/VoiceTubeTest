//
//  VideoDAO.swift
//  VoiceTubeHomework
//
//  Created by ShanOvO on 2019/12/23.
//  Copyright © 2019 ShanOvO. All rights reserved.
//

import Foundation
import RealmSwift

protocol VideoDAODelegate: class {
    func didUpdate(videos: [Video])
}

class VideoDAO: NSObject {
    
    weak var delegate: VideoDAODelegate?
    
    private var observationTokens: [NotificationToken] = []
    
    func observe() {
        
        let realm = try! Realm()
        let results = realm.objects(RMVideo.self)
        let token = results.observe { [weak self] (changes: RealmCollectionChange<Results<RMVideo>>) in
            switch changes {
            case .initial(let results):
                let videos = results.map { $0.generalize() }
                self?.delegate?.didUpdate(videos: Array<Video>(videos))
                
            case .update(let results, _, _, _):
                let videos = results.map { $0.generalize() }
                self?.delegate?.didUpdate(videos: Array<Video>(videos))
                
            case .error(let error):
                print("error: \(error)")
            }
        }
        
        observationTokens.append(token)
    }
    
    func shouldRequestData() -> Bool {
        let realm = try! Realm()
        return realm.objects(RMVideo.self).first == nil
    }
    
    func transform(video: Video) -> RMVideo {
        let rmVideo = RMVideo()
        rmVideo.title = video.title
        rmVideo.img = video.img
        return rmVideo
    }
    
    func save(videos: [Video]) {
        
        var rmVidoes: [RMVideo] = []
        videos.forEach {
            rmVidoes.append(transform(video: $0))
        }
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(rmVidoes, update: .all)
        }
    }
    
    func clear() {
        observationTokens.forEach { (token: NotificationToken) in
            token.invalidate()
        }
    }
}
