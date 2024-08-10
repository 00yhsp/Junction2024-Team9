//
//  HistoryView.swift
//  Junction2024-Team9
//
//  Created by 박현수 on 8/10/24.
//

import SwiftUI

struct HistoryView: View {
    @State private var selection: HistorySelection = .period
    var body: some View {
        VStack {
            Picker("", selection: $selection) {
                ForEach(HistorySelection.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }.pickerStyle(.segmented)
            Spacer()
        }
    }
}

#Preview {
    HistoryView()
}
