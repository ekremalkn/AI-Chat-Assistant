//
//  SettingsModel.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 23.09.2023.
//

import Foundation

struct SettingsSection {
    var sectionCategory: SettingsSectionCategory
    var sectionItems: [SettingsSectionItem]
}

enum SettingsSectionCategory {
    case subscribe
    case support
    case about
    
    var sectionTitle: String {
        switch self {
        case .support:
            return "SUPPORT"
        case .about:
            return "ABOUT"
        case .subscribe:
            return ""
        }
    }
}

struct SettingsSectionItem {
    var itemCategory: SettingsSectionItemCategory
    var itemImage: String
    var itemTitle: String
}

enum SettingsSectionItemCategory {
    case rateApp
    case shareWithFriends
    case privacyPolicy
    case termOfUse
    case contactUs
    case requestAFeature
    case restorePurchase
    
}
