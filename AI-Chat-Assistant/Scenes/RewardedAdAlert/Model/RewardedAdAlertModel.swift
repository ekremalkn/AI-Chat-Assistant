//
//  RewardedAdAlertModel.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.10.2023.
//

import Foundation

enum RewardedAdAlertButtonType: CaseIterable {
    case showRewardedAd
    case openPaywall
}

extension RewardedAdAlertButtonType {
    var buttonTitle: String {
        switch self {
        case .showRewardedAd:
            return "Watch an Ad".localized()
        case .openPaywall:
            return "Get Chatvantage Pro".localized()
        }
    }
    
    var buttonImage: String {
        switch self {
        case .showRewardedAd:
            return "chat_watch_ad"
        case .openPaywall:
            return "chat_get_premium"
        }
    }
}
