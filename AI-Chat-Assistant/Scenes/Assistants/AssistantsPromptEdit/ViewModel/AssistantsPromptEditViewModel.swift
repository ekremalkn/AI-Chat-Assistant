//
//  AssistantsPromptEditViewModel.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 16.09.2023.
//

import Foundation

protocol AssistantsPromptEditViewModelInterface {
    var view: AssistantsPromptEditViewInterface? { get set }
    
    func viewDidLoad()
    
    func promptTextDidChange(newPromptText: String)
}

final class AssistantsPromptEditViewModel {
    
    //MARK: - References
    weak var view: AssistantsPromptEditViewInterface?
    
    //MARK: - References
    var assistant: Assistant
    var promptIsEditing: Bool = false
    
    //MARK: - Init Methods
    init(assistant: Assistant) {
        self.assistant = assistant
    }
    
}

//MARK: - AssistantsPromptEditViewModelInterface
extension AssistantsPromptEditViewModel: AssistantsPromptEditViewModelInterface {
    func viewDidLoad() {
        view?.configureViewController()
    }
    
    func promptTextDidChange(newPromptText: String) {
        assistant.prompt = newPromptText
    }
}

