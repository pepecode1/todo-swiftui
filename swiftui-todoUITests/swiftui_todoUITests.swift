//
//  swiftui_todoUITests.swift
//  swiftui-todoUITests
//
//  Created by Pepe Ruiz on 11/09/25.
//
import XCTest
@testable import swiftui_todo
/// Tests.
final class swiftui_todoUITests: XCTestCase {
    /// Aplicación.
    var app: XCUIApplication!
    /// Inicializar.
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["UITesting"]
        app.launch()
    }
    /// Finalizar.
    override func tearDownWithError() throws {
        app = nil
    }
    // MARK: - Tests UI
    /// Carga las pestañas.
    func testLoadTasksTab() throws {
        // Given: La app se lanza
        // When: La pestaña de tareas está seleccionada por defecto
        let tasksTab = app.tabBars.buttons.element(boundBy: 0)
        print("Botones en la barra de pestañas: \(app.tabBars.buttons.allElementsBoundByIndex.map { $0.identifier })")
        XCTAssertTrue(tasksTab.waitForExistence(timeout: 5), "La pestaña de tareas debe existir")
        XCTAssertTrue(tasksTab.isSelected, "La pestaña de tareas debe estar seleccionada al iniciar")
        
        // Then: La barra de navegación de tareas debe mostrarse
        let navigationBar = app.navigationBars["Tareas"]
        XCTAssertTrue(navigationBar.waitForExistence(timeout: 5), "La barra de navegación de tareas debe mostrarse")
        // Esperar a que la tarea task_1 se renderice
        let predicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: app.staticTexts["task_1"])
        let result = XCTWaiter().wait(for: [expectation], timeout: 20) // Timeout de 20 segundos
        if result == .completed {
            print("Tarea task_1 renderizada")
        } else {
            print("Tarea task_1 no renderizada a tiempo")
        }
        // Then: Verificar si la lista se muestra a través de una celda
        let taskCell = app.staticTexts["task_1"]
        XCTAssertTrue(taskCell.waitForExistence(timeout: 5), "Debe haber al menos una tarea en la lista (task_1)")
    }
    /// Cambia el tema.
    func testChangeTheme() throws {
        let settingsTab = app.tabBars.buttons.element(boundBy: 1) // Segunda pestaña (Configuración)
        print("Botones en la barra de pestañas: \(app.tabBars.buttons.allElementsBoundByIndex.map { ($0.identifier, $0.label) })")
        XCTAssertTrue(settingsTab.waitForExistence(timeout: 5), "La pestaña de configuración debe existir")
        settingsTab.tap()
        
        // Then: La barra de navegación de configuración debe mostrarse
        let navigationBar = app.navigationBars.firstMatch
        XCTAssertTrue(navigationBar.waitForExistence(timeout: 5), "La barra de navegación de configuración debe mostrarse")
        print("Pickers: \(app.pickers.allElementsBoundByIndex.map { $0.identifier })")
        
        // Esperar al Picker de temas
        let themePicker = app.pickers["themePicker"]
        let predicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: themePicker)
        let result = XCTWaiter().wait(for: [expectation], timeout: 10) // Aumentar a 10 segundos
        if result == .completed {
            print("Picker de temas encontrado")
        } else {
            print("Picker de temas no encontrado a tiempo")
        }
        
        XCTAssertTrue(themePicker.waitForExistence(timeout: 5), "El Picker de temas debe existir")
        
        // When: Acceder a la rueda del Picker y ajustar el valor
        let pickerWheel = themePicker.pickerWheels.element // Acceder a la rueda interna
        let wheelPredicate = NSPredicate(format: "exists == true")
        let wheelExpectation = XCTNSPredicateExpectation(predicate: wheelPredicate, object: pickerWheel)
        let wheelResult = XCTWaiter().wait(for: [wheelExpectation], timeout: 5)
        if wheelResult == .completed {
            print("Rueda del Picker encontrada")
            pickerWheel.adjust(toPickerWheelValue: "Rojo") // Ajustar a "Rojo"
            print("Intentando ajustar la rueda a 'Rojo'")
        } else {
            print("Rueda del Picker no encontrada")
            print("Ruedas disponibles: \(app.pickerWheels.allElementsBoundByIndex.map { $0.identifier })")
        }
        // Then: Verificar que el cambio se refleje (puedes añadir una verificación visual si es necesario)
        XCTAssertTrue(navigationBar.exists, "La barra de navegación debe seguir mostrándose después del cambio")
    }
    /// Añade una tarea.
    func testAddTask() throws {
        // Given: Estamos en la pestaña de tareas
        let addTaskButton = app.buttons["addTaskButton"]
        XCTAssertTrue(addTaskButton.exists, "El botón de añadir tarea debe existir")
        
        // When: Tocamos el botón "Añadir"
        addTaskButton.tap()
        
        // Then: La vista para añadir tarea debe mostrarse
        let addTaskView = app.navigationBars["Nueva Tarea"]
        XCTAssertTrue(addTaskView.exists, "La vista de añadir tarea debe mostrarse")
        
        // When: Rellenamos los campos y guardamos
        let titleTextField = app.textFields["titleTextField"]
        let saveTaskButton = app.buttons["saveTaskButton"]
        
        titleTextField.tap()
        titleTextField.typeText("Nueva tarea de prueba")
        saveTaskButton.tap()
        
        // Then: Volvemos a la lista de tareas y verificamos que la tarea aparece
        XCTAssertTrue(app.staticTexts["Nueva tarea de prueba"].exists, "La nueva tarea debe aparecer en la lista")
    }
}
