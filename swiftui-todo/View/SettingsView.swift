//
//  SettingsView.swift
//  swiftui-todo
//
//  Created by Pepe Ruiz on 05/09/25.
//
import SwiftUI
/// Vista de ajustes.
struct SettingsView: View {
    /// Administrador de temas.
    @EnvironmentObject private var themeManager: ThemeManager
    /// Vista principal.
    var body: some View {
        ZStack {
            themeManager.currentTheme.backgroundColor
                .ignoresSafeArea()
            NavigationView {
                VStack {
                    Picker("Tema", selection: $themeManager.currentTheme) {
                        Text("Azul").tag(AppTheme.blue)
                        Text("Verde").tag(AppTheme.green)
                        Text("Rojo").tag(AppTheme.red)
                    }
                    .pickerStyle(WheelPickerStyle())
                    .accessibilityIdentifier("themePicker")
                    .accessibilityLabel("Selector de temas")
                    .frame(height: 100) // Asegurar que sea visible
                    Spacer()
                }
                .navigationTitle("Configuración")
            }
            .navigationViewStyle(.stack)
        }
    }
}
