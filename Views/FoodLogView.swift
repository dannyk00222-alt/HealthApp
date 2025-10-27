//
//  FoodLogView.swift
//  HealthApp
//
//  Created by admin on 10/26/25.
//

import Foundation
import SwiftUI
import Combine

struct FoodLogView: View {
    @EnvironmentObject var foodStore: FoodStore
    @State private var showingAdd = false

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Сьогодні")) {
                    ForEach(foodStore.entries.filter { Calendar.current.isDateInToday($0.date) }) { entry in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(entry.name).bold()
                                if let notes = entry.notes { Text(notes).font(.caption) }
                            }
                            Spacer()
                            Text("\(entry.calories) kcal")
                        }
                    }
                    .onDelete(perform: foodStore.remove)
                }

                Section(header: Text("Інші")) {
                    ForEach(foodStore.entries.filter { !Calendar.current.isDateInToday($0.date) }) { entry in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(entry.name).bold()
                                Text(entry.date, style: .date).font(.caption)
                            }
                            Spacer()
                            Text("\(entry.calories) kcal")
                        }
                    }
                    .onDelete(perform: foodStore.remove)
                }
            }
            #if os(iOS)
            .listStyle(InsetGroupedListStyle())
            #else
            .listStyle(InsetListStyle())
            #endif
            .navigationTitle("Журнал їжі")
            .toolbar {
                Button(action: { showingAdd = true }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAdd) {
                AddFoodView(isPresented: $showingAdd)
            }
        }
    }
}
