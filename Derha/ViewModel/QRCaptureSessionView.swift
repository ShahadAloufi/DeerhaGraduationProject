//
//  QRCaptureSessionView.swift
//  Derha
//
//  Created by Rahaf Alhubeis on 11/12/1443 AH.
//

import UIKit
import SwiftUI
import AVFoundation
class QRCaptureSessionView: UIView {
  var captureSession: AVCaptureSession?
  var previewLayer: AVCaptureVideoPreviewLayer?
  var patchScan = true
  var shouldCapture = true
  var pauseTime = 1 //in seconds
  var scanBlock: ((_ codeString: String)->Void)?
  var failBlock: ((_ errorMessage: String)->Void)?
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    comminInit()
  }
  override func willMove(toSuperview newSuperview: UIView?) {
    if newSuperview == nil {
      stopCaptureSession()
    }
  }
  func comminInit() {
    addCaptureLayer()
  }
  override func layoutSubviews() {
    super.layoutSubviews()
    previewLayer?.frame = self.layer.bounds
  }
}
extension QRCaptureSessionView: AVCaptureMetadataOutputObjectsDelegate, AVCapturePhotoCaptureDelegate {
  func stopCaptureSession() {
    if captureSession?.isRunning == true {
      captureSession?.stopRunning()
    }
  }
  func addCaptureLayer() {
    guard let videoCaptureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
      failed("cannot_open_camera")
      return
    }
    captureSession = AVCaptureSession()
    guard let captureSession = self.captureSession else {
      failed("cannot_open_camera")
      return
    }
    let videoInput: AVCaptureDeviceInput
    do {
      videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
    } catch {
      failed("gathering_qr_camera_error")
      return
    }
    if captureSession.canAddInput(videoInput) {
      captureSession.addInput(videoInput)
    } else {
      failed("qr_scanning_not_support")
      return
    }
    let metadataOutput = AVCaptureMetadataOutput()
    if captureSession.canAddOutput(metadataOutput) {
      captureSession.addOutput(metadataOutput)
      metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
      metadataOutput.metadataObjectTypes = [ .upce, .qr, .ean8, .ean13]
    } else {
      failed("qr_scanning_not_support")
      return
    }
    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    guard let previewLayer = self.previewLayer else {
      failed("cannot_open_camera")
      return
    }
    previewLayer.frame = self.layer.bounds
    previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
    layer.addSublayer(previewLayer)
    captureSession.startRunning()
  }
  func metadataOutput(_ output: AVCaptureMetadataOutput,
            didOutput metadataObjects: [AVMetadataObject],
            from connection: AVCaptureConnection) {
    if shouldCapture == false {
      return
    }
    if patchScan == false {
      stopCaptureSession()
    }
    shouldCapture = false
    if let metadataObject = metadataObjects.first,
      let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
      let stringValue = readableObject.stringValue {
      let generator = UIImpactFeedbackGenerator(style: .heavy)
      generator.impactOccurred()
      scanBlock?(stringValue)
    } else {
      failed("could_not_get_metadata_for_code")
    }
    resumeScannerAfterDelay()
  }
  func failed(_ message: String) {
    failBlock?(message)
    resumeScannerAfterDelay()
  }
  func resumeScannerAfterDelay(){
    let when = DispatchTime.now() + DispatchTimeInterval.seconds(pauseTime)
    DispatchQueue.main.asyncAfter(deadline: when, execute: {
      if self.captureSession?.isRunning == true {
        self.shouldCapture = true
      }
    })
  }
}
//SwiftUI Codes
struct QRScannerView: UIViewRepresentable {
  @Binding var scannedCode: String
  @Binding var scanError: String
  func makeUIView(context: Context) -> QRCaptureSessionView {
    let qrView = QRCaptureSessionView()
    qrView.scanBlock = { codeString in
      scannedCode = codeString
    }
    qrView.failBlock = { errorMessage in
      print("errorMessage \(errorMessage)")
      scanError = errorMessage
    }
    return qrView
  }
  func updateUIView(_ uiView: QRCaptureSessionView, context: Context) {
  }
}
extension Binding {
  /// Execute block when value is changed.
  ///
  /// Example:
  ///
  ///   Slider(value: $amount.didSet { print($0) }, in: 0...10)
  func didSet(execute: @escaping (Value) ->Void) -> Binding {
    return Binding(
      get: {
        return self.wrappedValue
      },
      set: {
        self.wrappedValue = $0
        execute($0)
      }
    )
  }
}
