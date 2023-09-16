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
    
    //MARK: - Setup Delegates
    private func setupDelegates() {
        assistantsResponseView.delegate = self
        
        assistantsResponseView.messageTextView.delegate = self
        
        assistantsResponseView.chatCollectionView.delegate = self
        assistantsResponseView.chatCollectionView.dataSource = self
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
    func reloadMessages() {
        let collectionView = assistantsResponseView.chatCollectionView
        
        DispatchQueue.main.async {
            collectionView.reloadData()
        }
    }
    
    func configureViewController() {
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
    
    func resetTextViewMessageText() {
        assistantsResponseView.messageTextView.text = nil
        assistantsResponseView.setSendButtonTouchability(false)
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
        copyButtonTapped(copiedText: copiedText)
    }
    
}

//MARK: - AssistantChatCollectionCellDelegate
extension AssistantsResponseViewController: AssistantChatCollectionCellDelegate {
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
extension AssistantsResponseViewController {
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

