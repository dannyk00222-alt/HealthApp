//
//  FoodStore.swift
//  HealthApp
//
//  Created by admin on 10/26/25.
//
import Foundation
import SwiftUI
import Combine

final class FoodStore: ObservableObject {
@Published var entries: [FoodEntry] = [] {
didSet { save() }
}

private let key = "FitDietFoodEntries_v1"

init() {
load()
}

func add(_ entry: FoodEntry) {
entries.append(entry)
}

func remove(at offsets: IndexSet) {
entries.remove(atOffsets: offsets)
}

func totalCalories(for date: Date = Date()) -> Int {
let cal = entries.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
.reduce(0) { $0 + $1.calories }
return cal
}

private func save() {
do {
let data = try JSONEncoder().encode(entries)
UserDefaults.standard.set(data, forKey: key)
} catch {
print("Save error: \(error)")
}
}

private func load() {
guard let data = UserDefaults.standard.data(forKey: key) else { return }
do {
entries = try JSONDecoder().decode([FoodEntry].self, from: data)
} catch {
print("Load error: \(error)")
}
}
}
