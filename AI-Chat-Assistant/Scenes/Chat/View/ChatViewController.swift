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
        let leftTitleButton = UIButton()
        leftTitleButton.setImage(.init(named: "ChatGPT_24px"), for: .normal)
        leftTitleButton.tintColor = .main
        leftTitleButton.setTitle(AppName.name, for: .normal)
        leftTitleButton.setTitleColor(.white, for: .normal)
        leftTitleButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        leftTitleButton.titleEdgeInsets = .init(top: 0, left: 5, bottom: 0, right: -5)
        
        let leftTitleBarButton = UIBarButtonItem(customView: leftTitleButton)
        
        navigationItem.leftBarButtonItem = leftTitleBarButton
        
        let moreButton = UIButton(type: .system)
        moreButton.tintColor = .white
        moreButton.setImage(.init(named: "chat_bar_button_more"), for: .normal)
        moreButton.showsMenuAsPrimaryAction = true
        moreButton.isEnabled = false
        
        let shareChat = UIAction(title: "Share Chat", image: .init(systemName: "square.and.arrow.up")) { [weak self] _ in
            guard let self else { return }
            if !viewModel.uiMessages.isEmpty {
                shareChatButtonTapped()
            } else {
                showAlertForEmptyChat()
            }
        }
        
        let newChat = UIAction(title: "Create Chat", image: .init(systemName: "plus.square")) { [weak self] _ in
            guard let self else { return }
            if !viewModel.uiMessages.isEmpty {
                showAlertBeforeCreateChat()
            } else {
                showAlertForEmptyChat()
            }
        }
        
        let settinsgChat = UIAction(title: "Settings", image: .init(named: "chat_setting")) { _ in
            
        }
        
        let deleteChat = UIAction(title: "Clear Chat", image: .init(systemName: "trash"), attributes: .destructive) { [weak self] _ in
            guard let self else { return }
            if !viewModel.uiMessages.isEmpty {
                viewModel.clearChat()
            } else {
                showAlertForEmptyChat()
            }
        }
        
        let elements: [UIAction] = [shareChat, newChat, settinsgChat, deleteChat]
        
        let moreMenu = UIMenu(children: elements)
        
        DispatchQueue.main.async {
            moreButton.menu = moreMenu
        }
        
        let moreBarButton = UIBarButtonItem(customView: moreButton)
        
        navigationItem.rightBarButtonItem = moreBarButton
        
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
    
    //MARK: - Show Alert before Delete Chat
    private func showAlertBeforeCreateChat() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            
            let alertController = UIAlertController(title: "Save this chat", message: "Would you like to save this chat before starting a new one?", preferredStyle: .alert)
            
            let saveChatAction = UIAlertAction(title: "Save", style: .default) { _ in
                self.viewModel.saveChatToCoreData()
                self.viewModel.clearChat()
                
                ProgressHUD.colorAnimation = .main
                ProgressHUD.colorHUD = .main
                ProgressHUD.showSucceed("Saved Chat", interaction: false)
                
            }
            
            let deleteChatAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
                self.viewModel.deleteChat()
            }
            
            alertController.addAction(deleteChatAction)
            alertController.addAction(saveChatAction)
            
            present(alertController, animated: true)
        }
    }
    
    //MARK: - Show Alert If Chat Is Empty
    private func showAlertForEmptyChat() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            
            let alertController = UIAlertController(title: "Empty Chat", message: "Please start a chat to perform this operation", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(okAction)
            
            present(alertController, animated: true)
        }
    }
    
    
    
}

//MARK: - Button Actions
extension ChatViewController {
    @objc private func modelSelectButtonTapped() {
        homeChatCoordinator?.openModelSelectVC(with: viewModel.currentModel)
    }
    
    private func shareChatButtonTapped() {
        let collectionView = chatView.chatCollectionView
        
        var collectionViewCellImages: [UIImage] = []
        
        for index in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: index, section: 0)
            if let cellImage = collectionView.cellForItem(at: indexPath)?.snapshot {
                // Her hücreyi collectionViewContainer'a ekleyin
                collectionViewCellImages.append(cellImage)
            }
        }
        
        let combinedImage = combineImagesVertically(collectionViewCellImages)
        
        shareCombinedImage(combinedImage)
    }
    
}

//MARK: - Configure Chat Collection View
extension ChatViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewModel.chatCollectionType {
        case .empty:
            return 1
        case .notEmpty:
            return viewModel.numberOfMessages()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.chatCollectionType {
        case .empty:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatCollectionModelSelectCell.identifier, for: indexPath) as? ChatCollectionModelSelectCell else {
                return .init()
            }
            
            cell.configure(with: viewModel.currentModel)
            
            return cell
        case .notEmpty:
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
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch viewModel.chatCollectionType {
        case .empty:
            modelSelectButtonTapped()
        case .notEmpty:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch viewModel.chatCollectionType {
        case .empty:
            let cellWidth: CGFloat = collectionView.frame.width - 40
            let cellHeight: CGFloat = 80
            
            return .init(width: cellWidth, height: cellHeight)
        case .notEmpty:
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
    
    //MARK: - Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            switch viewModel.chatCollectionType {
                
            case .empty:
                return .init()
            case .notEmpty:
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ChatCollectionModelHeader.identifier, for: indexPath) as? ChatCollectionModelHeader else {
                    return .init()
                }
                
                header.configure(gptModel: viewModel.currentModel)
                
                return header
            }
        case UICollectionView.elementKindSectionFooter:
            return .init()
        default:
            break
            
        }
        
        return .init()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch viewModel.chatCollectionType {
        case .empty:
            return .init()
        case .notEmpty:
            let headerWidth: CGFloat = collectionView.frame.width
            let headerHeight: CGFloat = 50
            
            return .init(width: headerWidth, height: headerHeight)
        }
        
    }
    
}


//MARK: - ChatViewInterface
extension ChatViewController: ChatViewInterface {
    func configureViewController() {
        configureNavItems()
        setupDelegates()
    }
    
    func assistantResponsing() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            if let shareBarButton = navigationItem.rightBarButtonItem {
                shareBarButton.isEnabled = false
            }
        }
    }
    
    func assistantResponsed() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            if let shareBarButton = navigationItem.rightBarButtonItem {
                shareBarButton.isEnabled = true
            }
        }
    }
    
    func didOccurErrorWhileResponsing(_ errorMsg: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            if let shareBarButton = navigationItem.rightBarButtonItem {
                shareBarButton.isEnabled = true
            }
            ProgressHUD.colorHUD = .black.withAlphaComponent(0.5)
            ProgressHUD.showError("Assistant confused \n Please ask again", image: .init(named: "chat_confused"), interaction: false)
            
        }
        
    }
    
    func reloadMessages() {
        let collectionView = chatView.chatCollectionView
        
        DispatchQueue.main.async {
            collectionView.reloadData()
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

//MARK: -  ChatViewDelegate
extension ChatViewController: ChatViewDelegate {
    func chatView(_ view: ChatView, sendButtonTapped button: UIButton) {
        viewModel.sendButtonTapped()
    }
    
    
}

//MARK: - UITextViewDelegate
extension ChatViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel.currentInputText = textView.text
        
        if let assistantAnswered = viewModel.assistantAnswered {
            if !textView.text.isEmpty, assistantAnswered {
                chatView.setSendButtonTouchability(true)
            } else {
                chatView.setSendButtonTouchability(false)
            }
        } else {
            if !textView.text.isEmpty {
                chatView.setSendButtonTouchability(true)
            } else {
                chatView.setSendButtonTouchability(false)
            }
        }
    }
}

//MARK: - UserChatCollectionCellDelegate
extension ChatViewController: UserChatCollectionCellDelegate {
    func userChatCollectionCell(_ cell: UserChatCollectionCell, copyButtonTapped copiedText: String) {
        copyTextToClipboard(copiedText: copiedText)
    }
    
}

//MARK: - AssistantChatCollectionCellDelegate
extension ChatViewController: AssistantChatCollectionCellDelegate {
    func assistantChatCollectionCell(_ cell: AssistantChatCollectionCell, reGenerateButtonTapped: Void) {
        viewModel.reGenerateButtonTapped()
    }
    
    func assistantChatCollectionCell(_ cell: AssistantChatCollectionCell, copyButtonTapped copiedText: String) {
        copyTextToClipboard(copiedText: copiedText)
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


//MARK: - HomeChatCoordinatorDelegate
extension ChatViewController: ChatCoordinatorDelegate {
    func chatCoordinator(_ coordinator: ChatCoordinator, didSelectModel model: GPTModel) {
        let collectionView = chatView.chatCollectionView
        
        viewModel.currentModel = model
        
        DispatchQueue.main.async {
            guard let cell = collectionView.cellForItem(at: .init(item: 0, section: 0)) as? ChatCollectionModelSelectCell else { return }
            cell.configure(with: model)
        }
        
    }
    
    
}

//MARK: - Helper Methods(Share All Chat)
extension ChatViewController {
    func combineImagesVertically(_ images: [UIImage]) -> UIImage? {
        let totalHeight = images.reduce(0) { (result, image) in
            return result + image.size.height
        }
        let maxWidth = images.max { (image1, image2) in
            return image1.size.width < image2.size.width
        }?.size.width ?? 0
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: maxWidth, height: totalHeight), false, 0.0)
        
        var currentY: CGFloat = 0.0
        for image in images {
            image.draw(in: CGRect(x: 0, y: currentY, width: maxWidth, height: image.size.height))
            currentY += image.size.height
        }
        
        let combinedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return combinedImage
    }
    
    func shareCombinedImage(_ combinedImage: UIImage?) {
        if let combinedImage = combinedImage,
           let imageData = combinedImage.jpegData(compressionQuality: 1.0) {
            // Geçici bir dosya oluşturun ve görüntüyü bu dosyaya kaydedin
            let temporaryDirectory = FileManager.default.temporaryDirectory
            let temporaryFileURL = temporaryDirectory.appendingPathComponent("\(UUID().uuidString).jpg")
            
            do {
                try imageData.write(to: temporaryFileURL)
                
                // Paylaşım ekranını gösterin
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    
                    // Paylaşım işlemi için dosya URL'sini kullanın
                    let activityViewController = UIActivityViewController(activityItems: [temporaryFileURL], applicationActivities: nil)
                    
                    activityViewController.completionWithItemsHandler = { _, _, _, _ in
                        try? FileManager.default.removeItem(at: temporaryFileURL)
                        
                    }
                    
                    present(activityViewController, animated: true)
                }
                
                
            } catch {
                // Dosya kaydetme hatası
                print("Dosya kaydetme hatası: \(error)")
            }
            
        }
    }
}











