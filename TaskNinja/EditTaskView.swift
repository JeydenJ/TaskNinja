//
//  EditTaskView.swift
//  TaskNinja
//
//  Created by Jeyden Johnson on 15/9/2023.
//

import SwiftUI

struct EditTaskView: View {
    @Binding var task: Task?

    @State private var editedTask: Task
    
    init(task: Binding<Task?>) {
        _task = task
        _editedTask = State(initialValue: task.wrappedValue ?? Task(id: UUID(), name: "", description: "", dueDate: Date(), priority: .low))
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Task Name", text: $editedTask.name)
                    TextField("Description", text: $editedTask.description)
                    DatePicker("Due Date", selection: $editedTask.dueDate, displayedComponents: .date)
                    
                }
            }
            .navigationBarTitle("Edit Task")
            .navigationBarItems(trailing: Button("Save") {
                if let editedTask = self.task {
                    editedTask.name = self.editedTask.name
                    editedTask.description = self.editedTask.description
                    editedTask.dueDate = self.editedTask.dueDate
                    self.task = editedTask
                }
            })
        }
    }
}


struct EditTaskView_Previews: PreviewProvider {
    @State static var task: Task? = Task(id: UUID(), name: "Sample Task", description: "This is a sample task", dueDate: Date(), priority: .low)

    static var previews: some View {
        EditTaskView(task: $task)
    }
}
