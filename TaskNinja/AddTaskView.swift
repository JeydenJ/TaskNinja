//
//  AddTaskView.swift
//  TaskNinja
//
//  Created by Jeyden Johnson on 14/9/2023.
//

import SwiftUI

protocol TaskValidation {
    func validate(taskName: String) -> Bool
}
enum TaskType: String, CaseIterable {
    case work = "Work"
    case personal = "Personal"
}

struct AddTaskView: View {
    @Binding var tasks: [Task]
    @State private var taskName: String = ""
    @State private var taskDescription: String = ""
    @State private var dueDate = Date()
    @State private var selectedPriority: Priority = .medium
    @State private var selectedTaskType: TaskType = .work
    @State private var isShowingErrorAlert = false
    @State private var errorMessage = ""
    
    var body: some View {
        VStack {
            Text("Add Task")
                .font(.largeTitle)
                .bold()
                .padding()
            
            TextField("Task Name", text: $taskName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Task Description", text: $taskDescription)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            DatePicker("Due Date", selection: $dueDate, in: Date()...)
                .padding()
            
            Picker("Priority", selection: $selectedPriority) {
                Text("Low").tag(Priority.low)
                Text("Medium").tag(Priority.medium)
                Text("High").tag(Priority.high)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Picker("Task Type", selection: $selectedTaskType) {
                ForEach(TaskType.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Button(action: {
                if validateTask() {
                    // Create a new task and add it to the task list
                    let newTask = Task(
                        id: UUID(),
                        name: self.taskName,
                        description: self.taskDescription,
                        dueDate: self.dueDate,
                        priority: self.selectedPriority,
                        type: self.selectedTaskType
                    )
                    self.tasks.append(newTask)
                    self.taskName = ""
                    self.taskDescription = ""
                }
            }) {
                Text("Add Task")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            // Alert for displaying validation errors
            .alert(isPresented: $isShowingErrorAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            
            Spacer()
        }
        .padding()
    }
    // Function to validate task input
    private func validateTask() -> Bool {
        if taskName.isEmpty {
            errorMessage = "Task name cannot be empty."
            isShowingErrorAlert = true
            return false
        }
        return true
    }
}

struct AddTaskView_Previews: PreviewProvider {
    @State static var tasks: [Task] = []
    
    static var previews: some View {
        AddTaskView(tasks: $tasks)
    }
}

