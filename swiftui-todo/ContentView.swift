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
        TabView {
            TaskListView()
                .tabItem {
                    Label("Tareas", systemImage: "list.bullet")
                }
            SettingsView()
                .tabItem {
                    Label("Configuración", systemImage: "gear")
                }
        }
        .accentColor(themeManager.currentTheme.primaryColor)
    }
}
/// Preview.
#Preview {
    ContentView()
}
