//
//  DatabaseService.swift
//  trailweight
//
//  Created by Adam on 2026-06-25.
//

import Foundation
import Supabase

private let supabase = SupabaseManager.shared.client

// MARK: - Gear Lists

/// Adds a new gear list to the database.
/// - Parameter name: The name of the gear list
/// - Parameter notes: Optional notes about the gear list
/// - Returns: The ID of the newly created gear list, or nil on failure
func addGearList(name: String, notes: String?) async -> String? {
    do {
        guard let userId = supabase.auth.currentUser?.id.uuidString else { return nil }

        let newList = GearList(
            userId: userId,
            name: name,
            notes: notes
        )

        let result: GearList = try await supabase
            .from("lists")
            .insert(newList)
            .select()
            .single()
            .execute()
            .value

        return result.id
    } catch {
        print("Error adding gear list: \(error)")
        return nil
    }
}

/// Fetches all gear lists for the current user.
/// - Returns: A list of gear lists, or empty list on failure
func fetchAllGearLists() async -> [GearList] {
    do {
        return try await supabase
            .from("lists")
            .select()
            .execute()
            .value
    } catch {
        print("Error fetching gear lists: \(error)")
        return []
    }
}

/// Fetches a gear list by its ID.
/// - Parameter listId: The ID of the gear list to fetch
/// - Returns: The gear list, or nil on failure
func getGearListById(_ listId: String) async -> GearList? {
    do {
        return try await supabase
            .from("lists")
            .select()
            .eq("id", value: listId)
            .single()
            .execute()
            .value
    } catch {
        print("Error fetching gear list: \(error)")
        return nil
    }
}

/// Fetches a gear list by its share ID.
/// - Parameter shareId: The share ID of the gear list to fetch
/// - Returns: The gear list, or nil on failure
func getGearListByShareId(_ shareId: String) async -> GearList? {
    do {
        return try await supabase
            .from("lists")
            .select()
            .eq("share_id", value: shareId)
            .single()
            .execute()
            .value
    } catch {
        print("Error fetching gear list by share ID: \(error)")
        return nil
    }
}

/// Updates a gear list by its ID.
/// - Parameter listId: The ID of the gear list to update
/// - Parameter updatedList: The updated gear list
/// - Returns: True on success, false on failure
func updateGearListById(_ listId: String, updatedList: GearList) async -> Bool {
    do {
        try await supabase
            .from("lists")
            .update(updatedList)
            .eq("id", value: listId)
            .execute()
        return true
    } catch {
        print("Error updating gear list: \(error)")
        return false
    }
}

/// Deletes a gear list by its ID.
/// - Parameter listId: The ID of the gear list to delete
/// - Returns: True on success, false on failure
func deleteGearListById(_ listId: String) async -> Bool {
    do {
        try await supabase
            .from("lists")
            .delete()
            .eq("id", value: listId)
            .execute()
        return true
    } catch {
        print("Error deleting gear list: \(error)")
        return false
    }
}

// MARK: - Items

/// Adds a new item to the database.
/// - Parameter item: The item to add
/// - Returns: True on success, false on failure
func addItem(_ item: Item) async -> Bool {
    do {
        try await supabase
            .from("items")
            .insert(item)
            .execute()
        return true
    } catch {
        print("Error adding item: \(error)")
        return false
    }
}

/// Fetches all items for a given gear list.
/// - Parameter listId: The ID of the gear list to fetch items for
/// - Returns: A list of items, or empty list on failure
func getItemsByListId(_ listId: String) async -> [Item] {
    do {
        return try await supabase
            .from("items")
            .select()
            .eq("list_id", value: listId)
            .execute()
            .value
    } catch {
        print("Error fetching items: \(error)")
        return []
    }
}

/// Updates an item by its ID.
/// - Parameter itemId: The ID of the item to update
/// - Parameter updatedItem: The updated item
/// - Returns: True on success, false on failure
func updateItemById(_ itemId: String, updatedItem: Item) async -> Bool {
    do {
        try await supabase
            .from("items")
            .update(updatedItem)
            .eq("id", value: itemId)
            .execute()
        return true
    } catch {
        print("Error updating item: \(error)")
        return false
    }
}

/// Deletes an item by its ID.
/// - Parameter itemId: The ID of the item to delete
/// - Returns: True on success, false on failure
func deleteItemById(_ itemId: String) async -> Bool {
    do {
        try await supabase
            .from("items")
            .delete()
            .eq("id", value: itemId)
            .execute()
        return true
    } catch {
        print("Error deleting item: \(error)")
        return false
    }
}
