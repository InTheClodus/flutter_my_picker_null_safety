import Flutter
import UIKit

public class SwiftFlutterMyPickerNullSafetyPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_my_picker_null_safety", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterMyPickerNullSafetyPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
