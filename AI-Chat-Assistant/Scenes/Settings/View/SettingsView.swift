//
//  SettingsView.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 22.09.2023.
//

import UIKit

final class SettingsView: UIView {

    //MARK: - Creating UI Elements
    lazy var settingsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collection
    }()

    

}
