//
//  PaywallViewController.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 24.09.2023.
//

import UIKit
import RevenueCat
import ProgressHUD

protocol PaywallViewInterface: AnyObject {
    func configureViewController()
    
    func configurePlanInfoLabelWithPackage(package: Package)
    
    func restoringPurchase()
    func restoredPurchase()
    func didOccurErrorWhileRestoringPurchase(_ errorMsg: String)
    
    func startingToPurchase()
    func userCancelledWhilePurchase()
    func purchasedSuccessfuly()
    func didOccurErrorWhilePurchasing(_ errorMsg: String)
    
    func disMissPaywall()
}

final class PaywallViewController: UIViewController {

    //MARK: - References
    weak var paywallCoordinator: PaywallCoordinator?
    private let viewModel: PaywallViewModel
    private let paywallView = PaywallView()
    
    //MARK: - Life Cycle Methods
    init(viewModel: PaywallViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = paywallView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        paywallView.startTypeWriteAnimation()
        paywallView.showCloseButton()
    }
    
    //MARK: - Setup Delegates
    private func setupDelegates() {
        paywallView.delegate = self
    }


}

//MARK: - PaywallViewInterface
extension PaywallViewController: PaywallViewInterface {
    func configureViewController() {
        setupDelegates()
    }
    
    func configurePlanInfoLabelWithPackage(package: RevenueCat.Package) {
        paywallView.configurePlanInfoLabelWithPackage(package: package)
    }
    
    func restoringPurchase() {
        ProgressHUD.colorHUD = .vcBackground
        ProgressHUD.colorStatus = .vcBackground
        ProgressHUD.colorAnimation = .vcBackground
        ProgressHUD.show(interaction: false)
    }
    
    func restoredPurchase() {
        ProgressHUD.colorHUD = .vcBackground
        ProgressHUD.colorStatus = .vcBackground
        ProgressHUD.colorAnimation = .main
        ProgressHUD.showSucceed("Restore successfully completed".localized())
    }
    
    func didOccurErrorWhileRestoringPurchase(_ errorMsg: String) {
        ProgressHUD.showError("You don't have an active subscription now".localized(), image: .init(named: "chat_shocked"))
    }
    
    func startingToPurchase() {
        ProgressHUD.colorHUD = .vcBackground
        ProgressHUD.colorStatus = .vcBackground
        ProgressHUD.colorAnimation = .vcBackground
        ProgressHUD.show(interaction: false)
    }
    
    func userCancelledWhilePurchase() {
        ProgressHUD.remove()
    }
    
    func purchasedSuccessfuly() {
        ProgressHUD.colorHUD = .vcBackground
        ProgressHUD.colorStatus = .vcBackground
        ProgressHUD.colorAnimation = .main
        ProgressHUD.showSucceed("Purchase successfully completed".localized())
    }
    
    func didOccurErrorWhilePurchasing(_ errorMsg: String) {
        ProgressHUD.showError("\(errorMsg)", image: .init(named: "chat_shocked"))
    }
 
    func disMissPaywall() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.dismiss(animated: true)
        }
    }
}

//MARK: - PaywallViewDelegate
extension PaywallViewController: PaywallViewDelegate {
    func paywallView(_ view: PaywallView, restoreButtonTapped button: UIButton) {
        viewModel.restoreButtonTapped()
    }
    
    func paywallView(_ view: PaywallView, closeButtonTapped button: UIButton) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.dismiss(animated: true)
        }
    }
    
    func paywallView(_ view: PaywallView, purchaseButtonTapped button: UIButton) {
        viewModel.purchaseButtonTapped()
    }
    
    func paywallView(_ view: PaywallView, changePlanButtonTapped button: UIButton) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            
            let changePlanController = UIAlertController(title: "Change Plan".localized() + "\n", message: nil, preferredStyle: .actionSheet)
            
            
            viewModel.packages.forEach { package in
                switch package.packageType {
                case .annual:
                    let yearlyPlanAction = UIAlertAction(title: "Yearly Access".localized() + " \(package.localizedPriceString)" + "/year. ".localized(), style: .default) { [weak self] _ in
                        guard let self else { return }
                        viewModel.currentPackage = package
                    }
                    changePlanController.addAction(yearlyPlanAction)
                case .weekly:
                    let weekylPlanAction = UIAlertAction(title: "3 Days Trial. Then".localized() + " \(package.localizedPriceString)" + "/week. ".localized(), style: .default) { [weak self] _ in
                        guard let self else { return }
                        viewModel.currentPackage = package
                    }
                    changePlanController.addAction(weekylPlanAction)
                default:
                    return
                }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
            changePlanController.addAction(cancelAction)
            
            self.present(changePlanController, animated: true)
        }
    }
    
    func paywallView(_ view: PaywallView, termOfServiceButtonTapped button: UIButton) {
        paywallCoordinator?.openSafari(with: AppInfo.termOfUse, onVC: self)
    }
    
    func paywallView(_ view: PaywallView, privacyPolicyButtonTapped button: UIButton) {
        paywallCoordinator?.openSafari(with: AppInfo.privacyPolicyURL, onVC: self)
    }
    
    
}
