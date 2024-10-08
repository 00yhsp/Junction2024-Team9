//
//  CaptureView.swift
//  Junction2024-Team9
//
//  Created by LeeWanJae on 8/11/24.
//

import AVKit
import SwiftUI
import UIKit
import Vision
import CoreImage

struct CaptureView: View {
    @State private var capturedImage: UIImage? = nil // 캡처된 이미지를 저장하는 상태 변수

    var body: some View {
        VStack {
            // CaptureViewWrapped를 사용하여 이미지 캡처
            CaptureViewWrapped(capturedImage: $capturedImage)

            // 이미지가 캡처되면 다른 뷰로 네비게이션
            if capturedImage != nil {
                NavigationLink(destination: AnalyzeView(image: $capturedImage)) {
                    Text("Move to AnalyzeView")
                }
            } else {
                Text("Detecting...")
            }
        }
    }
}
