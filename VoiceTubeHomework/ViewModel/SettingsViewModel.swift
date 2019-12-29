//
//  SettingsViewModel.swift
//  VoiceTubeHomework
//
//  Created by ShanOvO on 2019/12/28.
//  Copyright © 2019 ShanOvO. All rights reserved.
//

import Foundation

class SettingsViewModel: NSObject {
    
    func getHeaderTitle(at section: Int) -> String? {
        return section == 0 ? "Basic Settings" : nil
    }
    
    func getSettingTitle(at row: Int) -> String {
        return Settings.allCases[row].getTitle()
    }
    
    func getSwitchState(at row: Int) -> Bool {
        
        let sortedCases = Settings.allCases.sorted()
        let userDefaultIdentifier = sortedCases[row].getUserDefaultIdentifier()
        return (UserDefaults.standard.value(forKey: userDefaultIdentifier) as? Bool) ?? false
    }
    
    func handleSwitchAction(with tag: Int, isOn: Bool) {        
        
        let sortedCases = Settings.allCases.sorted()
        let userDefaultIdentifier = sortedCases[tag].getUserDefaultIdentifier()
        UserDefaults.standard.set(isOn, forKey: userDefaultIdentifier)
    }
}

enum Settings: Int, CaseIterable {
    case autoPlay = 0
    case subtitleSync
    case pausedWhenSearchingWord
    case notificationForRecommendedVideo
    case notificationForLearning
    
    func getTitle() -> String {
        switch self {
        case .autoPlay:
            return "自動播放"
        case .subtitleSync:
            return "字幕同步"
        case .pausedWhenSearchingWord:
            return "查詢單字時暫停播放"
        case .notificationForRecommendedVideo:
            return "推薦影片提醒"
        case .notificationForLearning:
            return "學習通知"
        }
    }
    
    func getUserDefaultIdentifier() -> String {
        switch self {
        case .autoPlay:
            return "com.voiceTube.homework.autoPlay"
        case .subtitleSync:
            return "com.voiceTube.homework.subtitleSync"
        case .pausedWhenSearchingWord:
            return "com.voiceTube.homework.pausedWhenSearchingWord"
        case .notificationForRecommendedVideo:
            return "com.voiceTube.homework.notificationForRecommendedVideo"
        case .notificationForLearning:
            return "com.voiceTube.homework.notificationForLearning"
        }
    }
}

extension Settings: Comparable {
    static func < (lhs: Settings, rhs: Settings) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}
