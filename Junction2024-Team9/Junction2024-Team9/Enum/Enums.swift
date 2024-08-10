//
//  Enums.swift
//  Junction2024-Team9
//
//  Created by 박현수 on 8/10/24.
//

import Foundation

enum ProblemCategory: String, CaseIterable {
    case pothole = "Pothole"
    case crack = "Crack"
    case trash = "Trash"
    case banner = "Banner"
    case vehicle = "Vehicle"
}

enum HistorySelection: String, CaseIterable {
    case period = "기간"
    case associatedInfo = "관련 정보들"
    case status = "상태"
}
