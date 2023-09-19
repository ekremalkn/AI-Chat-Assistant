//
//  ChatHistoryItem+CoreDataProperties.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 19.09.2023.
//
//

import Foundation
import CoreData


extension ChatHistoryItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChatHistoryItem> {
        return NSFetchRequest<ChatHistoryItem>(entityName: "ChatHistoryItem")
    }

    @NSManaged public var chatCreationDate: Date?
    @NSManaged public var chatSubTitleText: String?
    @NSManaged public var chatTitleText: String?
    @NSManaged public var chatMessages: NSSet?

}

// MARK: Generated accessors for chatMessages
extension ChatHistoryItem {

    @objc(addChatMessagesObject:)
    @NSManaged public func addToChatMessages(_ value: ChatMessageItem)

    @objc(removeChatMessagesObject:)
    @NSManaged public func removeFromChatMessages(_ value: ChatMessageItem)

    @objc(addChatMessages:)
    @NSManaged public func addToChatMessages(_ values: NSSet)

    @objc(removeChatMessages:)
    @NSManaged public func removeFromChatMessages(_ values: NSSet)

}

extension ChatHistoryItem : Identifiable {

}
