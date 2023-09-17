//
//  AssistantsResponseViewModel.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 16.09.2023.
//

import Foundation

protocol AssistantsResponseViewModelInterface {
    var view: AssistantsResponseViewInterface? { get set }
    
    func viewDidLoad()
    
    func numberOfMessages() -> Int
    
    func sendButtonTapped()
    func reGenerateButtonTapped()
}

final class AssistantsResponseViewModel {
    
    //MARK: - References
    weak var view: AssistantsResponseViewInterface?
    private let openAIChatService: OpenAIChatService
    
    //MARK: - Variables
    var currentModel: GPTModel = .gpt3_5Turbo
    let assistant: Assistant
    var uiMessages: [UIMessage] = []
    var mainMessages: [UIMessage] = []
    
    var currentInputText: String = ""
    
    //MARK: - Init Methods
    init(mainMessages: [UIMessage], openAIChatService: OpenAIChatService, selectedGPTModel: GPTModel, assistant: Assistant) {
        self.mainMessages = uiMessages
        self.openAIChatService = openAIChatService
        self.currentModel = selectedGPTModel
        self.assistant = assistant
        if let assistantFirstResponse = mainMessages.last {
            self.uiMessages.append(assistantFirstResponse)
        }
    }
    
    //MARK: - Methods
    private func sendMessage() {
        
        uiMessages.append(UIMessage(id: UUID(), role: .assistant, content: "", createAt: Date()))
        view?.reloadMessages()
        // add cell for waiting to response assistane
        openAIChatService.sendMessage(messages: mainMessages, model: currentModel) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let openAIChatResponse):
                if let asisstantContent = openAIChatResponse?.choices?.first?.message?.content {
                    let recievedMessage = UIMessage(id: UUID(), role: .assistant, content: asisstantContent, createAt: Date())
                    uiMessages.removeLast()
                    uiMessages.append(recievedMessage)
                    
                    view?.reloadMessages()
                    mainMessages.append(recievedMessage)
                    
                    view?.assistantResponsed()
                    //remove cell
                } else {
                    uiMessages.removeLast()
                    mainMessages.removeLast()
                    view?.reloadMessages()
                    view?.didOccurErrorWhileResponsing("Assistant Confused")
                    print("No recieved Message from assistant")
                }
            case .failure(let failure):
                uiMessages.removeLast(2)
                view?.reloadMessages()
                mainMessages.removeLast(2)
                view?.didOccurErrorWhileResponsing(failure.localizedDescription)
            }
        }
    }
}

//MARK: - AssistantsResponseViewInterface
extension AssistantsResponseViewModel: AssistantsResponseViewModelInterface {
    func viewDidLoad() {
        view?.configureViewController()
    }
    
    func numberOfMessages() -> Int {
        uiMessages.count
    }
    
    func sendButtonTapped() {
        let newMessage = UIMessage(id: UUID(), role: .user, content: currentInputText, createAt: Date())
        mainMessages.append(newMessage)
        uiMessages.append(newMessage)
        
        sendMessage()
        view?.resetTextViewMessageText()
    }
    
    func reGenerateButtonTapped() {
        if let lastMessageRole = uiMessages.last?.role {
            if lastMessageRole == .assistant {
                uiMessages.removeLast()
                mainMessages.removeLast()
                sendMessage()
            }
        }
    }
    
    
}

