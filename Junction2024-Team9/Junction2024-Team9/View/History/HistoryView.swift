//
//  HistoryView.swift
//  Junction2024-Team9
//
//  Created by 박현수 on 8/10/24.
//

import SwiftUI

struct ReportModel: Hashable {
    var status: ReportStatus
    var category: ProblemCategory
    var date: String
}
enum ReportStatus: CaseIterable {
    case rejected, notYet, approved
}

struct HistoryView: View {
    @State private var selection: HistorySelection = .period
    
    @State private var reportList: [ReportModel] = [
        ReportModel(status: .approved, category: .pothole, date: "2024-08-01"),
        ReportModel(status: .notYet, category: .crack, date: "2024-08-02"),
        ReportModel(status: .rejected, category: .trash, date: "2024-08-03"),
        ReportModel(status: .approved, category: .banner, date: "2024-08-04"),
        ReportModel(status: .notYet, category: .vehicle, date: "2024-08-05"),
        ReportModel(status: .rejected, category: .pothole, date: "2024-08-06"),
        ReportModel(status: .approved, category: .crack, date: "2024-08-07"),
        ReportModel(status: .notYet, category: .trash, date: "2024-08-08"),
        ReportModel(status: .approved, category: .banner, date: "2024-08-09"),
        ReportModel(status: .rejected, category: .vehicle, date: "2024-08-10"),
        ReportModel(status: .approved, category: .pothole, date: "2024-08-01"),
        ReportModel(status: .notYet, category: .crack, date: "2024-08-02"),
        ReportModel(status: .rejected, category: .trash, date: "2024-08-03"),
        ReportModel(status: .approved, category: .banner, date: "2024-08-04"),
        ReportModel(status: .notYet, category: .vehicle, date: "2024-08-05"),
        ReportModel(status: .rejected, category: .pothole, date: "2024-08-06"),
        ReportModel(status: .approved, category: .crack, date: "2024-08-07"),
        ReportModel(status: .notYet, category: .trash, date: "2024-08-08"),
        ReportModel(status: .approved, category: .banner, date: "2024-08-09"),
        ReportModel(status: .rejected, category: .vehicle, date: "2024-08-10"),
        
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            List(reportList, id: \.self) { report in
                NavigationLink {
                    AnalyzeView(image: .constant(UIImage(named: "photo")))
                } label: {
                    HStack {
                        reportStatusView(category: report.status)
                        Text(report.category.rawValue.uppercased())
                        Spacer()
                        Text(report.date)
                            .foregroundColor(Color(red: 0.92, green: 0.92, blue: 0.96).opacity(0.6))
                    }
                    
                }
            }
            Group {
                Text("Status")
                HStack {
                    ForEach(ReportStatus.allCases, id: \.self) { status in
                        HStack {
                            reportStatusView(category: status)
                            Text("\(getStatusTitle(category: status))")
                        }
                        .padding(.trailing, 5)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 3)
                
            
            Spacer()
        }
    }
    @ViewBuilder
    func reportStatusView(category: ReportStatus) -> some View {
        switch category {
        case .rejected:
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(Color(red: 1, green: 0.15, blue: 0.15))
        case .notYet:
            Image(systemName: "clock.fill")
                .foregroundStyle(Color(red: 1, green: 0.75, blue: 0.09))
        case .approved:
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(Color(red: 0.22, green: 0.88, blue: 0.29))
        }
    }
    
    func getStatusTitle(category: ReportStatus) -> String {
        switch category {
        case .rejected:
            return "Rejected"
        case .notYet:
            return "Not yet"
        case .approved:
            return "Approved"
        }
    }
}

#Preview {
    HistoryView()
}
