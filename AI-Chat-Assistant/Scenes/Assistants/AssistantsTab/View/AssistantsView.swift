//
//  AssistantsView.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 12.09.2023.
//

import GoogleMobileAds
import UIKit

final class AssistantsView: UIView {

    //MARK: - Creating UI Elements
    lazy var assistantsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(SubscribeCollectionViewCell.self, forCellWithReuseIdentifier: SubscribeCollectionViewCell.identifier)
        collection.register(AssistantsCollectionAssistantsSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AssistantsCollectionAssistantsSectionHeader.identifier)
        collection.register(AssistantsCollectionCell.self, forCellWithReuseIdentifier: AssistantsCollectionCell.identifier)
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
extension AssistantsView {
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
            if bannerView != nil {
                bannerView.removeFromSuperview()
            }
        }
    }
    
}

//MARK: - AddSubview / Constraints
extension AssistantsView {
    private func setupViews() {
        backgroundColor = .vcBackground
        addSubview(assistantsCollectionView)
        
        assistantsCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide.snp.edges)
        }
    }
}

