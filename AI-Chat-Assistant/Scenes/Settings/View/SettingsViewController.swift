//
//  SettingsViewController.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 22.09.2023.
//

import UIKit

final class SettingsViewController: UIViewController {

    //MARK: - References
    weak var settingsCoordinator: SettingsCoordinator?
    private let viewModel: SettingsViewModel

    //MARK: - Init Methods
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
