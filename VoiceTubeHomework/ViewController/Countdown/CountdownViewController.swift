//
//  CountdownViewController.swift
//  VoiceTubeHomework
//
//  Created by ShanOvO on 2019/12/28.
//  Copyright © 2019 ShanOvO. All rights reserved.
//

import UIKit

class CountdownViewController: UIViewController {

    private var countdownView: CountdownManageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setUpCountdownView()
    }
    
    private func setUpCountdownView() {
        countdownView = CountdownManageView()
        countdownView.delegate = self
        countdownView.backgroundColor = .red
        countdownView.clipsToBounds = true
        countdownView.layer.cornerRadius = 10
        view.addSubview(countdownView)
        countdownView.translatesAutoresizingMaskIntoConstraints = false
        
        countdownView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        countdownView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        countdownView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        countdownView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
    }
}

// MARK: - Countdown Manage View Delegate
extension CountdownViewController: CountdownManageViewDelegate {
    func didTriggerSettingTimeAction() {
        let alert = UIAlertController(title: "Set time for countdown", message: nil, preferredStyle: .actionSheet)
        
        // Default option for 60 seconds
        let optionOne = UIAlertAction(title: "60 seconds", style: .default) { (_) in
            self.countdownView.setCountdownTime(as: 60)
        }
        
        // Custom option.
        let customOption = UIAlertAction(title: "Custom", style: .default) { [weak self] (_) in
            
            let timeAlert = UIAlertController(title: nil, message: "Set countdown by entering seconds", preferredStyle: .alert)
            timeAlert.addTextField { (textField: UITextField) in
                textField.keyboardType = .numberPad
            }
            
            let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] (_) in
                if let textField = timeAlert.textFields?.first, let value = textField.text, let valueInt = Int(value) {
                    self?.countdownView.setCountdownTime(as: valueInt)
                }
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            timeAlert.addAction(okAction)
            timeAlert.addAction(cancel)
            
            self?.present(timeAlert, animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
               
        alert.addAction(optionOne)
        alert.addAction(customOption)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}
