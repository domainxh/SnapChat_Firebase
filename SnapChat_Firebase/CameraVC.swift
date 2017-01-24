//
//  ViewController.swift
//  SnapChat_Firebase
//
//  Created by Xiaoheng Pan on 1/15/17.
//  Copyright © 2017 Xiaoheng Pan. All rights reserved.
//

import UIKit
import Firebase

class CameraVC: CameraViewController {

    @IBOutlet weak var previewView: PreviewView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var livePhotoModeButton: UIButton!
    @IBOutlet weak var cameraUnavailableLabel: UILabel!
    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var captureModeControl: UISegmentedControl!

    
    override func viewDidLoad() {
        
        _previewView = previewView
        _cameraButton = cameraButton
        _recordButton = recordButton
        _livePhotoModeButton = livePhotoModeButton
        _cameraUnavailableLabel = cameraUnavailableLabel
        _resumeButton = resumeButton
        _photoButton = photoButton
        _captureModeControl = captureModeControl
        
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Verify tha that the user has successfully logged in. This guard statement needs to be here and not in the viewDidLoad because, viewDidLoad is called onetime right after all the items are loaded in memory, but not visible to the user. We can't laod another viewController on the screen until the view is visible to the user. Hence we need to do it after viewDidAppear.
        
        guard FIRAuth.auth()?.currentUser != nil else {
            // Authentication failed, load login VC
            
            performSegue(withIdentifier: "returnToSigninScreen", sender: nil)
            // Try different segues, like show, present modally and etc.
            
            return
        }
        
    }

    @IBAction func recordBtnTapped(_ sender: Any) { toggleMovieRecording() }
    @IBAction func changeCamBtnTapped(_ sender: Any) { changeCamera() }
    @IBAction func capturePhoto(_ sender: Any) { capturePhoto() }
    @IBAction func toggleLivePhotoMode(_ sender: Any) { toggleLivePhotoMode() }
    @IBAction func toggleCaptureMode(_ sender: Any) { toggleCaptureMode() }
    @IBAction func resumeInterruptedSession(_ sender: Any) { resumeInterruptedSession() }
    @IBAction func focusAndExposedRecognizer(_ sender: UITapGestureRecognizer) { focusAndExposeTap(sender) }
    
}

