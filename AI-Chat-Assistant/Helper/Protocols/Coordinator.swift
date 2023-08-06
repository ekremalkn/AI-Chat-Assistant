//
//  Coordinator.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 6.08.2023.
//

import Foundation

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    func start() 
}
