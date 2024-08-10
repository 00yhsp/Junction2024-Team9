//
//  CaptureView.swift
//  Junction2024-Team9
//
//  Created by 박현수 on 8/10/24.
//

import AVKit
import UIKit
import Vision
import CoreImage

final class CaptureView: UIViewController {
    private var captureSession: AVCaptureSession?
    private var request: VNCoreMLRequest?
    private var drawingBoxesView: DrawingBoxesView?
    
    // 캡처 시간 간격을 조절하기 위한 변수
    private var lastCaptureTime: Date = Date(timeIntervalSince1970: 0)
    private let captureInterval: TimeInterval = 5.0
    
    // 감지 횟수
    private var lastDetectedObject: VNRecognizedObjectObservation?
    private var detectionCount: Int = 0
    private let maxDetectionCount: Int = 10

    private var bufferImage: UIImage?
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
        setupRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBoxesView()
        DispatchQueue.global().async {
            self.captureSession?.startRunning()
        }
    }
    
    // MARK: Functions
    
    private func setupRequest() {
        let configuration = MLModelConfiguration()
        
        guard let model = try? RoadDamage(configuration: configuration).model, let visionModel = try? VNCoreMLModel(for: model) else {
            return
        }
        
        request = VNCoreMLRequest(model: visionModel, completionHandler: visionRequestDidComplete)
        request?.imageCropAndScaleOption = .centerCrop
    }
    
    private func visionRequestDidComplete(request: VNRequest, error: Error?) {
        if let prediction = (request.results as? [VNRecognizedObjectObservation])?.first {
            DispatchQueue.main.async {
                self.drawingBoxesView?.drawBox(with: [prediction])
                
                // 현재 감지된 객체가 이전에 감지된 객체와 동일한지 확인
                if let lastObject = self.lastDetectedObject, lastObject.labels.first?.identifier == prediction.labels.first?.identifier {
                    self.detectionCount += 1
                } else {
                    self.detectionCount = 1
                }
                
                // 마지막 감지된 객체 업데이트
                self.lastDetectedObject = prediction
                
                //                 감지 횟수가 최대 값을 초과하면 세션 중지
                if self.detectionCount >= self.maxDetectionCount {
                    print("Detected same object 5 times. Stopping session.")
                    self.captureSession?.stopRunning()
                    
                    self.captureScreenshot()
                }
            }
        }
    }
    
    
    private func setupCaptureSession() {
        let session = AVCaptureSession()
        
        session.beginConfiguration()
        session.sessionPreset = .hd1280x720
        
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back), let input = try? AVCaptureDeviceInput(device: device) else {
            print("Couldn't create video input")
            return
        }
        
        session.addInput(input)
        
        let preview = AVCaptureVideoPreviewLayer(session: session)
        preview.frame = view.frame
        
        view.layer.addSublayer(preview)
        
        let queue = DispatchQueue(label: "videoQueue", qos: .userInteractive)
        
        let output = AVCaptureVideoDataOutput()
        output.setSampleBufferDelegate(self, queue: queue)
        
        if session.canAddOutput(output) {
            session.addOutput(output)
            
            output.connection(with: .video)?.videoRotationAngle = 90
            session.commitConfiguration()
            
            captureSession = session
        } else {
            print("Couldn't add video output")
        }
    }
    
    // 화면 캡쳐 및 갤러리에 저장 기능
    private func captureScreenshot() {
        guard let uiImage = self.bufferImage else {
            print("이미지 nil")
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil)
        }
        print("Screenshot captured and saved to gallery!")
    }
    
    
    private func setupBoxesView() {
        let drawingBoxesView = DrawingBoxesView()
        drawingBoxesView.frame = view.frame
        
        view.addSubview(drawingBoxesView)
        self.drawingBoxesView = drawingBoxesView
    }
}

// MARK: - Video Delegate

extension CaptureView: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer), let request = request else {
            return
        }
        
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer)
        try? handler.perform([request])
        
        self.bufferImage = pixelBufferToUIImage(pixelBuffer: pixelBuffer)
    }
    
    
    func pixelBufferToUIImage(pixelBuffer: CVPixelBuffer) -> UIImage? {
        // 1. CVPixelBuffer를 CIImage로 변환
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        
        // 2. CIContext를 사용하여 CIImage를 CGImage로 렌더링
        let context = CIContext(options: nil)
        if let cgImage = context.createCGImage(ciImage, from: ciImage.extent) {
            
            // 3. CGImage를 UIImage로 변환
            let uiImage = UIImage(cgImage: cgImage)
            return uiImage
        }
        
        return nil
    }
}
