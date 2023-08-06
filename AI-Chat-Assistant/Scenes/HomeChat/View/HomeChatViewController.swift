//
//  HomeChatViewController.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.08.2023.
//

import UIKit

protocol HomeChatViewInterface: AnyObject {
    func configureViewController()
}

final class HomeChatViewController: UIViewController {
    
    //MARK: - References
    weak var homeChatCoordinator: HomeChatCoordinator?
    private let viewModel: HomeChatViewModel
    private let homeChatView = HomeChatView()
    
    //MARK: - Life Cycle Methods
    init(viewModel: HomeChatViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = homeChatView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    //MARK: - Configure Navigation Items
    private func configureNavItems() {
        let titleLbl = UILabel()
        titleLbl.text = "AI Chat Assistant"
        titleLbl.textColor = .white
        titleLbl.font = .systemFont(ofSize: 20, weight: .black)
        
        let titleItem: UIBarButtonItem = .init(customView: titleLbl)
        navigationItem.leftBarButtonItems = [titleItem]
        
    }
    
    //MARK: - Setup Delegates
    private func setupDelegates() {
        homeChatView.chatCollectionView.delegate = self
        homeChatView.chatCollectionView.dataSource = self
    }
    
    
    //MARK: - Keyboard Hiding
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
}

//MARK: - Configure Chat Collection View
extension HomeChatViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AssistantChatCollectionCell.identifier, for: indexPath) as? AssistantChatCollectionCell else {
            return .init()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = collectionView.frame.width - 20
        let cellHeight: CGFloat = 75
        
        return .init(width: cellWidth, height: cellHeight)
    }
    
}


//MARK: - HomeChatViewInterface
extension HomeChatViewController: HomeChatViewInterface {
    func configureViewController() {
        configureNavItems()
        setupDelegates()
        hideKeyboardWhenTappedAround()
        setupKeyboardHiding()
    }
    
}









