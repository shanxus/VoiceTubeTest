//
//  ImageRequester.swift
//  VoiceTubeHomework
//
//  Created by ShanOvO on 2019/12/23.
//  Copyright © 2019 ShanOvO. All rights reserved.
//

import Foundation
import UIKit

protocol ImageRequesterDelegate: class {
    func didRetrieve(image: UIImage)
}

class ImageRequester: NSObject {
    
    private var images: [String : UIImage] = [:]
    private var downloadQueue: [String] = []
    
    weak var delegate: ImageRequesterDelegate?
    
    func requestImage(by urlString: String) -> UIImage? {
        
        if let image = images[urlString] {
            return image
        } else {
            
            guard !downloadQueue.contains(urlString) else { return nil }
            downloadQueue.append(urlString)
            downloadImage(with: urlString)
            
            return nil
        }
    }
    
    private func downloadImage(with urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            guard error == nil, let data = data, let image = UIImage(data: data) else { return }
            
            self?.images[urlString] = image
            self?.downloadQueue.removeAll(where: { $0 == urlString })
            
            DispatchQueue.main.async {
                self?.delegate?.didRetrieve(image: image)
            }
        }
        
        dataTask.resume()
    }
}
