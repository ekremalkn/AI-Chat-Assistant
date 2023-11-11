//
//  GiftPaywallViewController.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 29.09.2023.
//

import UIKit
import RevenueCat
import ProgressHUD

protocol GiftPaywallViewInterface: AnyObject {
    func configureViewController()
    
    func reloadPackages()
    
    func restoringPurchase()
    func restoredPurchase()
    func didOccurErrorWhileRestoringPurchase(_ errorMsg: String)
    
    func startingToPurchase()
    func userCancelledWhilePurchase()
    func purchasedSuccessfuly()
    func didOccurErrorWhilePurchasing(_ errorMsg: String)
    
    func selectCell(at indexPath: IndexPath)
    func deselectCell(at indexPath: IndexPath)
    
    func disMissPaywall()
}

final class GiftPaywallViewController: UIViewController {
    
    //MARK: - References
    weak var giftPaywallCoordinator: GiftPaywallCoordinator?
    private let viewModel: GiftPaywallViewModel
    private let giftPaywallView = GiftPaywallView()
    
    //MARK: - Life Cycle Methods
    init(viewModel: GiftPaywallViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = giftPaywallView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        giftPaywallView.showCloseButton()
    }
    
    private func setupDelegates() {
        giftPaywallView.delegate = self
        
        giftPaywallView.packageCollectionView.delegate = self
        giftPaywallView.packageCollectionView.dataSource = self
    }
    
}

//MARK: - Configure CollectionView
extension GiftPaywallViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.packages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GiftPackageCollectionCell.identifier, for: indexPath) as? GiftPackageCollectionCell else {
            return .init()
        }
        let packageTuple = viewModel.packages[indexPath.item]
        
        cell.configure(with: packageTuple)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            guard let cell = cell as? GiftPackageCollectionCell else { return }
            
            if viewModel.selectedPackageIndex == indexPath.item {
                cell.selectCell()
            } else {
                cell.deselectCell()
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectPackage(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = collectionView.frame.width - 40
        let cellHeight: CGFloat = (collectionView.frame.height - CGFloat((viewModel.packages.count - 1) * 20)) / CGFloat(viewModel.packages.count)
        
        return .init(width: cellWidth, height: cellHeight)
    }
    
    
}


//MARK: - AddSubview / Constraints
extension GiftPaywallViewController: GiftPaywallViewInterface {
    func configureViewController() {
        setupDelegates()
    }
    
    func reloadPackages() {
        let collectionView = giftPaywallView.packageCollectionView
        
        DispatchQueue.main.async {
            collectionView.reloadData()
        }
    }
    
    func restoringPurchase() {
        ProgressHUD.animationType = .circleStrokeSpin
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
        ProgressHUD.animationType = .circleStrokeSpin
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
    
    func selectCell(at indexPath: IndexPath) {
        let collectionView = giftPaywallView.packageCollectionView
        
        DispatchQueue.main.async {
            guard let cell = collectionView.cellForItem(at: indexPath) as? GiftPackageCollectionCell else { return }
            cell.selectCell()
        }
    }
    
    func deselectCell(at indexPath: IndexPath) {
        let collectionView = giftPaywallView.packageCollectionView
        
        DispatchQueue.main.async {
            guard let cell = collectionView.cellForItem(at: indexPath) as? GiftPackageCollectionCell else { return }
            cell.deselectCell()
        }
    }
    
    func disMissPaywall() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.dismiss(animated: true)
        }
    }
}


//MARK: - GiftPaywallViewDelegate
extension GiftPaywallViewController: GiftPaywallViewDelegate {
    func giftPaywallView(_ view: GiftPaywallView, restoreButtonTapped button: UIButton) {
        viewModel.restoreButtonTapped()
    }
    
    func giftPaywallView(_ view: GiftPaywallView, closeButtonTapped button: UIButton) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.dismiss(animated: true)
        }
    }
    
    func giftPaywallView(_ view: GiftPaywallView, purchaseButtonTapped button: UIButton) {
        viewModel.purchaseButtonTapped()
    }
    
    func giftPaywallView(_ view: GiftPaywallView, termOfServiceButtonTapped button: UIButton) {
        giftPaywallCoordinator?.openSafari(with: AppInfo.termOfUse, onVC: self)
    }
    
    func giftPaywallView(_ view: GiftPaywallView, privacyPolicyButtonTapped button: UIButton) {
        giftPaywallCoordinator?.openSafari(with: AppInfo.privacyPolicyURL, onVC: self)
    }
    
    
}
