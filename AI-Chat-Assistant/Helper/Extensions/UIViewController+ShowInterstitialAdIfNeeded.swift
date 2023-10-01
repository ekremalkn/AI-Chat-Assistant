//
//  UIViewController+ShowInterstitialAdIfNeeded.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 1.10.2023.
//

import UIKit
import GoogleMobileAds // AdMob için

extension UIViewController {
        
    private var adCounter: Int {
        get {
            if let count = UserDefaults.standard.value(forKey: "adCounter") as? Int {
                return count
            } else {
                return 0
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "adCounter")
        }
    }
    
    func showInterstitialAdIfNeeded() {
        if !RevenueCatManager.shared.isSubscribe {
            if adCounter >= 15 {
                // 10 ekran açılışına ulaştığında reklamı göster
                let request = GADRequest()
                GADInterstitialAd.load(withAdUnitID: AdMobConstants.testInterstitialAdUnitID, request: request) { [weak self] ad, error in
                    guard let self else { return }
                    
                    if let error {
                        print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                    } else {
                        ad?.present(fromRootViewController: self)
                    }
                }
                print("InterstitialAd'I GOSTER")
                // Sayacı sıfırla
                adCounter = 0
            } else {
                // Sayacı artır
                adCounter += 1
                print("InterstitialAd GOSTERIMINE \(15 - adCounter) ADET EKRAN KALDI")
            }
        }
    }
}
