//
//  FoodEntry.swift
//  HealthApp
//
//  Created by admin on 10/26/25.
//

import SwiftUI
import CoreMotion
import HealthKit

// MARK: - Models

struct FoodEntry: Identifiable, Codable {
let id: UUID
var name: String
var calories: Int
var date: Date
var notes: String?

init(id: UUID = UUID(), name: String, calories: Int, date: Date = Date(), notes: String? = nil) {
self.id = id
self.name = name
self.calories = calories
self.date = date
self.notes = notes
}
}
