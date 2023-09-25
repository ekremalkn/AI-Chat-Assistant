//
//  AssistantsViewController.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 12.09.2023.
//

import UIKit
import ProgressHUD

protocol AssistantsViewInterface: AnyObject {
    func configureViewController()
    
    func reloadAssistants()
    func reloadTags()
    
    
    func fetchingTags()
    func fetchedTags()
    func didOccurWhileFetchingTags(errorMsg: String)
    
    func fetchingAssistants()
    func fetchedAssistants()
    func didOccurWhileFetchingAssistants(errorMsg: String)
    
    func showNoInternetView()
    func deleteNoInternetView()
}

final class AssistantsViewController: UIViewController {
    
    //MARK: - References
    weak var assistantsCoordinator: AssistantsCoordinator?
    private let assistantsView = AssistantsView()
    private let viewModel: AssistantsViewModel
    
    //MARK: - Life Cycle Methods
    init(viewModel: AssistantsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = assistantsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
        navigationController?.tabBarController?.tabBar.isHidden = false
        navigationController?.tabBarController?.tabBar.isTranslucent = false
    }
    
    //MARK: - Configure Nav Items
    private func configureNavItems() {
        let leftTitleButton = NavigationLeftAppTitleButton()
        
        let leftTitleBarButton = UIBarButtonItem(customView: leftTitleButton)
        
        navigationItem.leftBarButtonItem = leftTitleBarButton
        
        let rightSettingButton = UIButton(type: .system)
        rightSettingButton.setImage(.init(named: "chat_setting"), for: .normal)
        rightSettingButton.tintColor = .white
        rightSettingButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        
        let rightHistoryButton = UIButton(type: .system)
        rightHistoryButton.setImage(.init(named: "chat_history"), for: .normal)
        rightHistoryButton.tintColor = .white
        rightHistoryButton.addTarget(self, action: #selector(historyButtonTapped), for: .touchUpInside)
        
        let rightSettingBarButtonItem = UIBarButtonItem(customView: rightSettingButton)
        let rightHistoryBarButtonItem = UIBarButtonItem(customView: rightHistoryButton)
        
        navigationItem.rightBarButtonItems = [rightSettingBarButtonItem, rightHistoryBarButtonItem]
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backBarButtonItem.tintColor = .main
        navigationItem.backBarButtonItem = backBarButtonItem
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .vcBackground
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }
    
    //MARK: - Setup Delegates
    private func setupDelegates() {
        assistantsView.assistantsCollectionView.delegate = self
        assistantsView.assistantsCollectionView.dataSource = self
    }
    
}

//MARK: - Button Actions
extension AssistantsViewController {
    @objc private func historyButtonTapped() {
        assistantsCoordinator?.openChatHistoryVC()
    }
    
    @objc private func settingsButtonTapped() {
        assistantsCoordinator?.openSettingsVC()
    }
}

//MARK: - Configure Collection View
extension AssistantsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //MARK: - Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AssistantsCollectionAssistantsSectionHeader.identifier, for: indexPath) as? AssistantsCollectionAssistantsSectionHeader else {
                return .init()
            }
            
            header.configure(with: viewModel.assistantTags, selectedAssistantCategoryCellIndexPath: viewModel.selectedAssistantCategoryCellIndexPath)
            
            header.delegate = self
            
            return header
        case UICollectionView.elementKindSectionFooter:
            break
        default:
            break
        }
        
        return .init()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let headerHeight: CGFloat = 100
        let headerWidth: CGFloat = collectionView.frame.width
        
        return .init(width: headerWidth, height: headerHeight)
    }
    
    //MARK: - Cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AssistantsCollectionCell.identifier, for: indexPath) as? AssistantsCollectionCell else {
            return .init()
        }
        
        let assistants = viewModel.assistants
        let assistant = assistants[indexPath.item]
        cell.configure(with: assistant)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let assistant = viewModel.assistants[indexPath.item]
        
        assistantsCoordinator?.openAssistantsPromptEdit(with: assistant)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width - 40
        let cellDefaultUIElementsHeightAndPadding: CGFloat = 32
        var cellHeight: CGFloat = cellDefaultUIElementsHeightAndPadding
        
        let label: UILabel = UILabel(frame: CGRectMake(0, 0, cellWidth - 40, CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = .systemFont(ofSize: 16, weight: .medium)
        
        let assistantTitle = viewModel.assistants[indexPath.item].title
        label.text = assistantTitle
        label.sizeToFit()
        
        cellHeight += label.frame.height
        
        return .init(width: cellWidth, height: cellHeight)
    }
    
    
    
}

//MARK: - AssistantsViewInterface
extension AssistantsViewController: AssistantsViewInterface {
    func configureViewController() {
        configureNavItems()
        setupDelegates()
    }
    
    func reloadAssistants() {
        let collectionView = assistantsView.assistantsCollectionView
        
        DispatchQueue.main.async {
            collectionView.reloadData()
        }
    }
    
    func reloadTags() {
        let collectionView = assistantsView.assistantsCollectionView
        
        DispatchQueue.main.async { [weak self] in
            guard let self, let header = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: viewModel.selectedAssistantCategoryCellIndexPath) as? AssistantsCollectionAssistantsSectionHeader else {  return }
            
            header.assistantTags = viewModel.assistantTags
            
        }
    }
    
    func fetchingTags() {
        let collectionView = assistantsView.assistantsCollectionView
        
        DispatchQueue.main.async {
            guard let header = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: .init(item: 0, section: 0)) as? AssistantsCollectionAssistantsSectionHeader else {  return }
            header.isLoadingTags = true
            
        }
    }
    
    func fetchedTags() {
        let collectionView = assistantsView.assistantsCollectionView
        
        DispatchQueue.main.async {
            guard let header = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: .init(item: 0, section: 0)) as? AssistantsCollectionAssistantsSectionHeader else {  return }
            header.isLoadingTags = false
            
            
            
        }
    }
    
    func didOccurWhileFetchingTags(errorMsg: String) {
        let collectionView = assistantsView.assistantsCollectionView
        
        DispatchQueue.main.async {
            guard let header = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: .init(item: 0, section: 0)) as? AssistantsCollectionAssistantsSectionHeader else {  return }
            header.isLoadingTags = false
            
        }
    }
    
    func fetchingAssistants() {
        ProgressHUD.colorHUD = .main
        ProgressHUD.colorStatus = .main
        ProgressHUD.colorAnimation = .main
        ProgressHUD.show(interaction: false)
    }
    
    func fetchedAssistants() {
        ProgressHUD.remove()
    }
    
    func didOccurWhileFetchingAssistants(errorMsg: String) {
        ProgressHUD.showError("Something went wrong", image: .init(named: "chat_shocked"), interaction: false, delay: 1.5)
    }
    
    func showNoInternetView() {
        addNoInternetView()
    }
    
    func deleteNoInternetView() {
        removeNoInternetView()
    }
}

extension AssistantsViewController: AssistantsCollectionAssistantsSectionHeaderDelegate {
    func assistantsCollectionAssistantsSectionHeader(_ header: AssistantsCollectionAssistantsSectionHeader, didSelectAssistantCategory cellIndexPath: IndexPath) {
        viewModel.didSelectAssistantCategoryCellInHeader(assistantCategoryCellIndexPath: cellIndexPath)
    }
    
    
}
