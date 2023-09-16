//
//  ContentView.swift
//  TaskNinja
//
//  Created by Jeyden Johnson on 14/9/2023.
//

import SwiftUI

protocol UserInputValidation {
    func validateInput() -> (isValid: Bool, errorMessage: String)
}

protocol AppExitConfirmation {
    var isAppExiting: Bool { get set }
    func confirmAppExit()
}

protocol ContentViewPresentable {
    var userName: String { get set }
}

protocol MainViewPresentable {
    func userNameText() -> String
}

struct ContentView: View, ContentViewPresentable, UserInputValidation {
    
    @State internal var userName = ""
    @State private var isNameEntered = false
    @State private var isErrorShowing = false
    @State private var errorMessage = ""
    private let characterLimit = 20
    
    var body: some View {
        // Show main view
        if isNameEntered {
            MainView(userName: $userName)
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
                    .onTapGesture {
                        
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                
                Button(action: {
                    let validationResult = validateInput()
                    if validationResult.isValid {
                        isNameEntered = true
                    } else {
                        errorMessage = validationResult.errorMessage
                        isErrorShowing = true
                    }
                }) {
                    Text("Proceed")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            // Error alert for displaying validation errors
            .alert(isPresented: $isErrorShowing) {
                Alert(
                    title: Text("Error"),
                    message: Text(errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    // Validates user input and returns validation result
    func validateInput() -> (isValid: Bool, errorMessage: String) {
        if userName.isEmpty {
            return (false, "Name cannot be empty.")
        } else if userName.count > characterLimit {
            return (false, "Name exceeds the character limit of \(characterLimit) characters.")
        }
        return (true, "")
    }
}

struct MainView: View, MainViewPresentable, AppExitConfirmation {
    @Binding var userName: String
    @State var isAppExiting = false
    private let exitAlertTitle = "Exit TaskNinja?"
    private let exitAlertMessage = "Are you sure you want to exit TaskNinja?"
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("TaskNinja")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)
                
                Text("Hello, \(userNameText())!")
                    .font(.title)
                    .padding(.top)
                
                Spacer()
                
                NavigationLink(destination: TasksView()) {
                    Text("Tasks")
                        .font(.headline)
                        .padding()
                }
                
                Button(action: {
                }) {
                    Text("Settings")
                        .font(.headline)
                        .padding()
                }
                
                Button(action: {
                    confirmAppExit()
                }) {
                    Text("Exit")
                        .font(.headline)
                        .padding()
                }
            }
            .padding()
            .navigationBarTitle("")
            .alert(isPresented: $isAppExiting) {
                Alert(
                    title: Text(exitAlertTitle),
                    message: Text(exitAlertMessage),
                    primaryButton: .destructive(Text("Exit")) {
                        exit(0)
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
    
    func userNameText() -> String {
        return userName
    }
    
    func confirmAppExit() {
        isAppExiting = true
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
