//
//  HomeView.swift
//  merchant
//
//  Created by adam on 2025/7/29.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var model = HomeModel()
    @State private var path: [String] = []
    @EnvironmentObject var store: AppStore
    @ObservedObject var userSession = UserSession.shared
    
    let account: String
    var body: some View {
        VStack {
            Text("歡迎, \(account)!")
                .font(.largeTitle)
                .padding()
            
            Text("您已成功登入")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding()
            Button(action: {
                model.send(intent: .loadAnnouncements)
            }) {
                Text("公告")
                    .frame(width: 100, height: 50)
            }
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            if model.state == .loading {
                HStack {
                    ProgressView()
                        .scaleEffect(0.8)
                    Text("載入中...")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            // 錯誤訊息
            if let error = model.announcementError {
                Text("錯誤: \(error)")
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.horizontal)
            }
            
            // 公告列表
            if !model.announcements.isEmpty {
                Text("公告列表")
                    .font(.headline)
                    .padding(.horizontal)
                
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(model.announcements.indices, id: \.self) { index in
                            let announcement = model.announcements[index]
                            AnnouncementRow(announcement: announcement)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true) // 隱藏返回按鈕
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("登出") {
                    model.send(intent: .logoutClicked)
                }
                .foregroundColor(.blue)
            }
        }
        .onChange(of: userSession.isLoggedIn) {
            if !(userSession.isLoggedIn) {
                store.pop()
            }
        }
        .onChange(of: model.state) { old, newState in
            if case .error(let msg) = newState {
                model.announcementError = msg
            }
            if case .success(let data) = newState {
                model.announcements = data
            }
        }
    }
}

struct AnnouncementRow: View {
    let announcement: AnnoModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(announcement.title)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(announcement.body)
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    HomeView(account: "")
}
