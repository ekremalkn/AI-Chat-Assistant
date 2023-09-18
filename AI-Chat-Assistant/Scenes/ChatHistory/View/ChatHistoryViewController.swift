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
    
    //MARK: - Setup Delegates
    private func setupDelegates() {
        chatHistoryView.chatHistoryCollectionView.delegate = self
        chatHistoryView.chatHistoryCollectionView.dataSource = self
    }

    
}

//MARK: - Configure CollectionView
extension ChatHistoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatHistoryCollectionCell.identifier, for: indexPath) as? ChatHistoryCollectionCell else {
            return .init()
        }
        
        return cell
    }
    
    
}


//MARK: - ChatHistoryViewInterface
extension ChatHistoryViewController: ChatHistoryViewInterface {
    func configureViewController() {
        setupDelegates()
    }
    
    
}
