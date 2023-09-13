//
//  AssistantsViewModel.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 12.09.2023.
//

import Foundation

protocol AssistantsViewModelInterface {
    var view: AssistantsViewInterface? { get set }
    
    func viewDidLoad()
    
    func numberOfItems() -> Int
    func getAssistants() -> [Assistant]
    func didSelectAssistantCategoryCellInHeader(assistantCategoryCellIndexPath: IndexPath)
    
}

final class AssistantsViewModel {
    
    //MARK: - References
    var view: AssistantsViewInterface?

    //MARK: - Variables
    var assistantsCollectionViewAssistants: [AssistantsModel] = [
        .init(assistantCategory: .sales, assistants: AssistantsProvider.salesAssistants),
        .init(assistantCategory: .general, assistants: []),
        .init(assistantCategory: .writing, assistants: []),
        .init(assistantCategory: .marketing, assistants: []),
        .init(assistantCategory: .socialMedia, assistants: []),
        .init(assistantCategory: .coding, assistants: []),
        .init(assistantCategory: .design, assistants: []),
        .init(assistantCategory: .language, assistants: []),
        .init(assistantCategory: .music, assistants: []),
        .init(assistantCategory: .teaching, assistants: []),
        .init(assistantCategory: .research, assistants: []),
        .init(assistantCategory: .speech, assistants: []),
        .init(assistantCategory: .business, assistants: []),
        .init(assistantCategory: .dataAnalysis, assistants: []),
        .init(assistantCategory: .email, assistants: []),
        .init(assistantCategory: .job, assistants: []),
        .init(assistantCategory: .reading, assistants: []),
        .init(assistantCategory: .paidAds, assistants: []),
        .init(assistantCategory: .finance, assistants: []),
        .init(assistantCategory: .health, assistants: []),
        .init(assistantCategory: .fun, assistants: []),
        .init(assistantCategory: .it, assistants: []),
    ]
    
    var selectedAssistantCategoryCellIndexPath: IndexPath = .init(item: 0, section: 0) {
        didSet {
            if !(selectedAssistantCategoryCellIndexPath == oldValue) {
                view?.reloadAssistants()
            }
        }
    }

}

//MARK: - AssistantsViewModelInterface
extension AssistantsViewModel: AssistantsViewModelInterface {
        func viewDidLoad() {
        view?.configureViewController()
    }
    
    func numberOfItems() -> Int {
        assistantsCollectionViewAssistants[selectedAssistantCategoryCellIndexPath.item].assistants.count
    }
    
    func getAssistants() -> [Assistant] {
        assistantsCollectionViewAssistants[selectedAssistantCategoryCellIndexPath.item].assistants
    }
    
    func didSelectAssistantCategoryCellInHeader(assistantCategoryCellIndexPath: IndexPath) {
        self.selectedAssistantCategoryCellIndexPath = assistantCategoryCellIndexPath
    }
    
}
