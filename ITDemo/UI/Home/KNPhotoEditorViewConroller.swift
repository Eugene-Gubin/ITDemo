//
//  KNPhotoEditorViewConroller.swift
//  ITDemo
//
//  Created by Евгений Губин on 28.06.15.
//  Copyright (c) 2015 Evgeniy Gubin. All rights reserved.
//

import UIKit
import AVFoundation

class KNPhotoEditorViewConroller: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var picker: UIImagePickerController?
    var originalImage: UIImage?
    var cropPoints: [CGPoint] = []
    var cropLines: [UIView] = []
    var ipu = KNImageProcessingUtils.sharedInstance
    
    @IBOutlet weak var btnTakeAPhoo: UIButton!
    @IBOutlet weak var imgPicture: UIImageView!
    
    
    @IBAction func handleTakeAPhoto(sender: AnyObject) {
        if !UIImagePickerController.isSourceTypeAvailable(.Camera) {
            UIAlertView(title: nil, message: "No camera found", delegate: nil, cancelButtonTitle: "common.ok".localized).show()
            return
        }
        
        showImagePicker()
    }
    
    @IBAction func handleOriginTapped(sender: AnyObject) {
        if let originalImagel = self.originalImage {
            imgPicture.image = originalImage
        }
    }
    
    @IBAction func handleBnWTapped(sender: AnyObject) {
        if let originalImagel = self.originalImage {
            imgPicture.image = ipu.applyGrayscaleFilter(originalImage!)
        }
    }
    
    @IBAction func handleSephiaTapped(sender: AnyObject) {
        if let originalImagel = self.originalImage {
            imgPicture.image = ipu.applySephiaFilter(originalImage!)
        }
    }
    
    @IBAction func handleCropTapped(sender: AnyObject) {
        if (cropPoints.count == 2) {
            removeCropLines()
            imgPicture.image = ipu.applyCropping(originalImage!, rect: ipu.createRectFromPoints(cropPoints))
        } else {
            UIAlertView(title: nil, message: "Tap twice on picture to form crop rectangle", delegate: nil, cancelButtonTitle: "common.ok".localized).show()
        }
    }
    
    func removeCropLines() {
        for line in cropLines {
            line.removeFromSuperview()
        }
        cropLines = []
    }
    
    @IBAction func handleSaveTapped(sender: AnyObject) {
        if let image = imgPicture.image {
            UIImageWriteToSavedPhotosAlbum(imgPicture.image, self, Selector("showSavingCompleteAlert:error:contextInfo:"), nil)
        }
    }
    
    @IBAction func handleImageTap(sender: AnyObject) {
        let gr = sender as! UITapGestureRecognizer
        if gr.state == .Ended {
            let point = gr.locationInView(imgPicture)
            addCropPoint(point)
        }
    }
    
    @objc func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let picture = info[UIImagePickerControllerOriginalImage] as! UIImage
        showPicture(picture)
        hideImagePicker()
    }
    
    @objc func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        hideImagePicker()
    }
    
    func showImagePicker() {
        let picker = UIImagePickerController()
        
        picker.sourceType = .Camera
        picker.delegate = self
        
        self.picker = picker
        
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func hideImagePicker() {
        dismissViewControllerAnimated(true, completion: nil)
        picker = nil
    }
    
    func showPicture(picture: UIImage) {
        originalImage = picture
        imgPicture.image = picture
        
        imgPicture.hidden = false
        btnTakeAPhoo.hidden = true
    }
    
    @objc func showSavingCompleteAlert(image: UIImage, error:NSErrorPointer, contextInfo: UnsafePointer<()>) {
        UIAlertView(title: nil, message: "Picture is saved to your Photo Album", delegate: nil, cancelButtonTitle: "common.ok".localized).show()
    }
    
    func addCropPoint(point: CGPoint) {
        if originalImage == nil {
            return
        }
        
        let cp = ipu.convertUIImageViewPointToUIImagePoint(point, imgViewBounds: imgPicture.bounds, imgSize: originalImage!.size)
        
        if cropPoints.count >= 2 || cp == nil {
            return
        }
        
        cropPoints.append(cp!)
        
        let hv = UIView(frame: CGRect(x: 0, y: point.y, width: imgPicture.bounds.width, height: 1))
        hv.backgroundColor = UIColor.greenColor()
        let vv = UIView(frame: CGRect(x: point.x, y: 0, width: 1, height: imgPicture.bounds.height))
        vv.backgroundColor = UIColor.greenColor()
        
        imgPicture.addSubview(hv)
        imgPicture.addSubview(vv)
        
        cropLines.extend([hv, vv])
    }
}
