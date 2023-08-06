//
//  HomeChatViewModel.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.08.2023.
//

import Foundation

protocol HomeChatViewModelInterface {
    var view: HomeChatViewInterface? { get }
    func viewDidLoad()
    func sendMessage(messages: [UIMessage])
}

final class HomeChatViewModel {
    
    //MARK: - References
    var view: HomeChatViewInterface?
    private let openAIChatService: OpenAIChatService

    //MARK: - Init Methods
    init(openAIChatService: OpenAIChatService) {
        self.openAIChatService = openAIChatService
    }

    
}

//MARK: - HomeChatViewModelInterface
extension HomeChatViewModel: HomeChatViewModelInterface {
    func viewDidLoad() {
        view?.configureViewController()

    }
    
    func sendMessage(messages: [UIMessage]) {
        openAIChatService.sendMessage(messages: messages) { result in
            switch result {
            case .success(let openAIChatResponse):
                print(openAIChatResponse?.choices?[0].message?.role as Any)
                print(openAIChatResponse?.choices?[0].message?.content as Any)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    
}
