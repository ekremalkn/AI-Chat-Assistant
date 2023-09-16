//
//  AssistantsCollectionHeader.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 13.09.2023.
//

import UIKit

protocol AssistantsCollectionHeaderDelegate: AnyObject {
    func assistantsCollectionHeader(_ header: AssistantsCollectionHeader, didSelectAssistantCategory cellIndexPath: IndexPath)
}

final class AssistantsCollectionHeader: UICollectionReusableView {
    static let identifier = "AssistantsCollectionHeader"
    
    //MARK: - Creating UI Elements
    private lazy var headerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Assistants"
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    lazy var assistantCategoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(AssistantsCategoryCollectionCell.self, forCellWithReuseIdentifier: AssistantsCategoryCollectionCell.identifier)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.contentInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        return collection
    }()
    
    //MARK: - References
    weak var delegate: AssistantsCollectionHeaderDelegate?
    
    //MARK: - Variabes
    var assistantTags: [AssistantTag] = [] {
        didSet {
            reloadTags()
        }
    }
    
    var isLoadingTags: Bool = true {
        didSet {
            if oldValue {
                reloadTags()
            }
        }
    }
    
    var selectedAssisantCategoryCellIndexPath: IndexPath?
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with assistantTags: [AssistantTag], selectedAssistantCategoryCellIndexPath: IndexPath) {
        self.assistantTags = assistantTags
        self.selectedAssisantCategoryCellIndexPath = selectedAssistantCategoryCellIndexPath
    }
    
    //MARK: - Setup Delegates
    private func setupDelegates() {
        assistantCategoryCollectionView.delegate = self
        assistantCategoryCollectionView.dataSource = self
    }
    
    func reloadTags() {
        let collectionView = assistantCategoryCollectionView
        
        DispatchQueue.main.async {
            collectionView.reloadData()
        }
    }

}

//MARK: - Configure Collection View
extension AssistantsCollectionHeader: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isLoadingTags ? 1 : assistantTags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isLoadingTags {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AssistantsCategoryCollectionCell.identifier, for: indexPath) as? AssistantsCategoryCollectionCell else {
                return .init()
            }
            
            cell.showLoadingIndicator()
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AssistantsCategoryCollectionCell.identifier, for: indexPath) as? AssistantsCategoryCollectionCell else {
                return .init()
            }
            
            if let selectedAssisantCategoryCellIndexPath, selectedAssisantCategoryCellIndexPath == indexPath {
                cell.selectCell()
            } else {
                cell.deselectCell()
            }
            
            let assistant = assistantTags[indexPath.item]
            cell.configure(assistant: assistant)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? AssistantsCategoryCollectionCell else { return }
        cell.selectCell()
        delegate?.assistantsCollectionHeader(self, didSelectAssistantCategory: indexPath)
        
        if let selectedAssisantCategoryCellIndexPath, !(selectedAssisantCategoryCellIndexPath == indexPath) {
            guard let cellToDeselect = collectionView.cellForItem(at: selectedAssisantCategoryCellIndexPath) as? AssistantsCategoryCollectionCell else { return }
            cellToDeselect.deselectCell()
        }
        
        self.selectedAssisantCategoryCellIndexPath = indexPath
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight: CGFloat = collectionView.frame.height

        if isLoadingTags {
            let cellWidth: CGFloat = 60
            
            return .init(width: cellWidth, height: cellHeight)
        } else {
            let assistantTitle = assistantTags[indexPath.item].name ?? ""
            let assistantsTitleWidth = assistantTitle.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]).width
            
            let cellWidth: CGFloat = assistantsTitleWidth + (2 * 15)
            
            return .init(width: cellWidth, height: cellHeight)
        }
    }
    
    
    
}


//MARK: - AddSubview / Constraints
extension AssistantsCollectionHeader {
    private func setupViews() {
        backgroundColor = .vcBackground
        addSubview(headerTitleLabel)
        addSubview(assistantCategoryCollectionView)
        
        headerTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
        }
        
        assistantCategoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(headerTitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(-20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
}

