

import SwiftUI
import AVFoundation
import CoreImage

class CameraFeedModel: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    var onColorDetected: ((UIColor) -> Void)?

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let context = CIContext()

        let width = CVPixelBufferGetWidth(pixelBuffer)
        let height = CVPixelBufferGetHeight(pixelBuffer)
        let center = CGPoint(x: width / 2, y: height / 2)

        let sampleSize: CGFloat = 10
        let extent = CGRect(x: center.x - sampleSize / 2,
                            y: center.y - sampleSize / 2,
                            width: sampleSize,
                            height: sampleSize)

        guard let cgImage = context.createCGImage(ciImage, from: extent) else { return }

        let imgWidth = Int(extent.width)
        let imgHeight = Int(extent.height)
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * imgWidth
        let totalBytes = imgWidth * imgHeight * bytesPerPixel

        var pixelData = [UInt8](repeating: 0, count: totalBytes)

        guard let colorSpace = CGColorSpace(name: CGColorSpace.sRGB) else { return }

        guard let bitmapContext = CGContext(data: &pixelData,
                                            width: imgWidth,
                                            height: imgHeight,
                                            bitsPerComponent: 8,
                                            bytesPerRow: bytesPerRow,
                                            space: colorSpace,
                                            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
        else { return }

        bitmapContext.draw(cgImage, in: CGRect(x: 0, y: 0, width: imgWidth, height: imgHeight))

        var totalR = 0, totalG = 0, totalB = 0
        for i in stride(from: 0, to: pixelData.count, by: 4) {
            totalR += Int(pixelData[i])
            totalG += Int(pixelData[i + 1])
            totalB += Int(pixelData[i + 2])
        }

        let pixelCount = CGFloat(imgWidth * imgHeight)
        let avgColor = UIColor(
            red: CGFloat(totalR) / pixelCount / 255.0,
            green: CGFloat(totalG) / pixelCount / 255.0,
            blue: CGFloat(totalB) / pixelCount / 255.0,
            alpha: 1.0
        )

        onColorDetected?(avgColor)
    }
}

struct CameraFeedView: UIViewRepresentable {
    var onColorDetected: (UIColor) -> Void

    class VideoPreviewView: UIView {
        override class var layerClass: AnyClass {
            AVCaptureVideoPreviewLayer.self
        }

        var previewLayer: AVCaptureVideoPreviewLayer {
            return layer as! AVCaptureVideoPreviewLayer
        }
    }

    func makeCoordinator() -> CameraFeedModel {
        let coordinator = CameraFeedModel()
        coordinator.onColorDetected = onColorDetected
        return coordinator
    }

    func makeUIView(context: Context) -> UIView {
        let view = VideoPreviewView()
        let session = AVCaptureSession()
        session.sessionPreset = .photo

        view.previewLayer.session = session
        view.previewLayer.videoGravity = .resizeAspectFill

        if let camera = AVCaptureDevice.default(for: .video),
           let input = try? AVCaptureDeviceInput(device: camera),
           session.canAddInput(input) {
            session.addInput(input)
        }

        let output = AVCaptureVideoDataOutput()
        output.setSampleBufferDelegate(context.coordinator, queue: DispatchQueue(label: "videoQueue"))
        if session.canAddOutput(output) {
            session.addOutput(output)
        }
       
       
        DispatchQueue.global(qos: .userInitiated).async {
            session.startRunning()
        }

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

func closestBaseColorName(to color: UIColor) -> String {
    let baseColors: [String: UIColor] = [
        "red": .red,
        "green": .green,
        "blue": .blue,
        "yellow": .yellow,
        "orange": .orange,
        "purple": .purple,
        "brown": .brown,
        "pink": UIColor.systemPink,
        "white": .white,
        "black": .black,
        "gray": .gray
    ]

    var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0
    color.getRed(&r1, green: &g1, blue: &b1, alpha: nil)

    var closestName = "unknown"
    var smallestDistance: CGFloat = .greatestFiniteMagnitude

    for (name, baseColor) in baseColors {
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0
        baseColor.getRed(&r2, green: &g2, blue: &b2, alpha: nil)

        let distance = sqrt(pow(r1 - r2, 2) + pow(g1 - g2, 2) + pow(b1 - b2, 2))
        if distance < smallestDistance {
            smallestDistance = distance
            closestName = name
        }
    }

    return closestName
}
