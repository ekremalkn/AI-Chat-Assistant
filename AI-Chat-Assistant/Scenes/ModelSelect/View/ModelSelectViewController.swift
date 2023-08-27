//
//  ModelSelectViewController.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 27.08.2023.
//

import UIKit

protocol ModelSelectViewInterface: AnyObject {
    func configureViewController()
    
    func didSelectModel(model: GPTModel)
    func reloadModelSelection()
    
}

final class ModelSelectViewController: UIViewController {

    //MARK: - References
    weak var modelSelectCoordinator: ModelSelectCoordinator?
    private let modelSelectView = ModelSelectView()
    private let viewModel: ModelSelectViewModel
    
    //MARK: - Life Cycle Methods
    init(viewModel: ModelSelectViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = modelSelectView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    //MARK: - Setup Delegates
    private func setupDelegates() {
        modelSelectView.delegate = self
        
        modelSelectView.modelSelectCollectionView.delegate = self
        modelSelectView.modelSelectCollectionView.dataSource = self
    }

}

//MARK: - Configure CollectionView
extension ModelSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ModelSelectCollectionCell.identifier, for: indexPath) as? ModelSelectCollectionCell else {
            return .init()
        }
        
        if viewModel.selectedModelIndex == indexPath.item {
            cell.cellSelected()
        } else {
            cell.cellDeSelected()
        }
        
        let model = viewModel.models[indexPath.item]
        cell.configure(with: model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectModel(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = collectionView.frame.width - 40
        let cellHeight: CGFloat = (collectionView.frame.height - 20) / 2
        
        return .init(width: cellWidth, height: cellHeight)
    }
    
}

//MARK: - ModelSelectViewInterface
extension ModelSelectViewController: ModelSelectViewInterface {
    func reloadModelSelection() {
        let collectionView = modelSelectView.modelSelectCollectionView
        
        DispatchQueue.main.async {
            collectionView.reloadData()
        }
    }
    
    func configureViewController() {
        setupDelegates()
    }
    
    func didSelectModel(model: GPTModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            dismiss(animated: true)
            modelSelectCoordinator?.didSelectModel(model: model)
        }
    }
    
}

//MARK: - ModelSelectViewDelegate
extension ModelSelectViewController: ModelSelectViewDelegate {
    func modelSelectView(_ view: ModelSelectView, closeButtonTapped button: UIButton) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            dismiss(animated: true)
        }
    }
    
    
}


