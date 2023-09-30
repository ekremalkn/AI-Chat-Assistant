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
    func viewDidAppear()
    func didSelectItemAt(indexPath: IndexPath)
    
    func updateCollectionViewAccordingToSubscribe()
}

final class SettingsViewModel {
    
    //MARK: - References
    weak var view: SettingsViewInterface?
    
    //MARK: - Variables
    var settingsSections: [SettingsSection] = [
        .init(sectionCategory: .support, sectionItems: [
            .init(itemCategory: .contactUs, itemImage: "chat_contact_us", itemTitle: "Contact Us".localized()),
            .init(itemCategory: .restorePurchase, itemImage: "chat_restore_purchases", itemTitle: "Restore Purchases".localized()),
            .init(itemCategory: .requestAFeature, itemImage: "chat_request_a_feature", itemTitle: "Request a Feature".localized())
        ]),
        .init(sectionCategory: .about, sectionItems: [
            .init(itemCategory: .rateApp, itemImage: "chat_rate_app", itemTitle: "Rate App".localized()),
            .init(itemCategory: .shareWithFriends, itemImage: "chat_share_with_friends", itemTitle: "Share with Friends".localized()),
            .init(itemCategory: .termOfUse, itemImage: "chat_term_of_use", itemTitle: "Term of Use".localized()),
            .init(itemCategory: .privacyPolicy, itemImage: "chat_privacy_policy", itemTitle: "Privacy Policy".localized())
        ])
    ]
    
}

//MARK: - SettingsViewModelInterface
extension SettingsViewModel: SettingsViewModelInterface {
    func viewDidLoad() {
        view?.configureViewController()
    }
    
    func viewDidAppear() {
        updateCollectionViewAccordingToSubscribe()
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        
        let sectionCategory = settingsSections[indexPath.section].sectionCategory
        
        switch sectionCategory {
        case .subscribe:
            view?.openPaywall()
        case .support, .about:
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
                view?.restoringPurchase()
                RevenueCatManager.shared.restorePurchase { [weak self] result in
                    guard let self else { return }
                    
                    switch result {
                    case .restoredSuccessfully:
                        view?.restoredPurchase()
                    case .didNotRestore(let errorMsg):
                        view?.didOccurErrorWhileRestoringPurhcase(errorMsg)
                    }
                }
            }
        }
        
        
    }
    
    
    func updateCollectionViewAccordingToSubscribe() {
        if !RevenueCatManager.shared.isSubscribe {
            if !settingsSections.contains(where: { $0.sectionCategory == .subscribe }) {
                // add section
                
                
                view?.insertSection(at: 0)
            }
            
        } else {
            if let subscribeSectionIndexToDelete = settingsSections.firstIndex(where: { $0.sectionCategory == .subscribe }) {
                settingsSections.remove(at: subscribeSectionIndexToDelete)
                
                // collectionviewdan sectionu sil
                view?.deleteSection(at: 0)
            }
        }
    }
    
}
