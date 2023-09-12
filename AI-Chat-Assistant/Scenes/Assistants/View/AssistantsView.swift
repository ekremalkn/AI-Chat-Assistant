//
//  AssistantsView.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 12.09.2023.
//

import UIKit

final class AssistantsView: UIView {

    //MARK: - Creating UI Elements
    lazy var assistantsCategoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(AssistantsCategoryTableCell.self, forCellReuseIdentifier: AssistantsCategoryTableCell.identifier)
        return tableView
    }()
    
    

}
