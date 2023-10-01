//
//  SuggestionsView.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 27.08.2023.
//

import GoogleMobileAds
import UIKit

final class SuggestionsView: UIView {
    
    //MARK: - Creating UI Elements
    lazy var suggestionsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(SuggestionsCollectionAllSuggestionsSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SuggestionsCollectionAllSuggestionsSectionHeader.identifier)
        collection.register(SuggestionsCollectionMostUsedSuggestionsSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SuggestionsCollectionMostUsedSuggestionsSectionHeader.identifier)
        collection.register(SuggestionsCollectionCell.self, forCellWithReuseIdentifier: SuggestionsCollectionCell.identifier)
        collection.contentInset = .init(top: 10, left: 20, bottom: 70, right: 20)
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    var bannerView: GADBannerView!
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setBannerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - AdMob Ads Configure
extension SuggestionsView {
    func setBannerView() {
        if !RevenueCatManager.shared.isSubscribe {
            bannerView = GADBannerView(adSize: GADAdSizeFromCGSize(.init(width: 300, height: 50)))
            
            addSubview(bannerView)
            
            bannerView.snp.makeConstraints { make in
                make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
                make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            }
        }
    }
    
    func removeBannerView() {
        if RevenueCatManager.shared.isSubscribe {
            bannerView.removeFromSuperview()
        }
    }
    
}

//MARK: - AddSubview / Constraints
extension SuggestionsView {
    private func setupViews() {
        backgroundColor = .vcBackground
        addSubview(suggestionsCollectionView)
        
        suggestionsCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide.snp.edges)
        }
    }
}

