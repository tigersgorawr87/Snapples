//
//  Camera.swift
//  Snapples
//
//  Created by Michael Johnston on 8/20/16.
//  Copyright © 2016 Snapples. All rights reserved.
//

import UIKit
import AVFoundation

var captureSession : AVCaptureSession?
var previewLayer : AVCaptureVideoPreviewLayer?
var videoOutput : AVCaptureMovieFileOutput?
var cameraDevices : [AVCaptureDevice]?
var camInputFront : AVCaptureInput?
var camInputBack : AVCaptureInput?

class CameraView: UIViewController {
//Resources
    @IBOutlet var cameraSwipe: UISwipeGestureRecognizer!
    @IBOutlet var cameraView: UIView!
    @IBOutlet weak var TakePictureView: UIView!
    @IBOutlet weak var ExitSnapView: UIView!
    @IBOutlet weak var FlipCameraView: UIView!
    var cameraChoice = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captureSession = AVCaptureSession()
        findCameraDevices()
        loadCamera()
    }
//Stores available camera devices in an array
    func findCameraDevices(){
        let backDiscovery = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera, AVCaptureDevice.DeviceType.builtInTelephotoCamera, AVCaptureDevice.DeviceType.builtInDualCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position(rawValue: 1)!)
        let frontDiscovery = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera, AVCaptureDevice.DeviceType.builtInTelephotoCamera, AVCaptureDevice.DeviceType.builtInDualCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position(rawValue: 2)!)
        let backDevices = backDiscovery.devices
        let frontDevices = frontDiscovery.devices
        print(frontDevices)
        print(backDevices[0])
        cameraDevices = [(frontDevices[0]), (backDevices[0])]
        cameraChoice = false
    }
    func loadCamera(){
        if cameraDevices?[0] != nil {
            do{
                try camInputFront = AVCaptureDeviceInput(device: cameraDevices![0])
                try camInputBack = AVCaptureDeviceInput(device: cameraDevices![1])
                captureSession?.addInput(camInputFront!)
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                previewLayer?.frame = cameraView.layer.frame
                self.cameraView.layer.addSublayer(previewLayer!)
                captureSession?.startRunning()
            }
            catch{
                print("Error: The camera you are trying to use is not a valid input device")
            }
        }
    }
// Handles UI
    @IBAction func flipCamera(_ sender: UIButton) {
        if cameraChoice == false {
            captureSession?.removeInput(camInputFront!)
            captureSession?.addInput(camInputBack!)
        }
        else{
            captureSession?.removeInput(camInputBack!)
            captureSession?.addInput(camInputFront!)
        }
        
        cameraChoice = !cameraChoice
    }
    @IBAction func ExitSnap(_ sender: UIButton) {
        ExitSnapView.isHidden = true
        TakePictureView.isHidden = false
        FlipCameraView.isHidden = false
    }
    @IBAction func TakePictureButton(_ sender: UIButton) {
        TakePictureView.isHidden = true
        ExitSnapView.isHidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

