//
//  ContentView.swift
//  TaskNinja
//
//  Created by Jeyden Johnson on 14/9/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var userName = ""
    @State private var isNameEntered = false
    
    var body: some View {
        if isNameEntered {
            MainView(userName: userName)
        } else {
            VStack {
                Image(systemName: "person.fill")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Welcome to TaskNinja!")
                Text("Please enter your name:")
                
                TextField("Name", text: $userName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    isNameEntered = true
                }) {
                    Text("Proceed")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

struct MainView: View {
    var userName: String
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("TaskNinja")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)
                
                Text("Hello, \(userName)!")
                    .font(.title)
                    .padding(.top)
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
