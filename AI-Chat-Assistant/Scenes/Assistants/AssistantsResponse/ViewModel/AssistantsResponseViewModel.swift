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
    func saveChatToCoreData()
}

final class AssistantsResponseViewModel {
    
    //MARK: - References
    weak var view: AssistantsResponseViewInterface?
    private let openAIChatService: OpenAIChatService
    private let chatHistoryService: ChatHistoryCoreDataService = CoreDataService()
    
    //MARK: - Variables
    var currentModel: GPTModel = .gpt3_5Turbo
    let assistant: Assistant
    var uiMessages: [UIMessage] = []
    var mainMessages: [UIMessage] = []
    
    var assistantAnswered: Bool?
    
    var currentInputText: String = ""
    
    var currentMessageCount = 0 {
        didSet {
            if (currentMessageCount != 0 && currentMessageCount % 3 == 0) {
                if !RevenueCatManager.shared.isSubscribe {
                    view?.showAd()
                }
            } else if currentMessageCount % 5 == 0 {
                // check if review alert showed
                view?.showReviewAlert()
            }
        }
    }
    
    //MARK: - Init Methods
    init(mainMessages: [UIMessage], openAIChatService: OpenAIChatService, selectedGPTModel: GPTModel, assistant: Assistant) {
        self.mainMessages = mainMessages
        self.openAIChatService = openAIChatService
        self.currentModel = selectedGPTModel
        self.assistant = assistant
        if let assistantFirstResponse = mainMessages.last {
            self.uiMessages.append(assistantFirstResponse)
        }
    }
    
    //MARK: - Methods
    private func sendMessage() {
        
        switch MessageManager.shared.getUserMessageStatus() {
        case .noMessageLimit:
            view?.openPaywall()
        case .canSendMessage:
            assistantAnswered = false
            uiMessages.append(UIMessage(id: UUID(), role: .assistant, content: "", createAt: Date()))
            view?.reloadMessages()
            // add cell for waiting to response assistane
            openAIChatService.sendMessage(messages: mainMessages, model: currentModel) { [weak self] result in
                guard let self else { return }
                view?.scrollCollectionViewToBottom()
                switch result {
                case .success(let openAIChatResponse):
                    if let asisstantContent = openAIChatResponse?.choices?.first?.message?.content {
                        let recievedMessage = UIMessage(id: UUID(), role: .assistant, content: asisstantContent, createAt: Date())
                        uiMessages.removeLast()
                        uiMessages.append(recievedMessage)
                        
                        view?.reloadMessages()
                        mainMessages.append(recievedMessage)
                        
                        view?.assistantResponsed()
                        assistantAnswered = true
                        
                        MessageManager.shared.updateMessageLimit()
                        currentMessageCount += 1
                        view?.updateFreeMessageCountLabel()
                    } else {
                        uiMessages.removeLast()
                        mainMessages.removeLast()
                        view?.reloadMessages()
                        view?.didOccurErrorWhileResponsing("Assistant Confused".localized())
                        assistantAnswered = true
                        print("No recieved Message from assistant")
                    }
                case .failure(let failure):
                    uiMessages.removeLast(2)
                    view?.reloadMessages()
                    mainMessages.removeLast(2)
                    view?.didOccurErrorWhileResponsing(failure.localizedDescription)
                    assistantAnswered = true
                }
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
        switch MessageManager.shared.getUserMessageStatus() {
        case .noMessageLimit:
            view?.openPaywall()
        case .canSendMessage:
            let newMessage = UIMessage(id: UUID(), role: .user, content: currentInputText, createAt: Date())
            mainMessages.append(newMessage)
            uiMessages.append(newMessage)
            
            sendMessage()
            view?.resetTextViewMessageText()
            view?.scrollCollectionViewToBottom()
        }
    }
    
    func reGenerateButtonTapped() {
        switch MessageManager.shared.getUserMessageStatus() {
        case .noMessageLimit:
            view?.openPaywall()
        case .canSendMessage:
            if let lastMessageRole = uiMessages.last?.role {
                if lastMessageRole == .assistant {
                    uiMessages.removeLast()
                    mainMessages.removeLast()
                    sendMessage()
                }
            }
        }
    }
    
    func saveChatToCoreData() {
        if uiMessages.count >= 2 {
            let chatMessages = uiMessages.map { uiMessage in
                
                let chatMessageItem = ChatMessageItem(context: CoreDataManager.shared.viewContext)
                chatMessageItem.id = uiMessage.id
                chatMessageItem.createAt = uiMessage.createAt
                chatMessageItem.role = uiMessage.role.rawValue
                chatMessageItem.content = uiMessage.content
                
                return chatMessageItem
            }
            
            chatHistoryService.addChatHistoryToCoreData(chatCreationDate: Date(), chatTitleText: assistant.title?.localizedCapitalized ?? "Assistant", chatSubTitleText: "Assistant, \(assistant.tag ?? AppInfo.name)", gptModel: currentModel, chatMessages: chatMessages)
        }
    }
}

