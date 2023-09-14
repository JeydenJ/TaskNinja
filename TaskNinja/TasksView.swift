//
//  TasksView.swift
//  TaskNinja
//
//  Created by Jeyden Johnson on 14/9/2023.
//

import SwiftUI

struct TasksView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Task Management")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)
                
                Spacer()
                
                NavigationLink(destination: AddTaskView()) {
                    Text("Add Task")
                        .font(.headline)
                        .padding()
                }
                
                NavigationLink(destination: TaskListView()) {
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
