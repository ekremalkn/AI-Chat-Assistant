//
//  PastChatViewController.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 20.09.2023.
//

import UIKit
import ProgressHUD

protocol PastChatViewInterface: AnyObject {
    func configureViewController()
    
    func assistantResponsing()
    func assistantResponsed()
    func didOccurErrorWhileResponsing(_ errorMsg: String)
    
    func resetTextViewMessageText()
    
    func reloadMessages()
    
    func showAlertBeforeDeleteChat()
    func chatSuccesfullyDeleted()
    func backToChatHistory()
    
    func scrollCollectionViewToBottom()
    
    func openPaywall()
    
    func showAd()
    func showReviewAlert()
    
    func updateFreeMessageCountLabel()
}

final class PastChatViewController: UIViewController {
    
    //MARK: - References
    weak var pastChatCoordinator: PastChatCoordinator?
    private let viewModel: PastChatViewModel
    private let pastChatView = PastChatView()
    
    //MARK: - Life Cycle Methods
    init(viewModel: PastChatViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = pastChatView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pastChatView.updateFreeMessageCountLabel()
        
    }
    
    //MARK: - Configure Nav Items
    private func configureNavItems() {
        let label = UILabel()
        label.text = viewModel.chatHistoryItem.chatTitleText
        label.numberOfLines = 2
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .center
        navigationItem.titleView = label
        
        let deleteButon = UIButton(type: .system)
        deleteButon.tintColor = .white
        deleteButon.setImage(.init(named: "chat_trash_bin"), for: .normal)
        deleteButon.addTarget(self, action: #selector(deleteChatFromCoreDataButtonTapped), for: .touchUpInside)
        let deleteBarButtonItem = UIBarButtonItem(customView: deleteButon)
        
        navigationItem.rightBarButtonItem = deleteBarButtonItem
        
    }
    
    //MARK: - Setup Delegates
    private func setupDelegates() {
        pastChatView.delegate = self
        
        pastChatView.messageTextView.delegate = self
        
        pastChatView.chatCollectionView.delegate = self
        pastChatView.chatCollectionView.dataSource = self
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
    
    func changeRightBarButtonToMore() {
        let moreButton = UIButton(type: .system)
        moreButton.tintColor = .white
        moreButton.setImage(.init(named: "chat_bar_button_more"), for: .normal)
        moreButton.showsMenuAsPrimaryAction = true
        
        
        let shareChat = UIAction(title: "Share Chat", image: .init(systemName: "square.and.arrow.up")) { [weak self] _ in
            guard let self else { return }
            if !viewModel.uiMessages.isEmpty {
                shareChatButtonTapped()
            } else {
                showAlertForEmptyChat()
            }
        }

        let deleteChat = UIAction(title: "Delete Chat", image: .init(systemName: "trash"), attributes: .destructive) { [weak self] _ in
            guard let self else { return }
            if !viewModel.uiMessages.isEmpty {
                showAlertBeforeDeleteChat()
            } else {
                showAlertForEmptyChat()
            }
        }
        
        let elements: [UIAction] = [shareChat, deleteChat]
        
        let moreMenu = UIMenu(children: elements)
        
        DispatchQueue.main.async {
            moreButton.menu = moreMenu
        }
        
        let moreBarButton = UIBarButtonItem(customView: moreButton)
        
        navigationItem.rightBarButtonItem = moreBarButton
    }
    
    
}

//MARK: - Actions
extension PastChatViewController {
    @objc private func deleteChatFromCoreDataButtonTapped() {
        showAlertBeforeDeleteChat()
    }
}


//MARK: - Configure CollectionView
extension PastChatViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //MARK: - Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ChatCollectionModelHeader.identifier, for: indexPath) as? ChatCollectionModelHeader else {
            return .init()
        }
        cell.configure(gptModel: viewModel.currentModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let headerWidth: CGFloat = collectionView.frame.width
        let headerHeight: CGFloat = 25
        
        return .init(width: headerWidth, height: headerHeight)
    }
    
    //MARK: - Cell
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
        label.font = .systemFont(ofSize: 15, weight: .medium)
        
        
        
        let messageText = viewModel.uiMessages[indexPath.item].content
        label.text = messageText
        label.sizeToFit()
        
        if cellHeight < label.frame.height + 20 {
            cellHeight += label.frame.height
        }
        
        return .init(width: cellWidth, height: cellHeight)
    }
    
}


//MARK: - PastChatViewInterface
extension PastChatViewController: PastChatViewInterface {
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
    
    func resetTextViewMessageText() {
        pastChatView.messageTextView.text = nil
        pastChatView.setSendButtonTouchability(false)
    }
    
    func reloadMessages() {
        let collectionView = pastChatView.chatCollectionView
        
        DispatchQueue.main.async {
            collectionView.reloadData()
        }
    }
    
    func showAlertBeforeDeleteChat() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            
            let alertController = UIAlertController(title: "Delete Chat", message: "Are you sure you want to delete the chat?", preferredStyle: .alert)
            
            let saveChatAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
                guard let self else { return }
                viewModel.deleteChatFromCoreData()
            }
            
            let deleteChatAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                
            }
            
            alertController.addAction(deleteChatAction)
            alertController.addAction(saveChatAction)
            
            present(alertController, animated: true)
        }
    }
    
    func chatSuccesfullyDeleted() {
        ProgressHUD.colorAnimation = .main
        ProgressHUD.colorHUD = .main
        ProgressHUD.showSucceed("Chat Successfully Deleted", interaction: false)
    }
    
    
    func backToChatHistory() {
        pastChatCoordinator?.backToChatHistory()
    }
    
    func scrollCollectionViewToBottom() {
        let collectionView = pastChatView.chatCollectionView
        let numberOfChatMessages = viewModel.uiMessages.count
        let lastItemIndex = IndexPath(item: numberOfChatMessages - 1, section: 0)
        
        let contentHeight = collectionView.contentSize.height
        let offsetY = collectionView.contentOffset.y
        let collectionViewHeight = collectionView.bounds.size.height
        
        // Eğer collectionView'in içeriği en altta değil ise
        if !(offsetY >= contentHeight - collectionViewHeight) {
            DispatchQueue.main.async {
                collectionView.performBatchUpdates {
                    collectionView.scrollToItem(at: lastItemIndex, at: .top, animated: true)
                }
            }
        }
    }
    
    func openPaywall() {
        pastChatCoordinator?.openPaywall()
    }
    
    func showAd() {
        
    }
    
    func showReviewAlert() {
        
    }
    
    func updateFreeMessageCountLabel() {
        pastChatView.updateFreeMessageCountLabel()
    }
}

//MARK: - MessageTextViewDelegate
extension PastChatViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel.currentInputText = textView.text
        
        if let assistantAnswered = viewModel.assistantAnswered {
            if !textView.text.isEmpty, assistantAnswered {
                pastChatView.setSendButtonTouchability(true)
            } else {
                pastChatView.setSendButtonTouchability(false)
            }
        } else {
            if !textView.text.isEmpty {
                pastChatView.setSendButtonTouchability(true)
            } else {
                pastChatView.setSendButtonTouchability(false)
            }
        }
    }
}

//MARK: - PastChatViewDelegate
extension PastChatViewController: PastChatViewDelegate {
    func pastChatView(_ view: PastChatView, continueChatButtonTapped button: UIButton) {
        pastChatView.setMessageTextViewAndSendButtonVisibility(hide: false)
        changeRightBarButtonToMore()
    }
    
    func pastChatView(_ view: PastChatView, shareChatButtonTapped button: UIButton) {
        shareChatButtonTapped()
    }
    
    func pastChatView(_ view: PastChatView, sendButtonTapped button: UIButton) {
        viewModel.sendButtonTapped()
    }
    
    func pastChatView(_ view: PastChatView, getPremiumButtonTapped button: UIButton) {
        pastChatCoordinator?.openPaywall()
    }
    
}

//MARK: - UserChatCollectionCellDelegate
extension PastChatViewController: UserChatCollectionCellDelegate {
    func userChatCollectionCell(_ cell: UserChatCollectionCell, copyButtonTapped copiedText: String) {
        copyTextToClipboard(copiedText: copiedText)
    }
    
}

//MARK: - AssistantChatCollectionCellDelegate
extension PastChatViewController: AssistantChatCollectionCellDelegate {
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
        if let appStoreReviewUrl = URL(string: "itms-apps://itunes.apple.com/gb/app/id\(AppInfo.appID)?action=write-review&mt=8") {
            UIApplication.shared.open(appStoreReviewUrl, options: [:], completionHandler: nil)
        }
    }
    
    
}

//MARK: - Helper Methods(Share All Chat)
extension PastChatViewController {
    private func shareChatButtonTapped() {
        let collectionView = pastChatView.chatCollectionView
        
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
            let temporaryFileURL = temporaryDirectory.appendingPathComponent("\(viewModel.chatHistoryItem.chatTitleText ?? "Unknown").jpg")
            
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
