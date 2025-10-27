//
//  DashboardView.swift
//  HealthApp
//
//  Created by admin on 10/26/25.
//

import Foundation
import SwiftUI
 import Combine

struct DashboardView: View {
    @EnvironmentObject var foodStore: FoodStore
    @EnvironmentObject var pedometer: PedometerManager
    @EnvironmentObject var hk: HealthKitManager
    @EnvironmentObject var settings: SettingsStore
    
    @State private var hkCalories: Double = 0
    @State private var hkSteps: Double = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                VStack(alignment: .leading) {
                    Text("Сьогодні").font(.title2).bold()
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Калорії (харчування)")
                            Text("\(foodStore.totalCalories()) kcal").font(.headline)
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("Ціль")
                            Text("\(settings.dailyCalorieGoal) kcal").font(.headline)
                        }
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).opacity(0.06))
                
                VStack(alignment: .leading) {
                    Text("Сгоріло (HealthKit)")
                    Text(String(format: "%.0f kcal", hkCalories)).font(.headline)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).opacity(0.06))
                
                VStack(alignment: .leading) {
                    Text("Кроки")
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Pedometer")
                            Text("\(pedometer.stepsToday) кроків").font(.headline)
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("HealthKit")
                            Text("\(Int(hkSteps)) кроків").font(.headline)
                        }
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).opacity(0.06))
                
                Spacer()
            }
            .padding()
            .navigationTitle("FitDiet")
            .toolbar { Button(action: refresh) { Image(systemName: "arrow.clockwise") } }
            .onAppear(perform: refresh)
        }
    }
    
    func refresh() {
            hk.fetchActiveEnergyToday { calories in
                hkCalories = calories
            }
            hk.fetchStepsToday { steps in
                hkSteps = steps
            }
            
            // За потреби можна додати оновлення pedometer чи іншої статистики
            pedometer.queryToday()
        }
}
