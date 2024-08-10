//
//  AppRouter.swift
//  Junction2024-Team9
//
//  Created by 박현수 on 8/10/24.
//

import SwiftUI

enum AppRoute: Hashable {
    case captureView
    case analyzeView
    case historyView
    case informationView
}

final class AppRouter: ObservableObject {

    @Published var path: [AppRoute] = .init()

    func push(to route: AppRoute) {
        path.append(route)
    }

    func pop() {
        path.removeLast()
    }

    func goHome() {
        path.removeAll()
    }

    func deepPush(routes: [AppRoute]) {
        for route in routes {
            path.append(route)
        }
    }

    @ViewBuilder
    func navDestVB(to route: AppRoute) -> some View {
        switch route {
        case .captureView:
            CaptureView()
        case .analyzeView:
            AnalyzeView()
        case .historyView:
            HistoryView()
        case .informationView:
            InformationView()
        }
    }

}
