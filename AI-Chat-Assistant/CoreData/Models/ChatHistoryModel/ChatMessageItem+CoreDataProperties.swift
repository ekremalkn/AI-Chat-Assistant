//
//  ChatMessageItem+CoreDataProperties.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 19.09.2023.
//
//

import Foundation
import CoreData


extension ChatMessageItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChatMessageItem> {
        return NSFetchRequest<ChatMessageItem>(entityName: "ChatMessageItem")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var role: String?
    @NSManaged public var content: String?
    @NSManaged public var createAt: Date?
    @NSManaged public var chatHistoryItem: ChatHistoryItem?

}

extension ChatMessageItem : Identifiable {

}
