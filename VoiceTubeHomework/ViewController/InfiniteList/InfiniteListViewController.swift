//
//  InfiniteListViewController.swift
//  VoiceTubeHomework
//
//  Created by ShanOvO on 2019/12/17.
//  Copyright © 2019 ShanOvO. All rights reserved.
//

import UIKit

class InfiniteListViewController: UIViewController {

    private var videoListTableView: UITableView!
    private let cellIdentifier = "videoListTableViewCellIdentifier"
    
    private var viewModel: InfiniteListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        setUpViewModel()
        setUpTableView()
        
        viewModel.requestDataIfNeeded()
    }
    
    private func setUpViewModel() {
        viewModel = InfiniteListViewModel()
        viewModel.delegate = self
    }
    
    private func setUpTableView() {
        videoListTableView = UITableView()
        videoListTableView.register(VideoListTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        videoListTableView.delegate = self
        videoListTableView.dataSource = self
        
        view.addSubview(videoListTableView)
        videoListTableView.translatesAutoresizingMaskIntoConstraints = false
        videoListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        videoListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        videoListTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        videoListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// MARK: UITableView Data Source
extension InfiniteListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! VideoListTableViewCell
        cell.videoTitleLabel.text = viewModel.getTitle(at: indexPath.row)
        cell.videoImage = viewModel.getImage(at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.numberOfRow - 10 {
            viewModel.reachBottomAction()
        }
    }
}

// MARK: - UITableView Delegate
extension InfiniteListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Infinite List View Model Delegate
extension InfiniteListViewController: InfiniteListViewModelDelegate {
    func didUpdateData() {
        videoListTableView.reloadData()
    }
    
    func didAppendData() {
        videoListTableView.reloadData()
    }
    
    func didRetrieveVideoImage() {
        videoListTableView.beginUpdates()
        videoListTableView.reloadRows(at: videoListTableView.indexPathsForVisibleRows!, with: .fade)
        videoListTableView.endUpdates()
    }
}
