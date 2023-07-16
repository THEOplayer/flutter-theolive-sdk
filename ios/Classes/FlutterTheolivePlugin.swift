import Flutter
import UIKit

public class FlutterTheolivePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_theolive", binaryMessenger: registrar.messenger())
    let instance = FlutterTheolivePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
      
    // register theoplayerview
    let factory = THEOliveNativeViewFactory(messenger: registrar.messenger())
    registrar.register(factory, withId: "theoliveview")
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
