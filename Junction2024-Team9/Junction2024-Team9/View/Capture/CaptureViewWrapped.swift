//
//  CaptureViewWrapped.swift
//  Junction2024-Team9
//
//  Created by LeeWanJae on 8/11/24.
//

import SwiftUI

struct CaptureViewWrapped: UIViewControllerRepresentable {
    @Binding var capturedImage: UIImage? // 외부로 이미지를 전달하기 위한 바인딩 변수

    func makeUIViewController(context: Context) -> some UIViewController {
        let cameraView = CameraView()
        cameraView.imageCaptured = { image in
            DispatchQueue.main.async {
                capturedImage = image
            }
        }
        return cameraView
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
       
    }
}
