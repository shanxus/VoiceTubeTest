//
//  CountdownManageView.swift
//  VoiceTubeHomework
//
//  Created by ShanOvO on 2019/12/28.
//  Copyright © 2019 ShanOvO. All rights reserved.
//

import UIKit

protocol CountdownManageViewDelegate: class {
    func didTriggerSettingTimeAction()
}

class CountdownManageView: UIView {

    // MARK: - View Properties.
    var pauseButton: UIButton!
    var startButton: UIButton!
    var timeLabel: UILabel!
    var settingButton: UIButton!
    
    // MARK: - Properties.
    weak var delegate: CountdownManageViewDelegate?
    
    private var countdownTimer: Timer?
    private var countdownTime: Int? {
        didSet {
            if let time = countdownTime {
                timeLabel.text = "\(time)"
            }
            
            if countdownTime == 0 {
                handleCountdownEnded()
            }
        }
    }
    
    // MARK: - Initial Functions.
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpObserver()
        setUpLayoutProgrammatically()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setUpObserver()
        setUpLayoutProgrammatically()
    }

    // MARK: - Set Up Views.
    private func setUpLayoutProgrammatically() {
        setUpPauseButton()
        setUpStartButton()
        setUpTimeLabel()
        setUpSettingButton()
    }

    private func setUpObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(willResignActiveAction), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActiveAction), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    private func setUpPauseButton() {
        pauseButton = UIButton()
        pauseButton.addTarget(self, action: #selector(pauseAction), for: .touchUpInside)
        pauseButton.setTitle("Pause", for: .normal)
        addSubview(pauseButton)
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
                
        pauseButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        pauseButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        pauseButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
    }
    
    private func setUpStartButton() {
        startButton = UIButton()
        startButton.addTarget(self, action: #selector(startAction), for: .touchUpInside)
        startButton.setTitle("Start", for: .normal)
        addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        startButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        startButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
    }
    
    private func setUpTimeLabel() {
        timeLabel = UILabel()
        timeLabel.text = "--"
        timeLabel.textAlignment = .center
        addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setUpSettingButton() {
        settingButton = UIButton()
        settingButton.addTarget(self, action: #selector(settingAction), for: .touchUpInside)
        settingButton.contentHorizontalAlignment = .left
        settingButton.setTitle("Tap to set time for countdown", for: .normal)
        addSubview(settingButton)
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        
        settingButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        settingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        settingButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        settingButton.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
    }
    
    // MARK: IBActions.
    @objc
    private func pauseAction() {
        
        guard countdownTimer != nil else { return }
        countdownTimer?.invalidate()
        countdownTimer = nil
    }
    
    @objc
    private func startAction() {
        
        guard countdownTimer == nil, countdownTime != nil else { return }
        startTimer()
    }
    
    @objc
    private func settingAction() {
        
        handleCountdownEnded()
        delegate?.didTriggerSettingTimeAction()
       
    }
    
    // MARK: Timer Actions.
    private func startTimer() {
        countdownTimer = Timer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        let runLoop = RunLoop.main
        runLoop.add(countdownTimer!, forMode: .common)
    }
    
    @objc
    private func timerAction() {
        guard let time = countdownTime else { return }
        countdownTime = time - 1
    }
    
    func setCountdownTime(as newValue: Int) {
        countdownTime = newValue
    }
    
    private func handleCountdownEnded() {
        countdownTimer?.invalidate()
        countdownTimer = nil
        
        countdownTime = nil
        
        timeLabel.text = "--"
    }
    
    // MARK: System Notifications.
    @objc
    private func willResignActiveAction() {
        countdownTimer?.invalidate()
    }
    
    @objc
    private func didBecomeActiveAction() {
        guard countdownTime != nil && countdownTimer != nil else { return }
        startTimer()
    }
}
