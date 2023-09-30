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
    func viewDidAppear()
    
    func numberOfItems(section: Int) -> Int
    func didSelectAssistantCategoryCellInHeader(assistantCategoryCellIndexPath: IndexPath)
 
    func updateCollectionViewAccordingToSubscribe()
}

final class AssistantsViewModel {
    
    //MARK: - References
    weak var view: AssistantsViewInterface?
    private let assistantsService: AssistantsService
    
    //MARK: - Variables
    let reachability = try! Reachability()
    
    var isInternetConnectionLost: Bool = false
    
    var assistantTags: [(originalAssistantTag: AssistantTag, translatedAssistantTag: String)] = [] {
        didSet {
            view?.reloadTags()
        }
    }
    
    var assistantsCollectionSectionData: [AssistantsCollectionSectionData] = [
        .init(sectionType: .assistants, assistants: [])
    ]
    
    var selectedAssistantCategoryCellIndexPath: IndexPath = .init(item: 0, section: 0) {
        didSet {
            if !(selectedAssistantCategoryCellIndexPath == oldValue) {
                if let tag = assistantTags[selectedAssistantCategoryCellIndexPath.item].originalAssistantTag.name {
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
                        
                        let dispatchQueue = DispatchQueue(label: "translateTags", qos: .userInteractive, attributes: .concurrent)
                        let dispatchGroup = DispatchGroup()
                        
                        var assistantTagTuple: [(originalAssistantTag: AssistantTag, translatedAssistantTag: String)] = []
                        
                        assistantTags.forEach { originalAssistantTag in
                            dispatchGroup.enter()
                            dispatchQueue.async {
                                LanguageManager.translate(text: originalAssistantTag.name ?? "") { translatedText in
                                    assistantTagTuple.append((originalAssistantTag, translatedText))
                                    dispatchGroup.leave()
                                }
                            }
                        }
                        
                        dispatchGroup.notify(queue: dispatchQueue) { [weak self] in
                            guard let self else { return }
                            self.assistantTags = assistantTagTuple
                            
                            view?.fetchedTags()
                            if let tag = assistantTagTuple[selectedAssistantCategoryCellIndexPath.item].originalAssistantTag.name {
                                fetchPromptsList(for: tag)
                            }
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
                        if let assistantsIndex = assistantsCollectionSectionData.firstIndex(where: { $0.sectionType == .assistants }){
                            
                            var assistantTuple: [(Assistant, TranslatedAssistant)] = []
                            
                            let dispatchQueue = DispatchQueue(label: "translateAssistantTitle", qos: .userInteractive, attributes: .concurrent)
                            let dispatchGroup = DispatchGroup()
                            
                            assistants.forEach { originalAssistant in
                            
                                dispatchGroup.enter()
                                dispatchQueue.async {
                                    LanguageManager.translate(text: originalAssistant.title ?? "") { translatedText in
                                        let assistantTag = self.assistantTags[self.selectedAssistantCategoryCellIndexPath.item].translatedAssistantTag
                                        
                                        let translatedAssistant = TranslatedAssistant(title: translatedText, tag: assistantTag)
                                        assistantTuple.append((originalAssistant, translatedAssistant))
                                        
                                        dispatchGroup.leave()
                                    }
                                }
                            }
                            
                            dispatchGroup.notify(queue: dispatchQueue) { [weak self] in
                                guard let self else { return }
                                
                                assistantsCollectionSectionData[assistantsIndex].assistants = assistantTuple
                                view?.reloadAssistants()
                                view?.fetchedAssistants()
                            }
                        }
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
    
    func viewDidAppear() {
        updateCollectionViewAccordingToSubscribe()
    }
    
    func numberOfItems(section: Int) -> Int {
        assistantsCollectionSectionData[section].assistants.count
    }
    
    func didSelectAssistantCategoryCellInHeader(assistantCategoryCellIndexPath: IndexPath) {
        self.selectedAssistantCategoryCellIndexPath = assistantCategoryCellIndexPath
    }
    
    func updateCollectionViewAccordingToSubscribe() {
        if !RevenueCatManager.shared.isSubscribe {
            if !assistantsCollectionSectionData.contains(where: { $0.sectionType == .subscribe }) {
                // add section
                
                
                view?.insertSection(at: 0)
            }
            
            view?.updateSubsribeCellFreeMessageCountLabel()
            
        } else {
            if let subscribeSectionIndexToDelete = assistantsCollectionSectionData.firstIndex(where: { $0.sectionType == .subscribe }) {
                assistantsCollectionSectionData.remove(at: subscribeSectionIndexToDelete)
                
                // collectionviewdan sectionu sil
                view?.deleteSection(at: 0)
            }
        }
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
