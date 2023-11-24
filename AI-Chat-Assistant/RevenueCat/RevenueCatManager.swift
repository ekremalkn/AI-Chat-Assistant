//
//  RevenueCatManager.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 24.09.2023.
//

import Foundation
import RevenueCat

enum RevenueCatPurchaseResult {
    case purchasedSuccessfully
    case didNotPurchase
    case userCancelled
}

enum RevenueCatSubscriptionStatus {
    case subscriber
    case notSubscriber
}

enum RevenueCatRestorePurchaseResult {
    case restoredSuccessfully
    case didNotRestore(String?)
}


enum OfferingType {
    case defaultOffering
    case giftOffering
}

final class RevenueCatManager {
    static let shared = RevenueCatManager()
    
    //MARK: - Variables
    var isSubscribe: Bool = false

    //MARK: - Get Offerings
    func getOfferings(for offeringType: OfferingType, completion: @escaping (_ packages: [Package]) -> Void) {
        Purchases.shared.getOfferings { allOfferings, error in
            if let allOfferings {
                switch offeringType {
                case .defaultOffering:
                    if let weeklyYearlyOfferings = allOfferings.all[RevenueCatConstants.weeklyYearlyOfferingIdentifier] {
                        let packages = weeklyYearlyOfferings.availablePackages
                        completion(packages)
                    }
                case .giftOffering:
                    if let weeklyYearlyOfferings = allOfferings.all[RevenueCatConstants.chatvantageGiftOfferingIdentifier] {
                        let packages = weeklyYearlyOfferings.availablePackages
                        completion(packages)
                    }
                }

            }
        }
    }
    
    //MARK: - Make a Purchase
    func makePurchase(package: Package, completion: @escaping ((RevenueCatPurchaseResult) -> Void)) {
        Purchases.shared.purchase(package: package) { [weak self] transaction, customerInfo, error, userCancelled in
            guard let self else { return }
            if customerInfo?.entitlements.all[RevenueCatConstants.entitlement]?.isActive == true {
                // unlock the greate pro content
                self.isSubscribe = true
                completion(.purchasedSuccessfully)
            } else if error == nil {
                self.isSubscribe = false
                completion(.didNotPurchase)
            } else if userCancelled {
                self.isSubscribe = false
                completion(.userCancelled)
            } else {
                self.isSubscribe = false
                completion(.didNotPurchase)
            }
        }
    }
    
    //MARK: - Check Subscription Status
    func checkSubscriptionStatus(completion: @escaping ((RevenueCatSubscriptionStatus) -> Void)) {
        Purchases.shared.getCustomerInfo { [weak self] customerInfo, error in
            guard let self else { return }
            
            if customerInfo?.entitlements[RevenueCatConstants.entitlement]?.isActive == true {
                completion(.subscriber)
                self.isSubscribe = true
            } else {
                completion(.notSubscriber)
//                false
                self.isSubscribe = true
            }
        }
    }
    
    //MARK: - Restore Purchases
    func restorePurchase(completion: @escaping ((RevenueCatRestorePurchaseResult) -> Void)) {
        Purchases.shared.restorePurchases { customerInfo, error in
            if customerInfo?.entitlements[RevenueCatConstants.entitlement]?.isActive == true {
                completion(.restoredSuccessfully)
            } else {
                completion(.didNotRestore(error?.localizedDescription))
            }
        }
    }




}
