//
//  PastChatViewModel.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 20.09.2023.
//

import Foundation

protocol PastChatViewModelInterface {
    var view: PastChatViewInterface? { get set }
    
    func viewDidLoad()
    
    func numberOfMessages() -> Int
    
    func sendButtonTapped()
    func reGenerateButtonTapped()
    
    func deleteChatFromCoreData()
}

final class PastChatViewModel {
    
    //MARK: - References
    weak var view: PastChatViewInterface?
    private let openAIChatService: OpenAIChatService
    private let chatHistoryService: ChatHistoryService = CoreDataService()
    
    //MARK: - Variables
    let chatHistoryItem: ChatHistoryItem
    
    var uiMessages: [UIMessage] = []
    var currentModel: GPTModel = .gpt3_5Turbo
    
    var assistantAnswered: Bool?
    var currentInputText = ""
    
    //MARK: - Init Methods
    init(uiMessages: [UIMessage], chatHistoryItem: ChatHistoryItem, openAIChatService: OpenAIChatService) {
        self.openAIChatService = openAIChatService
        self.chatHistoryItem = chatHistoryItem
        self.uiMessages = uiMessages
    }
    
    
    //MARK: - Methods
    private func sendMessage() {
        assistantAnswered = false
        uiMessages.append(UIMessage(id: UUID(), role: .assistant, content: "", createAt: Date()))
        view?.reloadMessages()
        // add cell for waiting to response assistane
        openAIChatService.sendMessage(messages: uiMessages, model: currentModel) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let openAIChatResponse):
                if let asisstantContent = openAIChatResponse?.choices?.first?.message?.content {
                    let recievedMessage = UIMessage(id: UUID(), role: .assistant, content: asisstantContent, createAt: Date())
                    uiMessages.removeLast()
                    uiMessages.append(recievedMessage)
                    addChatMessageToCoreData(uiMessage: recievedMessage)
                    
                    view?.reloadMessages()
                    
                    view?.assistantResponsed()
                    assistantAnswered = true
                    //remove cell
                } else {
                    uiMessages.removeLast()
                    view?.reloadMessages()
                    view?.didOccurErrorWhileResponsing("Assistant Confused")
                    assistantAnswered = true
                    print("No recieved Message from assistant")
                }
            case .failure(let failure):
                uiMessages.removeLast(2)
                view?.reloadMessages()
                view?.didOccurErrorWhileResponsing(failure.localizedDescription)
                assistantAnswered = true
            }
        }
    }
    
    //MARK: - Add Chat Message to Core Data
    private func addChatMessageToCoreData(uiMessage: UIMessage) {
        chatHistoryService.addChatMessageToCoreData(chatHistoryItem: chatHistoryItem, uiMessage: uiMessage)
    }
    
    private func deleteChatMessageFromCoreData(uiMessage: UIMessage) {
        if let chatMessageItems = chatHistoryItem.chatMessages?.allObjects as? [ChatMessageItem] {
            if let chatMessageItemIndex = chatMessageItems.firstIndex(where: {$0.id == uiMessage.id}) {
                let chatMessageItemToDelete = chatMessageItems[chatMessageItemIndex]
                chatHistoryService.deleteChatMessageFromCoreData(chatHistoryItem: chatHistoryItem, chatMessageItem: chatMessageItemToDelete)
            }
        }

    }

}

//MARK: - PastChatViewModelInterface
extension PastChatViewModel: PastChatViewModelInterface {
    func viewDidLoad() {
        view?.configureViewController()
    }
    
    func numberOfMessages() -> Int {
        uiMessages.count
    }
    
    func sendButtonTapped() {
        let newMessage = UIMessage(id: UUID(), role: .user, content: currentInputText, createAt: Date())
        uiMessages.append(newMessage)
        chatHistoryService.addChatMessageToCoreData(chatHistoryItem: chatHistoryItem, uiMessage: newMessage)
        sendMessage()
        view?.resetTextViewMessageText()
    }
    
    func reGenerateButtonTapped() {
        if let lastMessage = uiMessages.last {
            if lastMessage.role == .assistant {
                uiMessages.removeLast()
                deleteChatMessageFromCoreData(uiMessage: lastMessage)
                sendMessage()
            }
        }

    }
    
    func deleteChatFromCoreData() {
        chatHistoryService.deleteChatHistoryItem(chatHistoryItem) { [weak self] isDeleted in
            guard let self else { return }
            if isDeleted {
                view?.chatSuccesfullyDeleted()
                view?.backToChatHistory()
            }
        }
    }
    
}
