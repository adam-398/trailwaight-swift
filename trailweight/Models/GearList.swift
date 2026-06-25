//
//  GearList.swift
//  trailweight
//
//  Created by Adam on 2026-06-25.
//

import Foundation

struct GearList: Codable, Identifiable {
    var id: String?
    var userId: String
    var name: String
    var notes: String?
    var createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case name
        case notes
        case createdAt = "created_at"
    }
}
