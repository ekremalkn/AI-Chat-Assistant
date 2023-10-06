//
//  RewardedAdAlertViewController.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.10.2023.
//

import UIKit

final class RewardedAdAlertViewController: UIViewController {
    
    deinit {
        print("RewardedAdAlertViewController deinit")
    }
    
    //MARK: - References
    weak var rewardedAdAlertCoordinator: RewardedAdAlertCoordinator?
    private let rewardedAdAlertView = RewardedAdAlertView()
    private let viewModel = RewardedAdAlertViewModel()
    
    //MARK: - Lifet Cycle Methods
    override func loadView() {
        super.loadView()
        view = rewardedAdAlertView
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        
    }
    
    //MARK: - Setup Delegates
    private func setupDelegates() {
        rewardedAdAlertView.delegate = self
        
        rewardedAdAlertView.rewardedAdAlertButtonCollectionView.delegate = self
        rewardedAdAlertView.rewardedAdAlertButtonCollectionView.dataSource = self
    }



}

//MARK: - Configure CollectionView
extension RewardedAdAlertViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.rewardedAdAlertButtonCollectionViewData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RewardedAdAlertButtonCollectionCell.identifier, for: indexPath) as? RewardedAdAlertButtonCollectionCell else {
            return .init()
        }
        
        let buttonType = viewModel.rewardedAdAlertButtonCollectionViewData[indexPath.item]
        cell.configure(with: buttonType)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedButtonType = viewModel.rewardedAdAlertButtonCollectionViewData[indexPath.item]
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.dismiss(animated: true) {
                self.rewardedAdAlertCoordinator?.didSelectButton(buttonType: selectedButtonType)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = collectionView.frame.width - 40
        let cellHeight: CGFloat = (collectionView.frame.height - 20) / 2
        
        return .init(width: cellWidth, height: cellHeight)
    }
    
}

extension RewardedAdAlertViewController: RewardedAdAlertViewDelegate {
    func rewardedAdAlertView(_ view: RewardedAdAlertView, closeButtonTapped button: UIButton) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.dismiss(animated: true)
        }
    }
    
    
}
