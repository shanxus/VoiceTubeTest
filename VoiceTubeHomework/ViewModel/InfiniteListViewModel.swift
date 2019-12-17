//
//  InfiniteListViewModel.swift
//  VoiceTubeHomework
//
//  Created by ShanOvO on 2019/12/17.
//  Copyright © 2019 ShanOvO. All rights reserved.
//

import Foundation
import Alamofire

class InfiniteListViewModel: NSObject {
    
    private let url = "https://us-central1-lithe-window-713.cloudfunctions.net/appQuiz"
    
    var numberOfSection: Int {
        return 1
    }
    
    var numberOfRow: Int {
        return 10
    }
    
    func requestDataIfNeeded() {
        
    }
    
    private func requestData(completion: ((_ result: Result<Int, RequestError>) -> Void)?) {
        
        let parameters = ["key":"VoiceTube"]
        AF.request(url, method: .post, parameters: parameters).responseData { (response: AFDataResponse<Data>) in
            switch response.result {
            case .success(let data):
                
                guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] else {
                    completion?(.failure(.dataCastFail))
                    return
                }
                
                guard let status = dictionary["status"] as? String, status == "success" else {
                    completion?(.failure(.requestFail))
                    return
                }
                
                guard let videosArray = dictionary["videos"] as? [[String:Any]] else {
                    completion?(.failure(.dataCastFail))
                    return
                }
                
                let decoder = JSONDecoder()
                let videosData = videosArray.compactMap { $0.toData() }
                
                var videos: [Video] = []
                videosData.forEach { (data: Data) in
                    guard let video = try? decoder.decode(Video.self, from: data) else { return }
                    videos.append(video)
                }

                print("got data")
            case .failure(let error):
                completion?(.failure(.AFError(error: error)))
            }
        }
        
    }
}

extension InfiniteListViewModel {
    enum RequestError: Error {
        case requestFail
        case dataCastFail
        case AFError(error: AFError)
    }
}

extension Dictionary {
    func toData() -> Data? {
        return (try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted))
    }
}

