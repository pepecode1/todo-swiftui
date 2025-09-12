//
//  ContentView.swift
//  swiftui-todo
//
//  Created by Pepe Ruiz on 05/09/25.
//
import SwiftUI
/// Vista padre.
struct ContentView: View {
    /// Administador de temas.
    @EnvironmentObject private var themeManager: ThemeManager
    /// Vista.
    var body: some View {
        ZStack {
            themeManager.currentTheme.backgroundColor
                .ignoresSafeArea()
            TabView {
                TaskListView()
                    .tabItem {
                        Label("Tareas", systemImage: "list.bullet")
                            .accessibilityIdentifier("tasksTab")
                            .accessibilityLabel("Pestaña de Tareas")
                    }
                SettingsView()
                    .tabItem {
                        Label("Configuración", systemImage: "gear")
                            .accessibilityIdentifier("settingsTab")
                            .accessibilityLabel("Pestaña de Configuración")
                    }
            }
        }
        .accentColor(themeManager.currentTheme.primaryColor)
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("tabView")
    }
}
/// Preview.
#Preview {
    ContentView()
}
