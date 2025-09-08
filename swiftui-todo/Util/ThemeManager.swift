//
//  ThemeManager.swift
//  swiftui-todo
//
//  Created by Pepe Ruiz on 05/09/25.
//
import SwiftUI
/// Administrador de tareas.
class ThemeManager: ObservableObject {
    /// Tema de app.
    @AppStorage("selectedTheme") private var themeRawValue = AppTheme.blue.rawValue
    /// Tema seleccionado.
    @Published var currentTheme: AppTheme = .blue {
        didSet {
            themeRawValue = currentTheme.rawValue
        }
    }
    /// Inicializador.
    init() {
        if let theme = AppTheme(rawValue: themeRawValue) {
            currentTheme = theme
        }
    }
}
