//
//  SettingsViewModel.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 22.09.2023.
//

import Foundation

protocol SettingsViewModelInterface {
    var view: SettingsViewInterface? { get set }
    
    func viewDidLoad()
    func didSelectItemAt(indexPath: IndexPath)
}

final class SettingsViewModel {
    
    //MARK: - References
    weak var view: SettingsViewInterface?
    
    //MARK: - Variables
    var settingsSections: [SettingsSection] = [
        .init(sectionCategory: .support, sectionItems: [
            .init(itemCategory: .contactUs, itemImage: "chat_contact_us", itemTitle: "Contact Us"),
            .init(itemCategory: .restorePurchase, itemImage: "chat_restore_purchases", itemTitle: "Restore Purchases"),
            .init(itemCategory: .requestAFeature, itemImage: "chat_request_a_feature", itemTitle: "Request a Feature")
        ]),
        .init(sectionCategory: .about, sectionItems: [
            .init(itemCategory: .rateApp, itemImage: "chat_rate_app", itemTitle: "Rate App"),
            .init(itemCategory: .shareWithFriends, itemImage: "chat_share_with_friends", itemTitle: "Share with Friends"),
            .init(itemCategory: .termOfUse, itemImage: "chat_term_of_use", itemTitle: "Term of Use"),
            .init(itemCategory: .privacyPolicy, itemImage: "chat_privacy_policy", itemTitle: "Privacy Policy")
        ])
    ]

}

//MARK: - SettingsViewModelInterface
extension SettingsViewModel: SettingsViewModelInterface {
    func didSelectItemAt(indexPath: IndexPath) {
        let selectedSettingItemCategory = settingsSections[indexPath.section].sectionItems[indexPath.item].itemCategory
        
        switch selectedSettingItemCategory {
        case .rateApp:
            view?.openAppStoreToWriteReview()
        case .shareWithFriends:
            view?.openShareSheetVCToShareApp()
        case .privacyPolicy:
            view?.openSafariToShowPrivacyPolicy()
        case .termOfUse:
            view?.openSafariToShowTermOfUse()
        case .contactUs:
            view?.openMailToSendUS()
        case .requestAFeature:
            view?.openAppStoreToWriteReview()
        case .restorePurchase:
            break
        }
    }
    
    func viewDidLoad() {
        view?.configureViewController()
    }
}
