//
//  SettingsTableViewCell.swift
//  VoiceTubeHomework
//
//  Created by ShanOvO on 2019/12/28.
//  Copyright © 2019 ShanOvO. All rights reserved.
//

import UIKit

protocol SettingsTableViewCellDelegate: class {
    func didTriggerSwitchAction(with tag: Int, isOn: Bool)
}

class SettingsTableViewCell: UITableViewCell {

    var settingSwitch: UISwitch!
    var settingTitleLabel: UILabel!
    weak var delegate: SettingsTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpLayoutProgrammatically()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setUpLayoutProgrammatically()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpLayoutProgrammatically()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

    private func setUpLayoutProgrammatically() {
        setUpSwitch()
        setUpSettingTitleLabel()
    }
    
    private func setUpSwitch() {
        settingSwitch = UISwitch()        
        settingSwitch.addTarget(self, action: #selector(switchAction(_:)), for: .valueChanged)
        addSubview(settingSwitch)
        settingSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        settingSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20).isActive = true
        settingSwitch.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        settingSwitch.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setUpSettingTitleLabel() {
        settingTitleLabel = UILabel()
        settingTitleLabel.textAlignment = .left
        addSubview(settingTitleLabel)
        settingTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        settingTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        settingTitleLabel.trailingAnchor.constraint(equalTo: settingSwitch.leadingAnchor, constant: 20).isActive = true
        settingTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    @objc
    func switchAction(_ sender: UISwitch) {
        let isOn = sender.isOn
        delegate?.didTriggerSwitchAction(with: tag, isOn: isOn)
    }
}
