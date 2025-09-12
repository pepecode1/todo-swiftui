//
//  swiftui_todoTests.swift
//  swiftui-todoTests
//
//  Created by Pepe Ruiz on 09/09/25.
//
import XCTest
@testable import swiftui_todo
/// Tests.
final class swiftui_todoTests: XCTestCase {
    /// Administrador de temas.
    var themeManager: ThemeManager!
    /// ViewModel para tareas.
    var taskViewModel: TaskViewModel!
    /// Mock service.
    var mockTaskService: TaskServiceMock!
    /// Configurar.
    override func setUp() {
        super.setUp()
        themeManager = ThemeManager()
        mockTaskService = TaskServiceMock()
        taskViewModel = TaskViewModel()
    }
    /// Finalizar.
    override func tearDown() {
        themeManager = nil
        taskViewModel = nil
        mockTaskService = nil
        super.tearDown()
    }
    // MARK: - Pruebas para ThemeManager.
    func testThemeManagerInitialization() {
        // Given: Un tema guardado en UserDefaults
        UserDefaults.standard.set("green", forKey: "selectedTheme")
        
        // When: Se inicializa ThemeManager
        let themeManager = ThemeManager()
        
        // Then: El tema inicial debe ser el guardado
        XCTAssertEqual(themeManager.currentTheme, .green)
    }
    func testThemeManagerChangeTheme() {
        // Given: Un ThemeManager inicializado
        // When: Cambiamos el tema a rojo
        themeManager.currentTheme = .red
        
        // Then: El tema debe ser rojo y guardado en UserDefaults
        XCTAssertEqual(themeManager.currentTheme, .red)
        XCTAssertEqual(UserDefaults.standard.string(forKey: "selectedTheme"), "red")
    }
    func testThemeManagerInvalidThemeInitialization() {
        // Given: Un tema inválido en UserDefaults
        UserDefaults.standard.set("invalid", forKey: "selectedTheme")
        
        // When: Se inicializa ThemeManager
        let themeManager = ThemeManager()
        
        // Then: El tema debe ser el predeterminado (.blue)
        XCTAssertEqual(themeManager.currentTheme, .blue)
    }
    func testThemeManagerColors() {
        // Given: Diferentes temas
        let themes: [AppTheme] = [.blue, .green, .red]
        
        // When: Probamos los colores de cada tema
        for theme in themes {
            themeManager.currentTheme = theme
            
            // Then: Los colores deben coincidir con el tema
            switch theme {
            case .blue:
                XCTAssertEqual(themeManager.currentTheme.primaryColor, .blue)
                XCTAssertEqual(themeManager.currentTheme.backgroundColor, .blue.opacity(0.1))
                XCTAssertEqual(themeManager.currentTheme.textColor, .black)
            case .green:
                XCTAssertEqual(themeManager.currentTheme.primaryColor, .green)
                XCTAssertEqual(themeManager.currentTheme.backgroundColor, .green.opacity(0.1))
                XCTAssertEqual(themeManager.currentTheme.textColor, .black)
            case .red:
                XCTAssertEqual(themeManager.currentTheme.primaryColor, .red)
                XCTAssertEqual(themeManager.currentTheme.backgroundColor, .red.opacity(0.1))
                XCTAssertEqual(themeManager.currentTheme.textColor, .white)
            }
        }
    }
    // MARK: - Pruebas para TaskViewModel
    func testTaskViewModelLoadTasksSuccess() {
        // Given: Tareas simuladas en el mock
        let task1 = Task(id: 1, title: "Tarea 1", userId: 1, completed: false)
        let task2 = Task(id: 2, title: "Tarea 2", userId: 1, completed: true)
        mockTaskService.tasksToReturn = [task1, task2]
        
        // When: Cargamos las tareas
        let expectation = XCTestExpectation(description: "Cargar tareas")
        taskViewModel.loadTasks()
        
        // Then: Las tareas deben cargarse correctamente
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.taskViewModel.tasks.count, 2)
            XCTAssertEqual(self.taskViewModel.tasks[0].title, "Tarea 1")
            XCTAssertEqual(self.taskViewModel.tasks[1].title, "Tarea 2")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    func testTaskViewModelLoadTasksFailure() {
        // Given: El mock devuelve un error
        mockTaskService.shouldThrowError = true
        
        // When: Intentamos cargar las tareas
        let expectation = XCTestExpectation(description: "Error al cargar tareas")
        taskViewModel.loadTasks()
        
        // Then: No se deben cargar tareas
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.taskViewModel.tasks.isEmpty)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
    }
    func testTaskViewModelAddTask() {
        // Given: Una tarea para añadir
        let newTask = Task(id: 0, title: "Nueva tarea", userId: 1, completed: false)
        
        // When: Añadimos la tarea
        let expectation = XCTestExpectation(description: "Añadir tarea")
        taskViewModel.addTask(newTask)
        
        // Then: La tarea debe añadirse al mock
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNotNil(self.mockTaskService.addedTask)
            XCTAssertEqual(self.mockTaskService.addedTask?.title, "Nueva tarea")
            XCTAssertEqual(self.taskViewModel.tasks.count, 1)
            XCTAssertEqual(self.taskViewModel.tasks[0].title, "Nueva tarea")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
}
