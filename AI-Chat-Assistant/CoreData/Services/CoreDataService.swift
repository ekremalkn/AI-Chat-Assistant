//
//  CoreDataService.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 18.09.2023.
//

import Foundation

final class CoreDataService {
    
    //MARK: - Variables
    var viewContext = CoreDataManager.shared.viewContext
    
    //MARK: - Methods
    func save() {
        CoreDataManager.shared.saveContext()
    }

}
