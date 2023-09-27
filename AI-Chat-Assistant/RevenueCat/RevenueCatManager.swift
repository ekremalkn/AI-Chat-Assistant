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

final class RevenueCatManager {
    static let shared = RevenueCatManager()
    
    //MARK: - Variables
    var isSubscribe: Bool = false

    //MARK: - Get Offerings
    func getOfferings(completion: @escaping (_ packages: [Package]) -> Void) {
        Purchases.shared.getOfferings { allOfferings, error in
            if let allOfferings {
                if let weeklyYearlyOfferings = allOfferings.all[RevenueCatConstants.weeklyYearlyOfferingsIdentifier] {
                    let packages = weeklyYearlyOfferings.availablePackages
                    completion(packages)
                }
            }
        }
    }
    
    //MARK: - Make a Purchase
    func makePurchase(package: Package, completion: @escaping ((RevenueCatPurchaseResult) -> Void)) {
        Purchases.shared.purchase(package: package) { transaction, customerInfo, error, userCancelled in
            if customerInfo?.entitlements.all[RevenueCatConstants.entitlement]?.isActive == true {
                // unlock the greate pro content
                completion(.purchasedSuccessfully)
            } else if error == nil {
                completion(.didNotPurchase)
            } else if userCancelled {
                completion(.userCancelled)
            }
        }
    }
    
    //MARK: - Check Subscription Status
    func checkSubscriptionStatus(completion: @escaping ((RevenueCatSubscriptionStatus) -> Void)) {
        Purchases.shared.getCustomerInfo { customerInfo, error in
            if customerInfo?.entitlements[RevenueCatConstants.entitlement]?.isActive == true {
                completion(.subscriber)
            } else {
                completion(.notSubscriber)
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
