//
//  AssistantsCollectionSectionData.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 27.09.2023.
//

import Foundation

struct AssistantsCollectionSectionData {
    var sectionType: AssistantsCollectionSectionType
    var assistants: [(originalAssistant: Assistant, translatedAssitant: TranslatedAssistant)]
}

struct TranslatedAssistant {
    var title: String?
    var tag: String?
}

enum AssistantsCollectionSectionType {
    case subscribe
    case assistants
}
