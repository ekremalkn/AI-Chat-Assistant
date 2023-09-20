//
//  ChatViewModel.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.08.2023.
//

import Foundation

protocol ChatViewModelInterface {
    var view: ChatViewInterface? { get }
    func viewDidLoad()
    
    func numberOfMessages() -> Int
    
    func sendButtonTapped()
    func reGenerateButtonTapped()
    
    func saveChatToCoreData()
    
    func createNewChat()
    func clearChat()
    func deleteChat()
}

final class ChatViewModel {
    
    //MARK: - References
    weak var view: ChatViewInterface?
    private let openAIChatService: OpenAIChatService
    private let chatHistoryService: ChatHistoryService = CoreDataService()
    
    //MARK: - Variables
    var currentModel: GPTModel = .gpt3_5Turbo {
        didSet {
            view?.configureModelSelectButton(with: currentModel)
        }
    }
    
    var chatCollectionType: ChatCollectionType = .empty
    
    var uiMessages: [UIMessage] = [] {
        didSet {
            if uiMessages.isEmpty {
                chatCollectionType = .empty
            } else {
                chatCollectionType = .notEmpty
            }
            
            view?.reloadMessages()
        }
    }
    
    var assistantAnswered: Bool?
    
    var currentInputText: String = ""
    
    //MARK: - Init Methods
    init(openAIChatService: OpenAIChatService) {
        self.openAIChatService = openAIChatService
    }
    
    private func sendMessage() {
        assistantAnswered = false
        view?.assistantResponsing()
        uiMessages.append(UIMessage(id: UUID(), role: .assistant, content: "", createAt: Date()))
        // add cell for waiting to response assistane
        openAIChatService.sendMessage(messages: uiMessages, model: currentModel) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let openAIChatResponse):
                if let asisstantContent = openAIChatResponse?.choices?.first?.message?.content {
                    let recievedMessage = UIMessage(id: UUID(), role: .assistant, content: asisstantContent, createAt: Date())
                    uiMessages.removeLast()
                    uiMessages.append(recievedMessage)
                    view?.assistantResponsed()
                    assistantAnswered = true
                    //remove cell
                } else {
                    view?.didOccurErrorWhileResponsing("Assistant Confused")
                    assistantAnswered = true
                    print("No recieved Message from assistant")
                }
                
                print(openAIChatResponse?.choices?[0].message?.role as Any)
                print(openAIChatResponse?.choices?[0].message?.content as Any)
            case .failure(let failure):
                uiMessages.removeLast(2)
                view?.didOccurErrorWhileResponsing(failure.localizedDescription)
                assistantAnswered = true
                print(failure.localizedDescription)
            }
        }
    }
    
}

//MARK: - ChatViewModelInterface
extension ChatViewModel: ChatViewModelInterface {
    func viewDidLoad() {
        view?.configureViewController()
    }
    
    func numberOfMessages() -> Int {
        uiMessages.count
    }
    
    func sendButtonTapped() {
        let newMessage = UIMessage(id: UUID(), role: .user, content: currentInputText, createAt: Date())
        uiMessages.append(newMessage)
        sendMessage()
        view?.resetTextViewMessageText()
    }
    
    func reGenerateButtonTapped() {
        if let lastMessageRole = uiMessages.last?.role {
            if lastMessageRole == .assistant {
                uiMessages.removeLast()
                sendMessage()
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
            
            if let userFirstText = uiMessages.first?.content {
                chatHistoryService.addChatHistoryToCoreData(chatCreationDate: Date(), chatTitleText: userFirstText, chatSubTitleText: "Created home chat", chatMessages: chatMessages)
            }
        }
    }
    
    
    func createNewChat() {
        if !uiMessages.isEmpty {
            uiMessages = []
            view?.resetTextViewMessageText()
        }
    }
    
    func clearChat() {
        if !uiMessages.isEmpty {
            uiMessages = []
            view?.resetTextViewMessageText()
        }
    }

    func deleteChat() {
        if !uiMessages.isEmpty {
            uiMessages = []
            view?.resetTextViewMessageText()
        }
    }
    
}
