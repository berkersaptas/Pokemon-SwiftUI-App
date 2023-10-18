//
//  ErrorModel.swift
//  Pokemon-SwiftUI-App
//
//  Created by Berker Saptas on 8.10.2023.
//

import Foundation

// MARK: - ErrorModel
struct ErrorModel: Codable {
    let statusCode: Int?
    let statusType: String?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusType = "status_type"
        case message
    }
}
