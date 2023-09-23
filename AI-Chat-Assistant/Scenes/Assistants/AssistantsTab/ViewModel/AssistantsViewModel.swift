//
//  AssistantsViewModel.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 12.09.2023.
//

import Foundation
import Reachability

protocol AssistantsViewModelInterface {
    var view: AssistantsViewInterface? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    
    func numberOfItems() -> Int
    func didSelectAssistantCategoryCellInHeader(assistantCategoryCellIndexPath: IndexPath)
    
}

final class AssistantsViewModel {
    
    //MARK: - References
    weak var view: AssistantsViewInterface?
    private let assistantsService: AssistantsService
    
    //MARK: - Variables
    let reachability = try! Reachability()
    
    var isInternetConnectionLost: Bool = false
    
    var assistantTags: [AssistantTag] = [] {
        didSet {
            view?.reloadTags()
        }
    }
    var assistants: [Assistant] = [] {
        didSet {
            view?.reloadAssistants()
        }
    }
    
    var selectedAssistantCategoryCellIndexPath: IndexPath = .init(item: 0, section: 0) {
        didSet {
            if !(selectedAssistantCategoryCellIndexPath == oldValue) {
                if let tag = assistantTags[selectedAssistantCategoryCellIndexPath.item].name {
                    fetchPromptsList(for: tag)
                }
            }
        }
    }
    
    
    //MARK: - Init Methods
    init(assistantsService: AssistantsService) {
        self.assistantsService = assistantsService
    }
    
    //MARK: - Methods
    private func fetchAssistantTags() {
        view?.fetchingTags()
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self else { return }
            assistantsService.fetchAssistantTags { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let assistantModel):
                    if let assistantTags = assistantModel?.data {
                        self.assistantTags = assistantTags
                        
                        view?.fetchedTags()
                        if let tag = assistantTags[selectedAssistantCategoryCellIndexPath.item].name {
                            fetchPromptsList(for: tag)
                        }
                    }
                case .failure(let failure):
                    view?.didOccurWhileFetchingTags(errorMsg: failure.localizedDescription)
                }
            }
        }
    }
    
    func fetchPromptsList(for tag: String) {
        view?.fetchingAssistants()
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self else { return }
            assistantsService.fetchPromptsList(for: tag) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let assistantModel):
                    if let assistants = assistantModel?.data {
                        self.assistants = assistants
                        view?.fetchedAssistants()
                    }
                case .failure(let failure):
                    view?.didOccurWhileFetchingAssistants(errorMsg: failure.localizedDescription)
                }
            }
        }
    }
    
}

//MARK: - AssistantsViewModelInterface
extension AssistantsViewModel: AssistantsViewModelInterface {
    func viewDidLoad() {
        view?.configureViewController()
        fetchAssistantTags()
    }
    
    func viewWillAppear() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    func numberOfItems() -> Int {
        assistants.count
    }
    
    func didSelectAssistantCategoryCellInHeader(assistantCategoryCellIndexPath: IndexPath) {
        self.selectedAssistantCategoryCellIndexPath = assistantCategoryCellIndexPath
    }
    
}

//MARK: - Reachability Methods
extension AssistantsViewModel {
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
            view?.deleteNoInternetView()
            if isInternetConnectionLost {
                fetchAssistantTags()
                isInternetConnectionLost = false
            }
        case .cellular:
            print("Reachable via Cellular")
            view?.deleteNoInternetView()
            if isInternetConnectionLost {
                fetchAssistantTags()
                isInternetConnectionLost = false
            }
        case .unavailable:
            print("Network not reachable")
            view?.showNoInternetView()
            isInternetConnectionLost = true
        }
    }
}
