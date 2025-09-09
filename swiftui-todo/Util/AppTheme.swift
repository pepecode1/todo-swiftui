//
//  AppTheme.swift
//  swiftui-todo
//
//  Created by Pepe Ruiz on 05/09/25.
//
import SwiftUI
/// Enumerador de temas.
enum AppTheme: String, CaseIterable {
    case blue
    case green
    case red
    /// Color primario.
    var primaryColor: Color {
        switch self {
        case .blue:
            return .blue
        case .green:
            return .green
        case .red:
            return .red
        }
    }
    /// Color background.
    var backgroundColor: Color {
        switch self {
        case .blue:
            return .blue.opacity(0.1)
        case .green:
            return .green.opacity(0.1)
        case .red:
            return .red.opacity(0.1)
        }
    }
    /// Color de texto.
    var textColor: Color {
        switch self {
        case .blue, .green:
            return .black
        case .red:
            return .white
        }
    }
}
