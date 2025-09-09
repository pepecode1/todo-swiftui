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
            Form {
                Section(header: Text("Tema de la App")) {
                    Picker("Color del Tema", selection: $themeManager.currentTheme) {
                        ForEach(AppTheme.allCases, id: \.self) { theme in
                            Text(theme.rawValue.capitalized)
                                .tag(theme)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.clear)
        }
        .navigationTitle("Configuración")
        .navigationViewStyle(.stack)
    }
}
