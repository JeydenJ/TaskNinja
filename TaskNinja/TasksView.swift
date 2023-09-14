//
//  TasksView.swift
//  TaskNinja
//
//  Created by Jeyden Johnson on 14/9/2023.
//

import SwiftUI

struct TasksView: View {
    @State private var tasks: [Task] = []
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Task Management")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)
                
                Spacer()
                
                NavigationLink(destination: AddTaskView(tasks: $tasks)) {
                    Text("Add Task")
                        .font(.headline)
                        .padding()
                }
                
                NavigationLink(destination: TaskListView(tasks: $tasks)) {
                    Text("View Tasks")
                        .font(.headline)
                        .padding()
                }
                
                Button(action: {
                }) {
                    Text("Edit Tasks")
                        .font(.headline)
                        .padding()
                }
                
                Button(action: {
                }) {
                    Text("Delete Tasks")
                        .font(.headline)
                        .padding()
                }
            }
            .padding()
            .navigationBarTitle("")
        }
    }
}
struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
