//
//  QRCodeScannerViewController.swift
//  PaymentWallTask
//
//  Created SAMEH on 6/23/20.
//
//

import UIKit
import RxSwift
import RxCocoa
import AVFoundation

class QRCodeScannerViewController: UIViewController {
    
    //MARK:- Outlets
    
    //MARK: - Attribuites
    var presenter: QRCodeScannerPresenterProtocol?
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.attach()
        initCaptureSession()
        setupVideoInput()
        setupMetadataOutput()
        setupPreviewLayer()
        startCaptureSession()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if previewLayer != nil {
            previewLayer.frame = view.layer.bounds
        }
    }
    
}

//MARK: - Setup
extension QRCodeScannerViewController {
    
    private func initCaptureSession() {
        captureSession = AVCaptureSession()
    }
    
    private func setupVideoInput() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            handleScanningIsNotSupported()
            return
        }
    }
    
    private func setupMetadataOutput() {
        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            handleScanningIsNotSupported()
            return
        }
    }
    
    func handleScanningIsNotSupported() {
        let localization = presenter?.viewModel.localization
        
        displayDefaultAlert(title: localization?.scanningNotSupportedTitle, message: localization?.scanningNotSupportedMessage, okTitle: localization?.ok) { [weak self] in
            self?.captureSession = nil
        }
    }
    
    private func setupPreviewLayer() {
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
    }
    
    private func startCaptureSession() {
        captureSession.startRunning()
    }
}

//MARK: - AVCaptureMetadataOutputObjectsDelegate
extension QRCodeScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            handleDidFoundCode(code: stringValue)
        }

    }
    
    func handleDidFoundCode(code: String) {
        presenter?.viewModel.didCaptureString.onNext(code)
    }
}

//MARK: Display
extension QRCodeScannerViewController: QRCodeScannerViewControllerProtocol {
    
    func displayDefaultAlert(title: String?, message: String?, okTitle: String?, actionBlock: (() -> Void)?) {
        showDefaultAlert(title: title, message: message, okTitle: okTitle, actionBlock: actionBlock)
    }
    
    func startCaptureRunning() {
        captureSession.startRunning()
    }
}
