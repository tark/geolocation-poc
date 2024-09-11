import AVFoundation
import Flutter
import GoogleMaps
import flutter_local_notifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  var audioChannel: FlutterMethodChannel!

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyB09V4K-O3sQaG0ZwrNdKFZKsBSVEP-_vQ")
    GeneratedPluginRegistrant.register(with: self)

    let controller = window?.rootViewController as! FlutterViewController
    audioChannel = FlutterMethodChannel(name: "com.yourcompany.audio",
                                         binaryMessenger: controller.binaryMessenger)

    audioChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
      if call.method == "startAudioService" {
        let session = AVAudioSession.sharedInstance()
        do {
          try session.setCategory(.playback, mode: .default, options: [])
          try session.setActive(true)
          result("Audio session started")
        } catch {
      result(
        FlutterError(
          code: "UNAVAILABLE",
          message: "Audio session couldn't start",
          details: nil
        )
      )
        }
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
