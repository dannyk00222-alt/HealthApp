//
//  Pedometer Manager.swift
//  HealthApp
//
//  Created by admin on 10/26/25.
//

import Foundation
import Combine
import CoreMotion


final class PedometerManager: ObservableObject {
private let pedometer = CMPedometer()
@Published var stepsToday: Int = 0
@Published var distanceToday: Double = 0.0 // meters
@Published var isAvailable: Bool = CMPedometer.isStepCountingAvailable()

init() {
startUpdates()
queryToday()
}

func startUpdates() {
guard CMPedometer.isStepCountingAvailable() else { return }
pedometer.startUpdates(from: Calendar.current.startOfDay(for: Date())) { [weak self] data, error in
DispatchQueue.main.async {
if let d = data {
self?.stepsToday = d.numberOfSteps.intValue
if let dist = d.distance?.doubleValue { self?.distanceToday = dist }
} else if let err = error {
print("Pedometer error: \(err)")
}
}
}
}

func queryToday() {
guard CMPedometer.isStepCountingAvailable() else { return }
let start = Calendar.current.startOfDay(for: Date())
pedometer.queryPedometerData(from: start, to: Date()) { [weak self] data, error in
DispatchQueue.main.async {
if let d = data {
self?.stepsToday = d.numberOfSteps.intValue
if let dist = d.distance?.doubleValue { self?.distanceToday = dist }
} else if let err = error {
print("Query error: \(err)")
}
}
}
}
}
