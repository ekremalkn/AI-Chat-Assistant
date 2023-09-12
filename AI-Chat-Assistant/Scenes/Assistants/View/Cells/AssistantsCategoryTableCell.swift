//
//  AssistantsCategoryTableCell.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 12.09.2023.
//

import UIKit

final class AssistantsCategoryTableCell: UITableViewCell {
    static let identifier = "AssistantsCategoryTableCell"
    
    //MARK: - Creating UI Elements
    lazy var assistantsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collection
    }()
    
    //MARK: - Init methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

//MARK: - AddSubview / Constraints
extension AssistantsCategoryTableCell {
    private func setupViews() {
        backgroundColor = .clear
        addSubview(assistantsCollectionView)
        
        assistantsCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide.snp.edges)
        }
    }
}

