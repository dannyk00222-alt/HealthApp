//
//  HealthKit Manager.swift
//  HealthApp
//
//  Created by admin on 10/26/25.
//

import Foundation
import Combine
import HealthKit

final class HealthKitManager: ObservableObject {
private let store = HKHealthStore()
@Published var authorized = false

var energyType: HKQuantityType? { HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) }
var stepsType: HKQuantityType? { HKObjectType.quantityType(forIdentifier: .stepCount) }

func requestAuthorization(completion: @escaping (Bool) -> Void = { _ in }) {
guard HKHealthStore.isHealthDataAvailable(), let energy = energyType, let steps = stepsType else {
completion(false); return
}
let toShare: Set = [energy]
let toRead: Set = [energy, steps]
store.requestAuthorization(toShare: toShare, read: toRead) { success, error in
DispatchQueue.main.async {
self.authorized = success
if let e = error { print("HealthKit auth error: \(e)") }
completion(success)
}
}
}

func fetchActiveEnergyToday(completion: @escaping (Double) -> Void) {
guard authorized, let quantityType = energyType else { completion(0); return }
let start = Calendar.current.startOfDay(for: Date())
let predicate = HKQuery.predicateForSamples(withStart: start, end: Date(), options: .strictStartDate)
let query = HKStatisticsQuery(quantityType: quantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, statistics, _ in
var value = 0.0
if let sum = statistics?.sumQuantity() {
value = sum.doubleValue(for: HKUnit.kilocalorie())
}
DispatchQueue.main.async { completion(value) }
}
store.execute(query)
}

func fetchStepsToday(completion: @escaping (Double) -> Void) {
guard authorized, let quantityType = stepsType else { completion(0); return }
let start = Calendar.current.startOfDay(for: Date())
let predicate = HKQuery.predicateForSamples(withStart: start, end: Date(), options: .strictStartDate)
let query = HKStatisticsQuery(quantityType: quantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, statistics, _ in
var value = 0.0
if let sum = statistics?.sumQuantity() {
value = sum.doubleValue(for: HKUnit.count())
}
DispatchQueue.main.async { completion(value) }
}
store.execute(query)
}
}
