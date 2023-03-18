//
//  HapticManager.swift
//  CryptoApp
//
//  Created by Mustafa Girgin on 17.03.2023.
//

import Foundation
import SwiftUI

class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    static func notification(notificationType: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(notificationType)
    }
}
