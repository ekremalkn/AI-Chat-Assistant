//
//  UserChatCollectionCell.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.08.2023.
//

import UIKit
import SnapKit

protocol UserChatCollectionCellDelegate: AnyObject {
    func userChatCollectionCell(_ cell: UserChatCollectionCell, copyButtonTapped copiedText: String)
}

final class UserChatCollectionCell: UICollectionViewCell {
    static let identifier = "UserChatCollectionCell"
    
    //MARK: - Creating UI Elements
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .init(systemName: "person.fill")
        imageView.tintColor = .white
        return imageView
    }()

    private lazy var userTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.init(named: "chat_more"), for: .normal)
        button.tintColor = .white
        button.showsMenuAsPrimaryAction = true
        return button
    }()
    
    //MARK: - Reference
    weak var delegate: UserChatCollectionCellDelegate?
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setMoreButtonToMenu()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with userMessage: String) {
        userTextLabel.text = userMessage
    }

}

//MARK: - Configure More Button
extension UserChatCollectionCell {
    private func setMoreButtonToMenu() {
        let copy = UIAction(title: "Copy", image: .init(systemName: "doc.on.doc.fill")) { [weak self] _ in
            guard let self, let text = userTextLabel.text else { return }
            delegate?.userChatCollectionCell(self, copyButtonTapped: text)
        }
        
        let elements: [UIAction] = [copy]
        
        let moreMenu = UIMenu(title: "More About Text", children: elements)
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            moreButton.menu = moreMenu
        }
    }
}

//MARK: - Setup UI 
extension UserChatCollectionCell {
    private func setupViews() {
        backgroundColor = .vcBackground
        addSubview(userImageView)
        addSubview(userTextLabel)
        addSubview(moreButton)
        
        userImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(10)
            make.centerY.equalTo(self.safeAreaLayoutGuide.snp.centerY)
            make.width.height.equalTo(36)
        }
        
        moreButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(5)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.height.width.equalTo(36)
        }
        
        userTextLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(userImageView.snp.trailing).offset(5)
            make.trailing.equalTo(self.moreButton.snp.leading).offset(-5)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }
}
