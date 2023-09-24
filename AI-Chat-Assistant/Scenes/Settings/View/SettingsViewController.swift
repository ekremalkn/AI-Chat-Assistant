//
//  SettingsViewController.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 22.09.2023.
//

import UIKit
import MessageUI
import LinkPresentation

protocol SettingsViewInterface: AnyObject {
    func configureViewController()
    
    func openMailToSendUS()
    func openAppStoreToWriteReview()
    func openShareSheetVCToShareApp()
    func openSafariToShowPrivacyPolicy()
    func openSafariToShowTermOfUse()
    
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
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SettingsCollectionSectionHeader.identifier, for: indexPath) as? SettingsCollectionSectionHeader else {
                return .init()
            }
            
            let sectionCategory = viewModel.settingsSections[indexPath.section].sectionCategory
            header.configure(with: sectionCategory)
            
            return header
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
        let headerHeight: CGFloat = 20
        
        return .init(width: headerWidth, height: headerHeight)
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingsCollectionCell.identifier, for: indexPath) as? SettingsCollectionCell else {
            return .init()
        }
        
        let sectionItem = viewModel.settingsSections[indexPath.section].sectionItems[indexPath.item]
        cell.configure(with: sectionItem)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = collectionView.frame.width - 40
        let cellHeight: CGFloat = 60
        
        return .init(width: cellWidth, height: cellHeight)
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
    
    
}

