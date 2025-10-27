//
//  ActivityView.swift
//  HealthApp
//
//  Created by admin on 10/27/25.
//

import Foundation
import SwiftUI
import Combine

struct ActivityView: View {
@EnvironmentObject var pedometer: PedometerManager
@EnvironmentObject var hk: HealthKitManager

@State private var hkSteps: Double = 0

var body: some View {
NavigationView {
VStack(spacing: 16) {
HStack {
VStack(alignment: .leading) {
Text("Pedometer")
Text("\(pedometer.stepsToday) кроків").font(.title2)
Text(String(format: "%.0f м", pedometer.distanceToday)).font(.caption)
}
Spacer()
}
.padding()
.background(RoundedRectangle(cornerRadius: 12).opacity(0.06))

VStack(alignment: .leading) {
Text("HealthKit steps")
Text("\(Int(hkSteps)) кроків").font(.title2)
}
.padding()
.background(RoundedRectangle(cornerRadius: 12).opacity(0.06))

Spacer()
}
.padding()
.navigationTitle("Активність")
.toolbar { Button(action: refresh) { Image(systemName: "arrow.clockwise") } }
.onAppear(perform: refresh)
}
}

func refresh() {
hk.fetchStepsToday { val in hkSteps = val }
pedometer.queryToday()
}
}
