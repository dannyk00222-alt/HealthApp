//
//  SettingsView.swift
//  HealthApp
//
//  Created by admin on 10/27/25.
//

import Foundation
import SwiftUI
import Combine

struct SettingsView: View {
@EnvironmentObject var settings: SettingsStore
@EnvironmentObject var hk: HealthKitManager

@State private var goalText: String = ""
@State private var showingAbout = false

var body: some View {
NavigationView {
Form {
Section(header: Text("Ціль калорій")) {
TextField("Калорій на день", value: $settings.dailyCalorieGoal, formatter: NumberFormatter())
    #if(IOS)
        .keyboardType(.numberPad)
    #endif
}

Section(header: Text("HealthKit")) {
HStack {
Text("Дозвіл HealthKit")
Spacer()
if hk.authorized { Image(systemName: "checkmark.seal.fill") } else { Button("Запитати") { hk.requestAuthorization() } }
}
}

Section { Button("Про додаток") { showingAbout = true } }
}
.navigationTitle("Налаштування")
.sheet(isPresented: $showingAbout) { AboutView() }
}
}
}

struct AboutView: View {
@Environment(\.presentationMode) var presentation
var body: some View {
NavigationView {
VStack(alignment: .leading, spacing: 12) {
Text("FitDiet") .font(.title)
Text("Простий трекер харчування, калорій і ходьби. Використовує CoreMotion та HealthKit (за наявності).")
Spacer()
}
.padding()
.navigationTitle("Про")
.toolbar { Button("Готово") { presentation.wrappedValue.dismiss() } }
}
}
}

