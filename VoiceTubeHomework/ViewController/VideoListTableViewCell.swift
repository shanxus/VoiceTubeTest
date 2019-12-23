//
//  VideoListTableViewCell.swift
//  VoiceTubeHomework
//
//  Created by ShanOvO on 2019/12/17.
//  Copyright © 2019 ShanOvO. All rights reserved.
//

import UIKit

class VideoListTableViewCell: UITableViewCell {

    var videoImageContainerView: UIView!
    var videoTitleLabel: UILabel!
    var videoImageView: UIImageView!
    var videoImage: UIImage? {
        didSet {
            imageFadeInAction()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViewsProgrammatically()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setUpViewsProgrammatically()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    private func setUpViewsProgrammatically() {
        setUpVideoImage()
        setUpTitleLabel()
        setUpVideoImageView()
    }
    
    private func setUpVideoImage() {
        videoImageContainerView = UIView()
        videoImageContainerView.backgroundColor = .black
        videoImageContainerView.clipsToBounds = true
        videoImageContainerView.layer.cornerRadius = 5
        addSubview(videoImageContainerView)
        videoImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        videoImageContainerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        videoImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        videoImageContainerView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        videoImageContainerView.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func setUpTitleLabel() {
        
        videoTitleLabel = UILabel()
        videoTitleLabel.numberOfLines = 0
        videoTitleLabel.textColor = .black
        addSubview(videoTitleLabel)
        videoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        videoTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        videoTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        videoTitleLabel.leadingAnchor.constraint(equalTo: videoImageContainerView.trailingAnchor, constant: 20).isActive = true
    }
    
    private func setUpVideoImageView() {
        videoImageView = UIImageView()
        videoImageView.alpha = 0
        videoImageView.contentMode = .scaleAspectFit
        addSubview(videoImageView)
        videoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        videoImageView.leadingAnchor.constraint(equalTo: videoImageContainerView.leadingAnchor).isActive = true
        videoImageView.trailingAnchor.constraint(equalTo: videoImageContainerView.trailingAnchor).isActive = true
        videoImageView.topAnchor.constraint(equalTo: videoImageContainerView.topAnchor).isActive = true
        videoImageView.bottomAnchor.constraint(equalTo: videoImageContainerView.bottomAnchor).isActive = true
    }
    
    func imageFadeInAction() {
        videoImageView.image = videoImage
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.videoImageView.alpha = 1
        }
    }
}
