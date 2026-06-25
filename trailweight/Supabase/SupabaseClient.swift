//  SupabaseClient.swift
//  trailweight
//
//  Created by Adam on 2026-06-25.
//

import Foundation

import Supabase

class SupabaseManager {
    static let shared = SupabaseManager()

    let client = SupabaseClient(
        supabaseURL: URL(string: Bundle.main.object(forInfoDictionaryKey: "SUPABASE_URL") as! String)!,
        supabaseKey: Bundle.main.object(forInfoDictionaryKey: "SUPABASE_API_KEY") as! String
    )

    private init() {}
}
