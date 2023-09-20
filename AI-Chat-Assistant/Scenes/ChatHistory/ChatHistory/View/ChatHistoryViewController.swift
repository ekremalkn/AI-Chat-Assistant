//
//  ChatHistoryViewController.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 18.09.2023.
//

import UIKit

protocol ChatHistoryViewInterface: AnyObject {
    func configureViewController()
    
    func reloadChatHistoryItems()
    func openPastChatVC(uiMessages: [UIMessage], chatHistoryItem: ChatHistoryItem)
}

final class ChatHistoryViewController: UIViewController {
    
    //MARK: - References
    weak var chatHistoryCoordinator: ChatHistoryCoordinator?
    private let viewModel: ChatHistoryViewModel
    private let chatHistoryView = ChatHistoryView()
    
    //MARK: - Life Cycle Methods
    init(viewModel: ChatHistoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = chatHistoryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
        navigationController?.tabBarController?.tabBar.isTranslucent = true
        navigationController?.tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: - Configure Nav Items
    private func configureNavItems() {
        let label = UILabel()
        label.text = "Chat History"
        label.numberOfLines = 2
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .center
        navigationItem.titleView = label
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backBarButtonItem.tintColor = .main
        navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    //MARK: - Setup Delegates
    private func setupDelegates() {
        chatHistoryView.chatHistoryCollectionView.delegate = self
        chatHistoryView.chatHistoryCollectionView.dataSource = self
    }
    
    
}

//MARK: - Configure CollectionView
extension ChatHistoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatHistoryCollectionCell.identifier, for: indexPath) as? ChatHistoryCollectionCell else {
            return .init()
        }
        
        let chatHistoryItem = viewModel.chatHistoryItems[indexPath.item]
        
        cell.configure(with: chatHistoryItem)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = collectionView.frame.width - 40
        let cellHeight: CGFloat = collectionView.frame.height * 0.30
        
        return .init(width: cellWidth, height: cellHeight)
    }
    
    
}


//MARK: - ChatHistoryViewInterface
extension ChatHistoryViewController: ChatHistoryViewInterface {
    func configureViewController() {
        configureNavItems()
        setupDelegates()
    }
    
    func openPastChatVC(uiMessages: [UIMessage], chatHistoryItem: ChatHistoryItem) {
        chatHistoryCoordinator?.openPastChatVC(uiMessages: uiMessages, selectedChatHistoryItem: chatHistoryItem)
    }
    
    func reloadChatHistoryItems() {
        let collectionView = chatHistoryView.chatHistoryCollectionView
        
        DispatchQueue.main.async {
            collectionView.performBatchUpdates {
                collectionView.reloadData()
            }
        }
    }
    
    
}
