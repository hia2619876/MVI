//
//  LoginView.swift
//  merchant
//
//  Created by adam on 2025/7/29.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var reducer = LoginReducer()
    @State private var showAlert = false
    @EnvironmentObject var store: AppStore
    @ObservedObject var userSession = UserSession.shared
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("請輸入帳號", text: Binding(
                get: { reducer.state.account },
                set: { reducer.send(.accountChanged($0)) }
            ))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .autocapitalization(.none)//不自動大寫
                .disableAutocorrection(true)//不自動修正

            Button(action: {
                reducer.send(.loginBtnPress)
            }) {
                Text("登入")
                    .frame(width: 100, height: 50)
            }
            .background(reducer.state.account.isEmpty ? Color.gray : Color.blue)
            .disabled(reducer.state.account.isEmpty)
            .foregroundColor(.white)
            .cornerRadius(10)
            .onChange(of: reducer.state.errorMessage) {
                showAlert = (reducer.state.errorMessage != "")
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("錯誤"),
                    message: Text(reducer.state.errorMessage),
                    dismissButton: .default(Text("好")){
                        reducer.send(.alertDismissed)
                    }
                )
            }
            .onAppear {
                if reducer.userSession.isLoggedIn() {
                    if userSession.isLoggedIn {
                        store.push(to: .home(account: userSession.account))
                    }
                }
            }
            .onChange(of: userSession.isLoggedIn) {
                if userSession.isLoggedIn {
                    store.push(to: .home(account: userSession.account))
                }
            }
        }
    }
    

}

#Preview {
    LoginView()
}
