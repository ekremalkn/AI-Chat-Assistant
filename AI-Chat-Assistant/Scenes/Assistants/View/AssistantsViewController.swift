//
//  AssistantsViewController.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 12.09.2023.
//

import UIKit

protocol AssistantsViewInterface: AnyObject {
    func configureViewController()
    
    func reloadAssistants()
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
    
    //MARK: - Configure Nav Items
    private func configureNavItems() {
        let leftTitleButton = UIButton()
        leftTitleButton.setImage(.init(named: "ChatGPT_24px"), for: .normal)
        leftTitleButton.tintColor = .main
        leftTitleButton.setTitle(AppName.name, for: .normal)
        leftTitleButton.setTitleColor(.white, for: .normal)
        leftTitleButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        leftTitleButton.titleEdgeInsets = .init(top: 0, left: 5, bottom: 0, right: -5)
        
        let leftTitleBarButton = UIBarButtonItem(customView: leftTitleButton)
        
        navigationItem.leftBarButtonItem = leftTitleBarButton
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    //MARK: - Setup Delegates
    private func setupDelegates() {
        assistantsView.assistantsCollectionView.delegate = self
        assistantsView.assistantsCollectionView.dataSource = self
    }
    
}

//MARK: - Configure Collection View
extension AssistantsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //MARK: - Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AssistantsCollectionHeader.identifier, for: indexPath) as? AssistantsCollectionHeader else {
                return .init()
            }
            
            header.configure(with: viewModel.assistantsCollectionViewAssistants, selectedAssistantCategoryCellIndexPath: viewModel.selectedAssistantCategoryCellIndexPath)
            
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
        viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AssistantsCollectionCell.identifier, for: indexPath) as? AssistantsCollectionCell else {
            return .init()
        }
        
        let assistants = viewModel.getAssistants()
        let assistant = assistants[indexPath.item]
        cell.configure(with: assistant)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width - 40
        let cellHeight: CGFloat = 60
        
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
    
    
}

extension AssistantsViewController: AssistantsCollectionHeaderDelegate {
    func assistantsCollectionHeader(_ header: AssistantsCollectionHeader, didSelectAssistantCategory cellIndexPath: IndexPath) {
        viewModel.didSelectAssistantCategoryCellInHeader(assistantCategoryCellIndexPath: cellIndexPath)
    }
    
    
}
