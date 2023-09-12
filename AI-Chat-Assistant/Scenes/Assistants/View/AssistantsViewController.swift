//
//  AssistantsViewController.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 12.09.2023.
//

import UIKit

protocol AssistantsViewInterface: AnyObject {
    func configureViewController()
}

final class AssistantsViewController: UIViewController {
    
    //MARK: - References
    weak var assistantsCoordinator: AssistantsCoordinator?
    private let assistantsView = AssistantsView()
    private let viewModel: AssistantsViewModel
    
    //MARK: - Life Cycle Methods
    init(viewModel: AssistantsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = assistantsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    //MARK: - Setup Delegates
    private func setupDelegates() {
        assistantsView.assistantsCategoryTableView.delegate = self
        assistantsView.assistantsCategoryTableView.dataSource = self
    }
    
}

//MARK: - Configure TableView
extension AssistantsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        ""
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        20
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        .init()
    }
    
    
}

//MARK: - AssistantsViewInterface
extension AssistantsViewController: AssistantsViewInterface {
    func configureViewController() {
        setupDelegates()
    }
    
    
}
