//
//  AssistantsPromptEditViewController.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 16.09.2023.
//

import UIKit
import ProgressHUD
import BetterSegmentedControl

protocol AssistantsPromptEditViewInterface: AnyObject {
    func configureViewController()
    
    func chatServiceResponding()
    func chatServiceResponded()
    func didOccurErrorWhileChatServiceResponding(_ errorMsg: String)
    func openAssistantsResponseVC(with uiMessages: [UIMessage])
}

final class AssistantsPromptEditViewController: UIViewController {
    
    //MARK: - References
    weak var assistantsPromptEditCoordinator: AssistantsPromptEditCoordinator?
    private let viewModel: AssistantsPromptEditViewModel
    private let assistantsPromptEditView = AssistantsPromptEditView()
    
    //MARK: - Life Cycle Methods
    init(viewModel: AssistantsPromptEditViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = assistantsPromptEditView
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
        KeyboardManager.shared.setKeyboardToolbar(enable: true, doneButtonText: "Apply Edit")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        KeyboardManager.shared.setKeyboardToolbar(enable: false, doneButtonText: nil)
    }
    
    //MARK: - Configure Nav Items
    private func configureNavItems() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backBarButtonItem.tintColor = .main
        navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    //MARK: - Setup Delegates
    private func setupDelegates() {
        assistantsPromptEditView.delegate = self
        
        assistantsPromptEditView.assistantsPromptEditCollectionView.delegate = self
        assistantsPromptEditView.assistantsPromptEditCollectionView.dataSource = self
    }
    
}

//MARK: - Configure Collection View
extension AssistantsPromptEditViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AssistantsPromptEditCollectionCell.identifier, for: indexPath) as? AssistantsPromptEditCollectionCell else {
            return .init()
        }
        
        cell.configure(with: viewModel.assistant)
        cell.delegate = self
        cell.promptTextView.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? AssistantsPromptEditCollectionCell else { return }
        cell.highlightEditButton()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = collectionView.frame.width - 40
        let cellDefaultUIElementsHeightAndPadding: CGFloat = 20 + 40 + 20 + 10
        var cellHeight: CGFloat = cellDefaultUIElementsHeightAndPadding
        
        // section titlelabel frame height
        let sectionTitleLabel = UILabel(frame: CGRectMake(0, 0, collectionView.frame.width - 40, CGFloat.greatestFiniteMagnitude))
        sectionTitleLabel.numberOfLines = 0
        sectionTitleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        sectionTitleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        let sectionTitleText = viewModel.assistant.title
        sectionTitleLabel.text = sectionTitleText
        sectionTitleLabel.sizeToFit()
        
        // textview frame height
        let textView: UITextView = UITextView(frame: CGRect(x: 0, y: 0, width: cellWidth - 20, height: CGFloat.greatestFiniteMagnitude))
        textView.text = viewModel.assistant.prompt
        textView.font = .systemFont(ofSize: 16, weight: .medium)
        
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: collectionView.frame.height - 90 - 20)) // son 20 content insetin bottom 20si
        
        
        if newSize.height + cellDefaultUIElementsHeightAndPadding + sectionTitleLabel.frame.height + 20 + 20 >= collectionView.frame.height {
            cellHeight = collectionView.frame.height - (sectionTitleLabel.frame.height + 20 + 20) // son 20 content insetin bottom 20si
        } else {
            cellHeight += newSize.height
        }
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    //MARK: - Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AssistantsPromptEditCollectionSectionHeader.identifier, for: indexPath) as? AssistantsPromptEditCollectionSectionHeader else {
                return .init()
            }
            
            header.configure(assistant: viewModel.assistant)
            
            return header
        case UICollectionView.elementKindSectionFooter:
            return .init()
        default:
            return .init()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let headerWidth: CGFloat = collectionView.frame.width
        let headerDefaultUIElementsHeightAndPadding: CGFloat = 10
        var headerHeight: CGFloat = headerDefaultUIElementsHeightAndPadding
        
        let sectionTitleLabel = UILabel(frame: CGRectMake(0, 0, headerWidth - 40, CGFloat.greatestFiniteMagnitude))
        sectionTitleLabel.numberOfLines = 0
        sectionTitleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        sectionTitleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        let sectionTitleText = viewModel.assistant.title
        sectionTitleLabel.text = sectionTitleText
        sectionTitleLabel.sizeToFit()
        
        headerHeight += sectionTitleLabel.frame.height
        
        return .init(width: headerWidth, height: headerHeight)
    }
    
}

//MARK: - Configure Segmented Control
extension AssistantsPromptEditViewController {
    private func setupSegmentedControl() {
        let navigationSegmentedControl = BetterSegmentedControl(
            frame: CGRect(x: 0, y: 0, width: 200.0, height: 30.0),
            segments: LabelSegment.segments(withTitles: viewModel.gptModels.map { $0.modelUIName },
                                            normalTextColor: .white.withAlphaComponent(0.6),selectedTextColor: .white),
            options: [.backgroundColor(.cellBackground),
                      .indicatorViewBackgroundColor(.main),
                      .cornerRadius(6),
                      .animationSpringDamping(1.0)]
        )
        
        navigationSegmentedControl.addTarget(self,action: #selector(navigationSegmentedControlValueChanged),for: .valueChanged)
        navigationItem.titleView = navigationSegmentedControl
    }
    
    @objc private func navigationSegmentedControlValueChanged(_ sender: BetterSegmentedControl) {
        let selectedModelIndex = sender.index
        let selectedGPTModel = viewModel.gptModels[selectedModelIndex]
        viewModel.currentModel = selectedGPTModel
    }
}

//MARK: - AssistantsPromptEditViewInterface
extension AssistantsPromptEditViewController: AssistantsPromptEditViewInterface {
    func configureViewController() {
        setKeyboardAppearNotifications()
        configureNavItems()
        setupSegmentedControl()
        setupDelegates()
    }
    
    func chatServiceResponding() {
        ProgressHUD.colorHUD = .main
        ProgressHUD.colorStatus = .main
        ProgressHUD.colorAnimation = .main
        ProgressHUD.show(interaction: false)
    }
    
    func chatServiceResponded() {
        ProgressHUD.remove()
    }
    
    func didOccurErrorWhileChatServiceResponding(_ errorMsg: String) {
        ProgressHUD.colorHUD = .black.withAlphaComponent(0.5)
        ProgressHUD.colorStatus = .darkGray
        ProgressHUD.showError("Assistant confused \n Please ask again", image: .init(named: "chat_confused"), interaction: false)
    }
    
    func openAssistantsResponseVC(with uiMessages: [UIMessage]) {
        assistantsPromptEditCoordinator?.openAssistantsResponseVC(with: uiMessages, selectedGPTModel: viewModel.currentModel)
    }
    
}

//MARK: - PromptITextViewDelegate
extension AssistantsPromptEditViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel.promptTextDidChange(newPromptText: textView.text)
        
        if !textView.text.isEmpty {
            assistantsPromptEditView.setSumbitButtonTouchability(true)
        } else {
            assistantsPromptEditView.setSumbitButtonTouchability(false)
        }
    }
}

//MARK: - AssistantsPromptEditViewDelegate
extension AssistantsPromptEditViewController: AssistantsPromptEditViewDelegate {
    func assistantsPromptEditView(_ view: AssistantsPromptEditView, submitButtonTapped button: UIButton) {
        viewModel.submitButtonTapped()
    }
    
    
}


//MARK: - AssistantsPromptEditCollectionCellDelegate
extension AssistantsPromptEditViewController: AssistantsPromptEditCollectionCellDelegate {
    func assistantsPromptEditCollectionCell(_ cell: AssistantsPromptEditCollectionCell, promptEditButtonTapped textView: UITextView) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            
            if viewModel.promptIsEditing {
                textView.isEditable = false
                textView.isSelectable = false
                textView.resignFirstResponder()
                cell.promptEditButton.setTitle("Edit Prompt", for: .normal)
                viewModel.promptIsEditing = false
            } else {
                textView.isEditable = true
                textView.isSelectable = true
                textView.becomeFirstResponder()
                cell.promptEditButton.isHidden = true
                viewModel.promptIsEditing = true
            }
        }
    }
    
}

//MARK: - Keyboard Notifications
extension AssistantsPromptEditViewController {
    private func setKeyboardAppearNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        let collectionView = assistantsPromptEditView.assistantsPromptEditCollectionView
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            guard let cell = collectionView.cellForItem(at: .init(item: 0, section: 0)) as? AssistantsPromptEditCollectionCell else { return }
            cell.promptEditButton.isHidden = false
            cell.promptTextView.isEditable = false
            cell.promptTextView.isSelectable = false
            viewModel.promptIsEditing = false
        }
    }
    
}

