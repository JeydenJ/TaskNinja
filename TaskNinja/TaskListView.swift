//
//  TaskListView.swift
//  TaskNinja
//
//  Created by Jeyden Johnson on 14/9/2023.
//

import SwiftUI

struct TaskListView: View {
    @Binding var tasks: [Task]
    @State private var selectedTask: Task?
    @State private var isEditing = false
    @State private var isTaskSelected = false
    @State private var isDeleteAlertPresented = false

    var body: some View {
        NavigationView {
            List(selection: $selectedTask) {
                ForEach(tasks) { task in
                    Text(task.name)
                        .tag(task)
                        .onTapGesture {
                            isTaskSelected = true
                        }
                }
                .onDelete(perform: deleteTask)
            }
            .navigationTitle("Task List")
            .navigationBarItems(
                leading: Button(action: {
                    isDeleteAlertPresented = true
                }) {
                    Text("Delete")
                },
                trailing: EditButton()
                    .onTapGesture {
                        isEditing.toggle()
                        if isTaskSelected {
                            isTaskSelected.toggle()
                            selectedTask = nil
                        }
                    }
            )
            .alert(isPresented: $isDeleteAlertPresented) {
                Alert(
                    title: Text("Delete Task"),
                    message: Text("Are you sure you want to delete this task?"),
                    primaryButton: .destructive(Text("Delete")) {
                        if let selectedTask = selectedTask {
                            tasks.removeAll { $0.id == selectedTask.id }
                            self.selectedTask = nil
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
            .sheet(isPresented: $isTaskSelected) {
                if isEditing {
                    EditTaskView(task: $selectedTask)
                } else if let taskToDisplay = selectedTask {
                    TaskDetailView(task: taskToDisplay)
                }
            }            .environment(\.editMode, .constant(isEditing ? EditMode.active : EditMode.inactive))
        }
    }

    private func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        selectedTask = nil
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        let emptyTasks: [Task] = []

        return TaskListView(tasks: .constant(emptyTasks))
    }
}


