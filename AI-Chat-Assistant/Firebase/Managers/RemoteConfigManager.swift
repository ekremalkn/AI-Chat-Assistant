//
//  RemoteConfigManager.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 11.11.2023.
//

import Foundation
import FirebaseRemoteConfig

final class RemoteConfigManager {
    static let shared = RemoteConfigManager()
    
    //MARK: - References
    private let remoteConfig = RemoteConfig.remoteConfig()
    
    private init() {
        configureRemoteConfig()
    }
    
    //MARK: - Configure Remote Config
    private func configureRemoteConfig() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
    }
    
    func fetchAndActiveValues(completion: @escaping (Bool) -> Void) {
        remoteConfig.fetch { [weak self] (status, error) -> Void in
            guard let self else { return }
            
            if status == .success {
                print("Config fetched!")
                remoteConfig.activate { status, error in
                    guard error == nil else { return }
                    
                    if let remoteJSONData = self.remoteConfig.configValue(forKey: "aeKey").jsonValue as? [String : Any] {
                        if let aeKey = remoteJSONData["aeKey"] as? String {
                            NetworkConstants.openAIapiKey = aeKey
                        }
                        

                    }
                    
                    completion(true)
                }
                
            } else {
                print("Config not fetched")
                print("Error: \(error?.localizedDescription ?? "No error available.")")
                completion(false)
            }
        }
    }
}

