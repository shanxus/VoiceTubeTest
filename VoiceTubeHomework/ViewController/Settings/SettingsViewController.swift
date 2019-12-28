//
//  SettingsViewController.swift
//  VoiceTubeHomework
//
//  Created by ShanOvO on 2019/12/28.
//  Copyright © 2019 ShanOvO. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    private var settingsTableView: UITableView!
    
    private let cellIdentifier = "settingsTableViewCell"
    
    private var viewModel: SettingsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        viewModel = SettingsViewModel()
        
        setUpSettingsTableView()
    }
    
    private func setUpSettingsTableView() {
        settingsTableView = UITableView()
        settingsTableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        settingsTableView.tableFooterView = UIView()
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        view.addSubview(settingsTableView)
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        settingsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        settingsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        settingsTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        settingsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    

}

// MARK: - UITableView Data Source
extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SettingsTableViewCell
        cell.delegate = self
        
        cell.settingTitleLabel.text = viewModel.getSettingTitle(at: indexPath.row)
        cell.tag = indexPath.row
        
        cell.settingSwitch.setOn(viewModel.getSwitchState(at: indexPath.row), animated: false)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.getHeaderTitle(at: section)
    }
}

// MARK: - UITableView Delegate
extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Settings TableViewCell Delegate
extension SettingsViewController: SettingsTableViewCellDelegate {
    func didTriggerSwitchAction(with tag: Int, isOn: Bool) {
        viewModel.handleSwitchAction(with: tag, isOn: isOn)
    }
}
