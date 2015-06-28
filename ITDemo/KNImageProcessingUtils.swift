//
//  KNImageProcessingUtils.swift
//  ITDemo
//
//  Created by Евгений Губин on 28.06.15.
//  Copyright (c) 2015 Evgeniy Gubin. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class KNImageProcessingUtils {
    
    static let sharedInstance = KNImageProcessingUtils()
    
    func applyGrayscaleFilter(picture: UIImage) -> UIImage {
        
        return applyFilter(picture) {
            CIFilter(name: "CIColorControls", withInputParameters: [
                "inputSaturation": 0
                ])
        }
    }
    
    func applySephiaFilter(picture: UIImage) -> UIImage {
        
        return applyFilter(picture) {
            CIFilter(name: "CISepiaTone", withInputParameters: [
                "inputIntensity": 0.8
                ])
        }
    }
    
    private func applyFilter(picture: UIImage, filterFactory: () -> CIFilter) -> UIImage {
        let inputImage = CIImage(CGImage: picture.CGImage)
        
        let filter = filterFactory()
        filter.setValue(inputImage, forKey: "inputImage")
        
        let outputCIImage = filter.outputImage
        
        let ctx = CIContext(options: nil)
        let outputCGImage = ctx.createCGImage(outputCIImage, fromRect: outputCIImage.extent())
        let outputImage = UIImage(CGImage: outputCGImage, scale: picture.scale, orientation: picture.imageOrientation)
        
        return outputImage!
    }
    
    func applyCropping(picture: UIImage, rect: CGRect) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(picture.size, false, picture.scale)
        picture.drawInRect(CGRect(origin: CGPoint(x: 0, y: 0), size: picture.size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        let croppedCGImage = CGImageCreateWithImageInRect(normalizedImage.CGImage, rect)
        return UIImage(CGImage: croppedCGImage, scale: normalizedImage.scale, orientation: normalizedImage.imageOrientation)!
    }
    
    func convertUIImageViewPointToUIImagePoint(point: CGPoint, imgViewBounds: CGRect, imgSize: CGSize) -> CGPoint? {
        let imgRect = AVMakeRectWithAspectRatioInsideRect(imgSize, imgViewBounds)
        
        if !imgRect.contains(point){
            return nil
        }
        
        let xScaleRatio = imgSize.width / imgRect.width
        let yScaleRatio = imgSize.height / imgRect.height
        
        let xOffset = point.x - imgRect.origin.x
        let yOffset = point.y - imgRect.origin.y
        
        return CGPoint(x: xOffset * xScaleRatio, y: yOffset * yScaleRatio)
    }
    
    func createRectFromPoints(points: [CGPoint]) -> CGRect {
        let p0 = points[0]
        let p1 = points[1]
        
        var topLeft = CGPoint(x: min(p0.x, p1.x), y: min(p0.y, p1.y))
        var bottomRight = CGPoint(x: max(p0.x, p1.x), y: max(p0.y, p1.y))
        
        return CGRect(x: topLeft.x, y: topLeft.y, width: bottomRight.x - topLeft.x, height: bottomRight.y - topLeft.y)
    }
}