//
//  SettingsViewController.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 22.09.2023.
//

import UIKit
import MessageUI
import ProgressHUD

protocol SettingsViewInterface: AnyObject {
    func configureViewController()
    
    func openMailToSendUS()
    func openAppStoreToWriteReview()
    func openShareSheetVCToShareApp()
    func openSafariToShowPrivacyPolicy()
    func openSafariToShowTermOfUse()
    func openPaywall()
    
    func insertSection(at section: Int)
    func deleteSection(at section: Int)
    
    func restoringPurchase()
    func restoredPurchase()
    func didOccurErrorWhileRestoringPurhcase(_ errMsg: String?)
}

final class SettingsViewController: UIViewController {
    
    //MARK: - References
    weak var settingsCoordinator: SettingsCoordinator?
    private let viewModel: SettingsViewModel
    private let settingsView = SettingsView()
    
    //MARK: - Init Methods
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.tabBarController?.tabBar.isTranslucent = true
        navigationController?.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear()
    }
    
    //MARK: - Configure Nav Items
    private func configureNavItems() {
        let label = UILabel()
        label.text = "Settings"
        label.numberOfLines = 2
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        navigationItem.titleView = label
    }
    
    //MARK: - Setup Delegates
    private func setupDelegates() {
        settingsView.settingsCollectionView.delegate = self
        settingsView.settingsCollectionView.dataSource = self
    }
    
    
}

//MARK: - Configure Collection View
extension SettingsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //MARK: - Header / Section
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.settingsSections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let sectionCategory = viewModel.settingsSections[indexPath.section].sectionCategory
            
            switch sectionCategory {
            case .subscribe:
                return .init()
            case .support, .about:
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SettingsCollectionSectionHeader.identifier, for: indexPath) as? SettingsCollectionSectionHeader else {
                    return .init()
                }
                
                let sectionCategory = viewModel.settingsSections[indexPath.section].sectionCategory
                header.configure(with: sectionCategory)
                
                return header
            }
        case UICollectionView.elementKindSectionFooter:
            let sectionCategory = viewModel.settingsSections[indexPath.section].sectionCategory
            
            if sectionCategory == .about {
                guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SettingsCollectionFooter.identifier, for: indexPath) as? SettingsCollectionFooter else {
                    return .init()
                }
                
                
                return footer
            } else {
                return .init()
            }
        default:
            return .init()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let headerWidth: CGFloat = collectionView.frame.width - 40
        
        let sectionCategory = viewModel.settingsSections[section].sectionCategory
        
        switch sectionCategory {
        case .subscribe:
            return .init()
        case .support, .about:
            let headerHeight: CGFloat = 20
            
            return .init(width: headerWidth, height: headerHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let sectionCategory = viewModel.settingsSections[section].sectionCategory
        
        switch sectionCategory {
        case .subscribe:
            return .init(top: 0, left: 0, bottom: 0, right: 0)
        case .support, .about:
            return .init(top: 0, left: 0, bottom: 40, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let sectionCategory = viewModel.settingsSections[section].sectionCategory
        if sectionCategory == .about {
            let footerWidth: CGFloat = collectionView.frame.width - 40
            let footerHeight: CGFloat = 50
            
            return .init(width: footerWidth, height: footerHeight)
        }
        
        return .init()
    }
    
    //MARK: - Cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.settingsSections[section].sectionItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionCategory = viewModel.settingsSections[indexPath.section].sectionCategory
        
        switch sectionCategory {
        case .subscribe:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubscribeCollectionViewCell.identifier, for: indexPath) as? SubscribeCollectionViewCell else {
                return .init()
            }
            cell.updateFreeMessageCountLabel()
            return cell
        case .support, .about:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingsCollectionCell.identifier, for: indexPath) as? SettingsCollectionCell else {
                return .init()
            }
            
            let sectionItem = viewModel.settingsSections[indexPath.section].sectionItems[indexPath.item]
            cell.configure(with: sectionItem)
            
            return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionCategory = viewModel.settingsSections[indexPath.section].sectionCategory
        let cellWidth: CGFloat = collectionView.frame.width - 40
        
        switch sectionCategory {
        case .subscribe:
            let cellHeight: CGFloat = 100
            
            return .init(width: cellWidth, height: cellHeight)
        case .support, .about:
            let cellHeight: CGFloat = 60
            
            return .init(width: cellWidth, height: cellHeight)
        }
        

    }
    
    
}

//MARK: - SettingsViewInterface
extension SettingsViewController: SettingsViewInterface {
    func configureViewController() {
        configureNavItems()
        setupDelegates()
    }
    
    func openMailToSendUS() {
        if MFMailComposeViewController.canSendMail() {
            settingsCoordinator?.openMail()
        } else {
            // show another thing
        }
    }
    
    func openAppStoreToWriteReview() {
        if let appStoreReviewUrl = URL(string: "itms-apps://itunes.apple.com/gb/app/id\(AppInfo.appID)?action=write-review&mt=8") {
            UIApplication.shared.open(appStoreReviewUrl, options: [:], completionHandler: nil)
        }
    }
    
    func openShareSheetVCToShareApp() {
        if let appstoreUrl = URL(string: "https://apps.apple.com/app/id\(AppInfo.appID)"), !appstoreUrl.absoluteString.isEmpty {
            settingsCoordinator?.openShareSheetVC(with: appstoreUrl)
        }
    }
    
    func openSafariToShowPrivacyPolicy() {
        settingsCoordinator?.openSafari(with: AppInfo.privacyPolicyURL)
    }
    
    func openSafariToShowTermOfUse() {
        settingsCoordinator?.openSafari(with: AppInfo.termOfUse)
    }
    
    func openPaywall() {
        settingsCoordinator?.openPaywall()
    }
    
    func restoringPurchase() {
        ProgressHUD.colorHUD = .vcBackground
        ProgressHUD.colorStatus = .vcBackground
        ProgressHUD.colorAnimation = .vcBackground
        ProgressHUD.show(interaction: false)
    }
    
    func restoredPurchase() {
        ProgressHUD.showSucceed("Restore successfully completed")
    }
  
    func didOccurErrorWhileRestoringPurhcase(_ errMsg: String?) {
        ProgressHUD.showError("You don't have an active subscription now", image: .init(named: "chat_shocked"))
    }
    
    
    func deleteSection(at section: Int) {
        let collectionView = settingsView.settingsCollectionView
        
        DispatchQueue.main.async {
            collectionView.performBatchUpdates {
                collectionView.deleteSections(.init(integer: section))
            }
        }
    }
    
    func insertSection(at section: Int) {
        let collectionView = settingsView.settingsCollectionView
        
        DispatchQueue.main.async {
            collectionView.performBatchUpdates { [weak self] in
                guard let self else { return }
                
                let subsrcibeSectionData = SettingsSection(sectionCategory: .subscribe, sectionItems: [.init(itemCategory: .contactUs, itemImage: "", itemTitle: "")])
                
                viewModel.settingsSections.insert(subsrcibeSectionData, at: 0)
                
                collectionView.insertSections(.init(integer: section))
                collectionView.insertItems(at: [.init(item: 0, section: section)])
            }
        }
    }
    

}

