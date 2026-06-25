//
//  Items.swift
//  trailweight
//
//  Created by Adam on 2026-06-25.
//

import Foundation

struct Item : Codable, Identifiable {
    var id: String?
    var listId: String?
    var name: String
    var weight: Double?
    var category: String
    var notes: String?
    var createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case listId = "list_id"
        case name
        case weight
        case category
        case notes
        case createdAt = "created_at"
    }
    
}
