//
//  InfiniteListViewModel.swift
//  VoiceTubeHomework
//
//  Created by ShanOvO on 2019/12/17.
//  Copyright © 2019 ShanOvO. All rights reserved.
//

import Foundation
import Alamofire

protocol InfiniteListViewModelDelegate: class {
    func didUpdateData()
    func didAppendData()
    func didRetrieveVideoImage()
}

class InfiniteListViewModel: NSObject {
    
    private let url = "https://us-central1-lithe-window-713.cloudfunctions.net/appQuiz"
    private var videoDAO = VideoDAO()
    private var videos: [Video] = [] {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.didUpdateData()
            }
        }
    }
    
    weak var delegate: InfiniteListViewModelDelegate?
    private let customRowNumber = 21
    
    private var imageRequester = ImageRequester()
    
    var numberOfSection: Int {
        return 1
    }
    
    var numberOfRow: Int = 0
    
    override init() {
        super.init()
        
        numberOfRow = customRowNumber
        
        videoDAO.delegate = self
        videoDAO.observe()
        
        imageRequester.delegate = self
    }
    
    func requestDataIfNeeded() {
        if videoDAO.shouldRequestData() {
            // Request data.
            requestData(completion: nil)
        }
    }
    
    func getTitle(at row: Int) -> String {
        guard videos.count != 0 else { return "" }
        
        let remainder = row % videos.count
        return videos[remainder].title
    }
    
    func getImage(at row: Int) -> UIImage? {
        guard videos.count != 0 else { return nil }
        
        let remainder = row % videos.count
        let imgURLString = videos[remainder].img
        return imageRequester.requestImage(by: imgURLString)
    }
    
    func reachBottomAction() {
        numberOfRow += customRowNumber
        DispatchQueue.main.async {
            self.delegate?.didAppendData()
        }
    }
    
    private func requestData(completion: ((_ result: Result<Int, RequestError>) -> Void)?) {
        
        let parameters = ["key":"VoiceTube"]
        AF.request(url, method: .post, parameters: parameters).responseData { [weak self] (response: AFDataResponse<Data>) in
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
                self?.videoDAO.save(videos: videos)
                
            case .failure(let error):
                completion?(.failure(.AFError(error: error)))
            }
        }
    }
    
    deinit {
        videoDAO.clear()
        print("deinit of InfiniteListViewModel")
    }
}

// MARK: - Video DAO Delegate
extension InfiniteListViewModel: VideoDAODelegate {
    func didUpdate(videos: [Video]) {
        self.videos = videos
    }
}

// MARK: - Image Requester Delegate
extension InfiniteListViewModel: ImageRequesterDelegate {
    func didRetrieve(image: UIImage) {
        delegate?.didRetrieveVideoImage()
    }
}

// MARK: - Request Error
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

