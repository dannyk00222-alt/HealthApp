//
//  Settings store.swift
//  HealthApp
//
//  Created by admin on 10/26/25.
//

import Foundation
import Combine

final class SettingsStore: ObservableObject {
@Published var dailyCalorieGoal: Int = UserDefaults.standard.integer(forKey: "dailyCalorieGoal") {
didSet { UserDefaults.standard.set(dailyCalorieGoal, forKey: "dailyCalorieGoal") }
}

init() {
if dailyCalorieGoal == 0 { dailyCalorieGoal = 2000 }
}
}
