//
//  ViewController.swift
//  VideoRecorder
//
//  Created by Paul Solt on 10/2/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		// TODO: get permission
		
		requestPermissionAndShowCamera()
		
	}
    
    private func requestPermissionAndShowCamera() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
            
        case .notDetermined: // User's first use of the app
            requestVideoPermission()
            
        case .restricted: // Privacy (video is disabled, present UI to user)
            fatalError("Video is disabled, please review parental controls")
            
        case .denied: // Asked for permission but they said no
            fatalError("Tell the user they can't use the app without giving permission: Settings > Privacy > Video")
            
        case .authorized: // User previously gave permission, show the camera
            showCamera()
            
        @unknown default:
            fatalError("A new status code was added that we need to handle")
        }
    }
    
    private func requestVideoPermission() {
        AVCaptureDevice.requestAccess(for: .video) { (granted) in
            guard granted else {
                fatalError("Tell user to enable permission for Video/Camera")
            }
            
            // Show camera
            DispatchQueue.main.async {
                self.showCamera()
            }
        }
    }
	
	private func showCamera() {
		performSegue(withIdentifier: "ShowCamera", sender: self)
	}
}
