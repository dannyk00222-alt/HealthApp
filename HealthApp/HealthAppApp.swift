//
//  HealthAppApp.swift
//  HealthApp
//
//  Created by admin on 10/26/25.
//

import SwiftUI
import CoreData

@main
struct FitDietApp: App {
@StateObject private var foodStore = FoodStore()
@StateObject private var pedometer = PedometerManager()
@StateObject private var hk = HealthKitManager()
@StateObject private var settings = SettingsStore()
 
    var body: some Scene {
        WindowGroup {
        ContentView()
        .environmentObject(foodStore)
        .environmentObject(pedometer)
        .environmentObject(hk)
        .environmentObject(settings)
         .onAppear {
        hk.requestAuthorization()
         }
       }
    }
}

