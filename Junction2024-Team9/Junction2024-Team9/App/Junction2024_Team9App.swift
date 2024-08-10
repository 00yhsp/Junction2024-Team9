//
//  Junction2024_Team9App.swift
//  Junction2024-Team9
//
//  Created by 박현수 on 8/10/24.
//

import SwiftUI

@main
struct Junction2024_Team9App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var locationHelper = LocationHelper.shared
    
    var body: some Scene {

        WindowGroup {
            NavigationStack {
                HomeView()
            }
        }
        .environmentObject(locationHelper)
    }
}
