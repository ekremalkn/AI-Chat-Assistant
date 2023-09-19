//
//  ChatHistoryViewController.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 18.09.2023.
//

import UIKit

protocol ChatHistoryViewInterface: AnyObject {
    func configureViewController()
    
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
    
    
}
