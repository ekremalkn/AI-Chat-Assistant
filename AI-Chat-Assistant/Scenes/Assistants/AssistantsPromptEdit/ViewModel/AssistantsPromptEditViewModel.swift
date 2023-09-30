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
    func submitButtonTapped()
}

final class AssistantsPromptEditViewModel {
    
    //MARK: - References
    weak var view: AssistantsPromptEditViewInterface?
    private let openAIChatService: OpenAIChatService
    
    //MARK: - Variables
    var originalAssistant: Assistant
    var updatedAssistant: Assistant?
    var translatedAssistant: TranslatedAssistant
    var promptIsEditing: Bool = false
    var gptModels: [GPTModel] = GPTModel.allCases
    var currentModel: GPTModel = .gpt3_5Turbo
    
    //MARK: - Init Methods
    init(openAIChatService: OpenAIChatService, assistant: Assistant, translatedAssitant: TranslatedAssistant) {
        self.openAIChatService = openAIChatService
        self.translatedAssistant = translatedAssitant
        self.originalAssistant = assistant
    }
    
    func changeAssistantPrompt(assistant: Assistant) {
        LanguageManager.translate(text: assistant.prompt ?? "") { [weak self] translatedText in
            guard let self else { return }
            var newAssistant = assistant
            
            newAssistant.title = translatedAssistant.title
            newAssistant.prompt = translatedText
            newAssistant.tag = translatedAssistant.tag
            self.updatedAssistant = newAssistant
            
            view?.updateMessageTextViewText(translatedPrompt: translatedText)
        }
    }
}

//MARK: - AssistantsPromptEditViewModelInterface
extension AssistantsPromptEditViewModel: AssistantsPromptEditViewModelInterface {
    func viewDidLoad() {
        view?.configureViewController()
        changeAssistantPrompt(assistant: originalAssistant)
    }
    
    func promptTextDidChange(newPromptText: String) {
        updatedAssistant?.prompt = newPromptText
    }
    
    func submitButtonTapped() {
        
        switch MessageManager.shared.getUserMessageStatus() {
        case .noMessageLimit:
            view?.openPaywall()
        case .canSendMessage:
            var uiMessages: [UIMessage] = []
            
            if let prompt = updatedAssistant?.prompt {
                let message = UIMessage(id: UUID(), role: .user, content: prompt, createAt: Date())
                
                uiMessages.append(message)
            }
            
            view?.chatServiceResponding()
            openAIChatService.sendMessage(messages: uiMessages, model: currentModel) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let openAIChatResponse):
                    if let assistantContent = openAIChatResponse?.choices?.first?.message?.content {
                        let recievedMessage = UIMessage(id: UUID(), role: .assistant, content: assistantContent, createAt: Date())
                        uiMessages.append(recievedMessage)
                        
                        view?.chatServiceResponded()
                        
                        view?.openAssistantsResponseVC(with: uiMessages)
                        
                        MessageManager.shared.updateMessageLimit()
                        
                    } else {
                        view?.didOccurErrorWhileChatServiceResponding("Assistant Confused".localized())
                    }
                case .failure(let failure):
                    view?.didOccurErrorWhileChatServiceResponding(failure.localizedDescription)
                }
            }
        }
        
        
    }
    
}

