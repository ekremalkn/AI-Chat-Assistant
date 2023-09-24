//
//  PaywallViewController.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 24.09.2023.
//

import UIKit

final class PaywallViewController: UIViewController {

    //MARK: - References
    weak var paywallCoordinator: PaywallCoordinator?
    private let viewModel: PaywallViewModel
    private let paywallView = PaywallView()
    
    //MARK: - Life Cycle Methods
    init(viewModel: PaywallViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = paywallView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        paywallView.startTypeWriteAnimation()
    }
    

}
