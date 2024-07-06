import Flutter
import UIKit
import AVFoundation

public class CameraSettings: NSObject {
    public static func getCameraSettings(result: @escaping FlutterResult) {
        guard let device = AVCaptureDevice.default(for: .video) else {
            result(FlutterError(code: "UNAVAILABLE", message: "Camera not available", details: nil))
            return
        }

        var settings = [String: Any]()
        settings["activeFormat"] = device.activeFormat.formatDescription
        settings["videoZoomFactor"] = device.videoZoomFactor

        result(settings)
    }
}
