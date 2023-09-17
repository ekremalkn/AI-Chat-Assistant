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
}

final class ChatViewModel {
    
    //MARK: - References
    weak var view: ChatViewInterface?
    private let openAIChatService: OpenAIChatService
    
    //MARK: - Variables
    var currentModel: GPTModel = .gpt3_5Turbo {
        didSet {
            view?.configureModelSelectButton(with: currentModel)
        }
    }
    var uiMessages: [UIMessage] = [] {
        didSet {
            view?.reloadMessages()
        }
    }
    
    var currentInputText: String = ""
    
    //MARK: - Init Methods
    init(openAIChatService: OpenAIChatService) {
        self.openAIChatService = openAIChatService
    }
    
    private func sendMessage() {
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
                    //remove cell
                } else {
                    view?.didOccurErrorWhileResponsing("Assistant Confused")
                    print("No recieved Message from assistant")
                }
                
                print(openAIChatResponse?.choices?[0].message?.role as Any)
                print(openAIChatResponse?.choices?[0].message?.content as Any)
            case .failure(let failure):
                uiMessages.removeLast(2)
                view?.didOccurErrorWhileResponsing(failure.localizedDescription)
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
//        lastUserText = currentInputText
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
    
    
    
}
