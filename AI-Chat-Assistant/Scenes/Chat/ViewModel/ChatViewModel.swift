//
//  ChatViewModel.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.08.2023.
//

import Foundation
import Reachability

protocol ChatViewModelInterface {
    var view: ChatViewInterface? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    
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
    private let chatHistoryService: ChatHistoryCoreDataService = CoreDataService()
    
    //MARK: - Variables
    let reachability = try! Reachability()
    
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
        switch MessageManager.shared.getUserMessageStatus() {
        case .noMessageLimit:
            view?.openPaywall()
        case .canSendMessage:
            assistantAnswered = false
            view?.assistantResponsing()
            uiMessages.append(UIMessage(id: UUID(), role: .assistant, content: "", createAt: Date()))
            // add cell for waiting to response assistane
            openAIChatService.sendMessage(messages: uiMessages, model: currentModel) { [weak self] result in
                guard let self else { return }
                view?.scrollCollectionViewToBottom()
                switch result {
                case .success(let openAIChatResponse):
                    if let asisstantContent = openAIChatResponse?.choices?.first?.message?.content {
                        let recievedMessage = UIMessage(id: UUID(), role: .assistant, content: asisstantContent, createAt: Date())
                        uiMessages.removeLast()
                        uiMessages.append(recievedMessage)
                        
                        
                        view?.assistantResponsed()
                        assistantAnswered = true
                        
                        MessageManager.shared.updateMessageLimit()
                        currentMessageCount += 1
                        view?.updateFreeMessageCountLabel()
                        
                    } else {
                        view?.didOccurErrorWhileResponsing("Assistant Confused")
                        assistantAnswered = true
                        uiMessages.removeLast(2)
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
}

//MARK: - ChatViewModelInterface
extension ChatViewModel: ChatViewModelInterface {
    func viewWillAppear() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
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
            
            if let userFirstText = uiMessages.first?.content {
                chatHistoryService.addChatHistoryToCoreData(chatCreationDate: Date(), chatTitleText: userFirstText, chatSubTitleText: "Created home chat", gptModel: currentModel, chatMessages: chatMessages)
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

//MARK: - Reachability Methods
extension ChatViewModel {
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
            view?.deleteNoInternetView()
        case .cellular:
            print("Reachable via Cellular")
            view?.deleteNoInternetView()
        case .unavailable:
            print("Network not reachable")
            view?.showNoInternetView()
        }
    }
}
