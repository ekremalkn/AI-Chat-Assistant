//
//  ChatViewController.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.08.2023.
//

import UIKit
import ProgressHUD

protocol ChatViewInterface: AnyObject {
    func configureViewController()
    
    func assistantResponsing()
    func assistantResponsed()
    func didOccurErrorWhileResponsing(_ errorMsg: String)
    
    func reloadMessages()
    
    func configureModelSelectButton(with currentModel: GPTModel)
    func resetTextViewMessageText()
    func scrollToBottomCollectionVİew()
    
}

final class ChatViewController: UIViewController {
    
    //MARK: - References
    weak var homeChatCoordinator: ChatCoordinator?
    private let viewModel: ChatViewModel
    private let chatView = ChatView()
    
    //MARK: - Life Cycle Methods
    init(viewModel: ChatViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = chatView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    //MARK: - Configure Navigation Items
    private func configureNavItems() {
        let modelSelectButton = ChatModelSelectButton(model: viewModel.currentModel)
        modelSelectButton.addTarget(self, action: #selector(modelSelectButtonTapped), for: .touchUpInside)
        let modelSelectBarButton = UIBarButtonItem(customView: modelSelectButton)
        
        let shareChatButton = UIButton(type: .system)
        shareChatButton.tintColor = .white
        shareChatButton.setImage(.init(systemName: "square.and.arrow.up"), for: .normal)
        shareChatButton.addTarget(self, action: #selector(shareChatButtonTapped), for: .touchUpInside)
        
        let shareChatBarButton = UIBarButtonItem(customView: shareChatButton)
        navigationItem.rightBarButtonItem = shareChatBarButton
        navigationItem.leftBarButtonItem = modelSelectBarButton
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    //MARK: - Setup Delegates
    private func setupDelegates() {
        homeChatCoordinator?.delegate = self
        
        chatView.chatCollectionView.delegate = self
        chatView.chatCollectionView.dataSource = self
        
        chatView.delegate = self
        chatView.messageTextView.delegate = self
    }
    
    
}

//MARK: - Button Actions
extension ChatViewController {
    @objc private func modelSelectButtonTapped() {
        homeChatCoordinator?.openModelSelectVC(with: viewModel.currentModel)
    }
    
    @objc private func shareChatButtonTapped() {
        
    }
    
}

//MARK: - UITextViewDelegate
extension ChatViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel.currentInputText = textView.text
        
        if !textView.text.isEmpty {
            chatView.setSendButtonTouchability(true)
        } else {
            chatView.setSendButtonTouchability(false)
        }
    }
}

//MARK: - Configure Chat Collection View
extension ChatViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfMessages()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let role = viewModel.uiMessages[indexPath.item].role
        
        switch role {
        case .system:
            return .init()
        case .user:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserChatCollectionCell.identifier, for: indexPath) as? UserChatCollectionCell else {
                return .init()
            }
            
            let userMessage = viewModel.uiMessages[indexPath.item].content
            
            cell.configure(with: userMessage)
            cell.delegate = self
            
            return cell
        case .assistant:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AssistantChatCollectionCell.identifier, for: indexPath) as? AssistantChatCollectionCell else {
                return .init()
            }
            let assistantMessage = viewModel.uiMessages[indexPath.item].content
            
            if indexPath.item == viewModel.uiMessages.count - 1 {
                cell.setMoreButtonToMenu(true)
            } else {
                cell.setMoreButtonToMenu(false)
            }
            
            cell.configure(with: assistantMessage)
            cell.delegate = self
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = collectionView.frame.width
        let cellDefaultUIElementsHeightAndPadding: CGFloat = 10 + 36 +  10
        var cellHeight: CGFloat = cellDefaultUIElementsHeightAndPadding
        
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, cellWidth - 102, CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = .systemFont(ofSize: 15)
        
        
        
        let messageText = viewModel.uiMessages[indexPath.item].content
        label.text = messageText
        label.sizeToFit()
        
        if cellHeight < label.frame.height {
            cellHeight += label.frame.height
        }
        
        return .init(width: cellWidth, height: cellHeight)
    }
    
}


//MARK: - ChatViewInterface
extension ChatViewController: ChatViewInterface {
    func configureViewController() {
        configureNavItems()
        setupDelegates()
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
        ProgressHUD.showError("Assistant confused \n Please ask again", image: .init(named: "chat_confused"), interaction: false)
    }
    
    func reloadMessages() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            chatView.chatCollectionView.reloadData()
        }
    }
    
    func configureModelSelectButton(with currentModel: GPTModel) {
        if let modelSelectButton = navigationController?.navigationItem.leftBarButtonItem as? ChatModelSelectButton {
            modelSelectButton.configure(with: currentModel)
        }
    }
    
    func resetTextViewMessageText() {
        chatView.messageTextView.text = nil
        chatView.setSendButtonTouchability(false)
    }
    
    func scrollToBottomCollectionVİew() {
        let collectionView = chatView.chatCollectionView
        let contentHeight = collectionView.contentSize.height
        let collectionViewHeight = collectionView.bounds.height
        let bottomOffset = CGPoint(x: 0, y: max(0, contentHeight - collectionViewHeight + collectionView.contentInset.bottom))
        DispatchQueue.main.async {
            collectionView.setContentOffset(bottomOffset, animated: true)
        }
    }
    
}

//MARK: -  HomeChatViewButtonInterface
extension ChatViewController: ChatViewDelegate {
    func chatView(_ view: ChatView, sendButtonTapped button: UIButton) {
        viewModel.sendButtonTapped()
    }
    
    
}

//MARK: - UserChatCollectionCellDelegate
extension ChatViewController: UserChatCollectionCellDelegate {
    func userChatCollectionCell(_ cell: UserChatCollectionCell, copyButtonTapped copiedText: String) {
        copyButtonTapped(copiedText: copiedText)
    }
    
}

//MARK: - AssistantChatCollectionCellDelegate
extension ChatViewController: AssistantChatCollectionCellDelegate {
    func assistantChatCollectionCell(_ cell: AssistantChatCollectionCell, reGenerateButtonTapped: Void) {
        viewModel.reGenerateButtonTapped()
    }
    
    func assistantChatCollectionCell(_ cell: AssistantChatCollectionCell, copyButtonTapped copiedText: String) {
        copyButtonTapped(copiedText: copiedText)
    }
    
    func assistantChatCollectionCell(_ cell: AssistantChatCollectionCell, shareButtonTapped textToShare: String) {
        ProgressHUD.colorAnimation = .lightGray
        ProgressHUD.show(interaction: false)
        
        let shareSheetVC = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        shareSheetVC.popoverPresentationController?.sourceView = cell
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            present(shareSheetVC, animated: true) {
                ProgressHUD.remove()
            }
        }
    }
    
    func assistantChatCollectionCell(_ cell: AssistantChatCollectionCell, feedBackButtonTapped: Void) {
        
    }
    
    
}

//MARK: - Helper Methods
extension ChatViewController {
    private func copyButtonTapped(copiedText: String) {
        copiedText.copyToClipboard { [weak self] result in
            guard let self else { return }
            switch result {
            case .success:
                showToast(message: "Copied to clipboard", image: .init(systemName: "doc.on.doc.fill"), duration: 1.5)
            case .failure:
                showToast(message: "Failed to copy to clipboard", image: .init(systemName: "doc.on.doc.fill"), duration: 1.5)
            }
        }
    }
}

//MARK: - HomeChatCoordinatorDelegate
extension ChatViewController: ChatCoordinatorDelegate {
    func chatCoordinator(_ coordinator: ChatCoordinator, didSelectModel model: GPTModel) {
        guard let modelSelectButton = navigationItem.leftBarButtonItem?.customView as? ChatModelSelectButton else {
            return
        }
        
        viewModel.currentModel = model
        modelSelectButton.configure(with: viewModel.currentModel)
    }
    
    
}












