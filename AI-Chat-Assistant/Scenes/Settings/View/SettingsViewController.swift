//
//  SettingsViewController.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 22.09.2023.
//

import UIKit

protocol SettingsViewInterface: AnyObject {
    func configureViewController()
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
            return .init()
        default:
            return .init()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let headerWidth: CGFloat = collectionView.frame.width - 40
        let headerHeight: CGFloat = 20
        
        return .init(width: headerWidth, height: headerHeight)
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
    
    
}
