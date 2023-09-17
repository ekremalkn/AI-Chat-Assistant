//
//  AssistantsResponseViewController.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 16.09.2023.
//

import UIKit
import ProgressHUD

protocol AssistantsResponseViewInterface: AnyObject {
    func configureViewController()
    
    func assistantResponsing()
    func assistantResponsed()
    func didOccurErrorWhileResponsing(_ errorMsg: String)
    
    func resetTextViewMessageText()
    
    func reloadMessages()
}

final class AssistantsResponseViewController: UIViewController {
    
    //MARK: - References
    weak var assistantsResponseCoordinator: AssistantsResponseCoordinator?
    private let viewModel: AssistantsResponseViewModel
    private let assistantsResponseView = AssistantsResponseView()
    
    //MARK: - Life Cycle Methods
    init(viewModel: AssistantsResponseViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = assistantsResponseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }

    //MARK: - Configure Nav Items
    private func configureNavItems() {
        let label = UILabel()
        label.text = viewModel.assistant.title
        label.numberOfLines = 2
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .center
        navigationItem.titleView = label
        
        let shareChatButton = UIButton(type: .system)
        shareChatButton.tintColor = .white
        shareChatButton.setImage(.init(systemName: "square.and.arrow.up"), for: .normal)
        shareChatButton.addTarget(self, action: #selector(shareChatButtonTapped), for: .touchUpInside)
        shareChatButton.isEnabled = false
        
        let shareChatBarButton = UIBarButtonItem(customView: shareChatButton)
        
        navigationItem.rightBarButtonItem = shareChatBarButton
    }
    
    //MARK: - Setup Delegates
    private func setupDelegates() {
        assistantsResponseView.delegate = self
        
        assistantsResponseView.messageTextView.delegate = self
        
        assistantsResponseView.chatCollectionView.delegate = self
        assistantsResponseView.chatCollectionView.dataSource = self
    }
    
}

//MARK: - Button Actions
extension AssistantsResponseViewController {
    @objc private func shareChatButtonTapped() {
        let collectionView = assistantsResponseView.chatCollectionView
        
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

//MARK: - Configure CollectionView
extension AssistantsResponseViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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


//MARK: - AssistantsResponseViewInterface
extension AssistantsResponseViewController: AssistantsResponseViewInterface {
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
        assistantsResponseView.messageTextView.text = nil
        assistantsResponseView.setSendButtonTouchability(false)
    }
    
    func reloadMessages() {
        let collectionView = assistantsResponseView.chatCollectionView
        
        DispatchQueue.main.async {
            collectionView.reloadData()
        }
    }    
    
}

//MARK: - AssistantsResponseViewDelegate
extension AssistantsResponseViewController: AssistantsResponseViewDelegate {
    func assistantsResponseView(_ view: AssistantsResponseView, sendButtonTapped button: UIButton) {
        viewModel.sendButtonTapped()
    }
    
    
}

//MARK: - MessageTextViewDelegate
extension AssistantsResponseViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel.currentInputText = textView.text
        
        if !textView.text.isEmpty {
            assistantsResponseView.setSendButtonTouchability(true)
        } else {
            assistantsResponseView.setSendButtonTouchability(false)
        }
    }
}


//MARK: - UserChatCollectionCellDelegate
extension AssistantsResponseViewController: UserChatCollectionCellDelegate {
    func userChatCollectionCell(_ cell: UserChatCollectionCell, copyButtonTapped copiedText: String) {
        copyTextToClipboard(copiedText: copiedText)
    }
    
}

//MARK: - AssistantChatCollectionCellDelegate
extension AssistantsResponseViewController: AssistantChatCollectionCellDelegate {
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

//MARK: - Helper Methods(Share All Chat)
extension AssistantsResponseViewController {
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
            let temporaryFileURL = temporaryDirectory.appendingPathComponent("\(viewModel.assistant.title ?? "Unknown").jpg")
            
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

