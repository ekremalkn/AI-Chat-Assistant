//
//  ModelSelectViewModel.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 27.08.2023.
//

import Foundation

protocol ModelSelectViewModelInterface {
    var view: ModelSelectViewInterface? { get set }
    
    func viewDidLoad()
    
    func numberOfItems() -> Int
    func didSelectModel(at indexPath: IndexPath)
}

final class ModelSelectViewModel {
    
    //MARK: - References
    weak var view: ModelSelectViewInterface?

    //MARK: - Variables
    var selectedModelIndex: Int = 0
    
    var models: [GPTModel] = [
        .gpt3_5Turbo,
        .gpt4
        ]
 
    //MARK: - Init Methods
    init(model: GPTModel) {
        setSelectedModelIndexOnce(with: model)
    }
    
    private func setSelectedModelIndexOnce(with model: GPTModel) {
        if let openedModelIndex = models.firstIndex(where: { $0 == model}) {
            selectedModelIndex = openedModelIndex
        }
    }

}

extension ModelSelectViewModel: ModelSelectViewModelInterface {
    func viewDidLoad() {
        view?.configureViewController()
    }
    
    func didSelectModel(at indexPath: IndexPath) {
        let selectedModel = models[indexPath.item]
        selectedModelIndex = indexPath.item
        view?.reloadModelSelection()
        view?.didSelectModel(model: selectedModel)
    }
    
    func numberOfItems() -> Int {
        models.count
    }
    
    
}
