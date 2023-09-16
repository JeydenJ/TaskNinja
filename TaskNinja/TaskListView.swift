//
//  TaskListView.swift
//  TaskNinja
//
//  Created by Jeyden Johnson on 14/9/2023.
//

import SwiftUI

protocol TaskSelectionDelegate: AnyObject {
    func didSelectTask(_ task: Task)
    func didDeselectTask(_ task: Task)
}
class TaskListViewModel: ObservableObject, TaskSelectionDelegate {
    @Published var selectedTask: Task?
    
    func didSelectTask(_ task: Task) {
        selectedTask = task
    }
    
    func didDeselectTask(_ task: Task) {
        if selectedTask == task {
            selectedTask = nil
        }
    }
}
struct TaskListView: View {
    @Binding var tasks: [Task]
    @State private var selectedTask: Task?
    // States to control alert presentation
    @State private var isDeleteAlertPresented = false
    @State private var isTaskDetailPresented = false
    @State private var isFilterAlertPresented = false
    
    @State private var filterText = "All Tasks"
    
    
    var body: some View {
        NavigationView {
            VStack{
                Text(filterText) // Display the current filter text
                    .font(.headline)
                    .padding()
                
                List(selection: $selectedTask) {
                    ForEach(tasks) { task in
                        Text(task.name)
                            .tag(task)
                            .onTapGesture {
                                // Handle tapping a task
                                selectedTask = task
                                isTaskDetailPresented = true // Show task detail view
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
                    trailing: Button(action: {
                        isFilterAlertPresented = true
                    }) {
                        Text("Filter")
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
                .sheet(isPresented: $isTaskDetailPresented) {
                    if let taskToDisplay = selectedTask {
                        TaskDetailView(task: taskToDisplay)
                    }
                }
            }
        }
    }
    // Function to delete a task at the specified index
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


