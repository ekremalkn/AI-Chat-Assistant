//
//  GiftPaywallViewModel.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 29.09.2023.
//

import Foundation
import RevenueCat

protocol GiftPaywallViewModelInterface {
    var view: GiftPaywallViewInterface? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    
    func didSelectPackage(at indexPath: IndexPath)
    func restoreButtonTapped()
    func purchaseButtonTapped()
}

final class GiftPaywallViewModel {
    
    //MARK: - References
    weak var view: GiftPaywallViewInterface?
    
    var packages: [(expensivePackage: Package, cheapPackage: Package)] = []
    var selectedPackageIndex: Int = 0
    
    //MARK: - Init Methods
    init() {
        getPackages()
    }
    
    //MARK: - Methods
    func getPackages() {
        RevenueCatManager.shared.getOfferings(for: .giftOffering) { [weak self] cheapPackages in
            guard let self else { return }
            
            
            var sortedPackages: [(expensivePackage: Package, cheapPackage: Package)] = []
            
            RevenueCatManager.shared.getOfferings(for: .defaultOffering) {  [weak self] expensivePackages in
                guard let self else { return }
                
                if let weeklyExpensivePackageIndex = expensivePackages.firstIndex(where: { $0.identifier == RevenueCatConstants.weeklyPackageIdentifier }), let weeklyCheapPackageIndex = cheapPackages.firstIndex(where: { $0.identifier == RevenueCatConstants.weeklyPackageIdentifier})  {
                    let expensiveWeeklyPackage = expensivePackages[weeklyExpensivePackageIndex]
                    let cheapWeeklyPackage = cheapPackages[weeklyCheapPackageIndex]
                    
                    sortedPackages.append((expensiveWeeklyPackage, cheapWeeklyPackage))
                }
                
                if let monthlyExpensivePackageIndex = expensivePackages.firstIndex(where: { $0.identifier == RevenueCatConstants.monthlyPackageIdentifier }), let montlyhCheapPackageIndex = cheapPackages.firstIndex(where: { $0.identifier == RevenueCatConstants.monthlyPackageIdentifier}) {
                    let expensiveMonthlyPackage = expensivePackages[monthlyExpensivePackageIndex]
                    let cheapMonthlyPackage = cheapPackages[montlyhCheapPackageIndex]
                    
                    sortedPackages.append((expensiveMonthlyPackage, cheapMonthlyPackage))
                }
                
                if let yearlyExpensivePackageIndex = expensivePackages.firstIndex(where: { $0.identifier == RevenueCatConstants.yearlyPackageIdentifier }), let yearlyCheapPackageIndex = cheapPackages.firstIndex(where: { $0.identifier == RevenueCatConstants.yearlyPackageIdentifier }){
                    let expensiveYearlyPackage = expensivePackages[yearlyExpensivePackageIndex]
                    let cheapYearlyPackage = cheapPackages[yearlyCheapPackageIndex]
                    
                    sortedPackages.append((expensiveYearlyPackage, cheapYearlyPackage))
                }
                
                self.packages = sortedPackages
                
                view?.reloadPackages()
            }
            
        }
    }
    
}

//MARK: - AddSubview / Constraints
extension GiftPaywallViewModel: GiftPaywallViewModelInterface {
    func viewDidLoad() {
        view?.configureViewController()
    }
    
    func viewWillAppear() {
        
    }
    
    func didSelectPackage(at indexPath: IndexPath) {
        if self.selectedPackageIndex != indexPath.item {
            view?.selectCell(at: indexPath)
            let lastSelectedCellIndexPath = IndexPath(item: selectedPackageIndex, section: 0)
            view?.deselectCell(at: lastSelectedCellIndexPath)
            
            self.selectedPackageIndex = indexPath.item
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
                view?.didOccurErrorWhileRestoringPurchase(errMsg ?? "You don't have an active subscription now")
            }
        }
    }
    
    func purchaseButtonTapped() {
        view?.startingToPurchase()
        
        let currentPackage = packages[selectedPackageIndex].cheapPackage
        
        RevenueCatManager.shared.makePurchase(package: currentPackage) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .purchasedSuccessfully:
                view?.purchasedSuccessfuly()
                view?.disMissPaywall()
            case .didNotPurchase:
                view?.didOccurErrorWhilePurchasing("Did occur error. Please try again")
            case .userCancelled:
                view?.userCancelledWhilePurchase()
            }
            
        }
        
    }
    
    
}

