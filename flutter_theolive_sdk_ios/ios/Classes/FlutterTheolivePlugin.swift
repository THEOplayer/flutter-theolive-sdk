import Flutter
import UIKit

public class FlutterTheolivePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_theolive", binaryMessenger: registrar.messenger())
    let instance = FlutterTheolivePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
      
    // register theoliveview
    let factory = THEOliveViewFactory(messenger: registrar.messenger())
    registrar.register(factory, withId: "theoliveview")
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
