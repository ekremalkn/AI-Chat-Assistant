//
//  ChatHistoryViewModel.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 18.09.2023.
//

import Foundation

protocol ChatHistoryViewModelInterface {
    var view: ChatHistoryViewInterface? { get set }
    
    func viewDidLoad()
}

final class ChatHistoryViewModel {
    
    //MARK: - References
    weak var view: ChatHistoryViewInterface?
    
    
    
}

extension ChatHistoryViewModel: ChatHistoryViewModelInterface {
    func viewDidLoad() {
        view?.configureViewController()
    }
    
}
