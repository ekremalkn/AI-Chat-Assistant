//
//  HomeChatViewController.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.08.2023.
//

import UIKit
import ProgressHUD

protocol HomeChatViewInterface: AnyObject {
    func configureViewController()
    
    func assistantResponsing()
    func assistantResponsed()
    func didOccurErrorWhileResponsing(_ errorMsg: String)
    
    func reloadMessages()
    
    func resetTextViewMessageText()
    func scrollToBottomCollectionVİew()
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
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
    }
    
    //MARK: - Setup Delegates
    private func setupDelegates() {
        homeChatView.chatCollectionView.delegate = self
        homeChatView.chatCollectionView.dataSource = self
        
        homeChatView.delegate = self
        homeChatView.messageTextView.delegate = self
    }
    
    
    //MARK: - Keyboard Hiding
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
}

//MARK: - UITextViewDelegate
extension HomeChatViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel.currentInputText = textView.text
    }
}

//MARK: - Configure Chat Collection View
extension HomeChatViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfMessages()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let messages = viewModel.getUIMessages()
        let role = messages[indexPath.item].role
        
        switch role {
        case .system:
            return .init()
        case .user:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserChatCollectionCell.identifier, for: indexPath) as? UserChatCollectionCell else {
                return .init()
            }
            let userMessage = messages[indexPath.item].content
            
            cell.configure(with: userMessage)
            return cell
        case .assistant:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AssistantChatCollectionCell.identifier, for: indexPath) as? AssistantChatCollectionCell else {
                return .init()
            }
            let assistantMessage = messages[indexPath.item].content
            
            cell.configure(with: assistantMessage)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = collectionView.frame.width
        let cellDefaultUIElementsHeightAndPadding: CGFloat = 10 + 36 +  10
        var cellHeight: CGFloat = cellDefaultUIElementsHeightAndPadding

        let label:UILabel = UILabel(frame: CGRectMake(0, 0, cellWidth, CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = .systemFont(ofSize: 15)
        
        
        let messageText = viewModel.getUIMessages()[indexPath.item].content
        let spaceCount = messageText.components(separatedBy: "\n").count - 1
        label.text = messageText
        label.sizeToFit()
        
        cellHeight += label.frame.height + CGFloat((spaceCount * 15)) + 30
        
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
    
    func assistantResponsing() {
        ProgressHUD.colorHUD = .black.withAlphaComponent(0.5)
        ProgressHUD.colorAnimation = .lightGray
        ProgressHUD.show("Assistant typing...", interaction: false)
    }
    
    func assistantResponsed() {
        ProgressHUD.remove()
    }
    
    func didOccurErrorWhileResponsing(_ errorMsg: String) {
        ProgressHUD.colorHUD = .black.withAlphaComponent(0.5)
        ProgressHUD.colorAnimation = .red
        ProgressHUD.showError("Assistant confused", interaction: false)
    }
    
    func reloadMessages() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            homeChatView.chatCollectionView.reloadData()
        }
    }
    
    func resetTextViewMessageText() {
        homeChatView.messageTextView.text = nil
    }
    
    func scrollToBottomCollectionVİew() {
        let collectionView = homeChatView.chatCollectionView
        let contentHeight = collectionView.contentSize.height
        let collectionViewHeight = collectionView.bounds.height
        let bottomOffset = CGPoint(x: 0, y: max(0, contentHeight - collectionViewHeight + collectionView.contentInset.bottom))
        DispatchQueue.main.async {
            collectionView.setContentOffset(bottomOffset, animated: true)
        }
    }
    
}

//MARK: -  HomeChatViewButtonInterface
extension HomeChatViewController: HomeChatViewButtonInterface {
    func homeChatView(_ view: HomeChatView, sendButtonTapped button: UIButton) {
        viewModel.sendButtonTapped()
    }
    
    
}










