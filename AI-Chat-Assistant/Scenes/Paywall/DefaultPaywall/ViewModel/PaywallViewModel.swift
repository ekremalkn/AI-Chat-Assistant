//
//  PaywallViewModel.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 24.09.2023.
//

import Foundation
import RevenueCat

protocol PaywallViewModelInterface {
    var view: PaywallViewInterface? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    
    func restoreButtonTapped()
    func purchaseButtonTapped()
}

final class PaywallViewModel {
    
    //MARK: - References
    weak var view: PaywallViewInterface?
    
    //MARK: - Variables
    var currentPackage: Package? {
        didSet {
            if let currentPackage {
                view?.configurePlanInfoLabelWithPackage(package: currentPackage)
            }
        }
    }
    
    var weeklyPackage: Package?
    var yearlyPackage: Package?
    
    var packages: [Package] = []
    
    //MARK: - Init Methods
    init() {
        
    }

    //MARK: - Methods
    func getPackages() {
        RevenueCatManager.shared.getOfferings(for: .defaultOffering) { [weak self] packages in
            guard let self else { return }
            self.packages = packages
            
            if let weeklyPackageIndex = packages.firstIndex(where: { $0.identifier == RevenueCatConstants.weeklyPackageIdentifier }) {
                let weeklyPackage = packages[weeklyPackageIndex]
                self.weeklyPackage = weeklyPackage
                self.currentPackage = weeklyPackage
            }
            
            if let yearlyPackageIndex = packages.firstIndex(where: { $0.identifier == RevenueCatConstants.yearlyPackageIdentifier }) {
                let yearlyPackage = packages[yearlyPackageIndex]
                self.yearlyPackage = yearlyPackage
            }
        }
    }

}

//MARK: - PaywallViewModelInterface
extension PaywallViewModel: PaywallViewModelInterface {
    func viewDidLoad() {
        view?.configureViewController()
        getPackages()
    }
    
    func viewWillAppear() {
        if let currentPackage {
            view?.configurePlanInfoLabelWithPackage(package: currentPackage)
        }
    }
    
    func restoreButtonTapped() {
        view?.restoringPurchase()
        
        RevenueCatManager.shared.restorePurchase { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .restoredSuccessfully:
                view?.restoredPurchase()
                view?.disMissPaywall()
            case .didNotRestore(let errMsg):
                view?.didOccurErrorWhileRestoringPurchase(errMsg ?? "You don't have an active subscription now".localized())
            }
        }
    }
    
    func purchaseButtonTapped() {
        view?.startingToPurchase()
        
        if let currentPackage {
            RevenueCatManager.shared.makePurchase(package: currentPackage) { [weak self] result in
                guard let self else { return }
                
                switch result {
                case .purchasedSuccessfully:
                    view?.purchasedSuccessfuly()
                    view?.disMissPaywall()
                case .didNotPurchase:
                    view?.didOccurErrorWhilePurchasing("Did occur error. Please try again".localized())
                case .userCancelled:
                    view?.userCancelledWhilePurchase()
                }
                
            }

        } else {
            view?.didOccurErrorWhilePurchasing("Please try again.".localized())
        }
    }

}
