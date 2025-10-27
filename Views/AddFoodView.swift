//
//  AddFoodView.swift
//  HealthApp
//
//  Created by admin on 10/27/25.
//

import SwiftUI

struct AddFoodView: View {
    @EnvironmentObject var foodStore: FoodStore
    @Binding var isPresented: Bool

    @State private var name: String = ""
    @State private var calories: String = ""
    @State private var notes: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Продукт")) {
                    TextField("Назва", text: $name)

                    // ✅ TextField для чисел
                    TextField("Калорії (kcal)", text: $calories)
                         #if os(iOS)
                             .keyboardType(.numberPad)
                         #endif

                    TextField("Нотатки", text: $notes)
                }
            }
            .navigationTitle("Додати їжу")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Скасувати") { isPresented = false }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Зберегти") { save() }
                        .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty || Int(calories) == nil)
                }
            }
        }
    }

    func save() {
        guard let c = Int(calories) else { return }
        let entry = FoodEntry(name: name, calories: c, date: Date(), notes: notes.isEmpty ? nil : notes)
        foodStore.add(entry)
        isPresented = false
    }
}
