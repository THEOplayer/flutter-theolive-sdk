//
//  THEOliveNativeView.swift
//  flutter_theolive
//
//  Created by Daniel on 16/07/2023.
//

import Foundation
import Flutter
import UIKit
import THEOliveSDK

class THEOliveNativeView: NSObject, FlutterPlatformView {
    private static var TAG = "FL_IOS_THEOliveNativeView"
    private var _view: UIView
    private var _channel: FlutterMethodChannel


    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
        _channel = FlutterMethodChannel(name: "THEOliveView/\(viewId)", binaryMessenger: messenger!)
        
        super.init()
        
        // iOS views can be created here
        createNativeView(view: _view)
        
        _channel.setMethodCallHandler({ (call: FlutterMethodCall, result: FlutterResult) -> Void in
          // receive calls from Dart
          switch call.method {
              case "loadChannel":
               guard let args = call.arguments as? [String: Any],
                 let text = args["channelId"] as? String else {
                 result(FlutterError(code: "ERROR_1", message: "Missing channelId!", details: nil))
                 return
               }
                print(THEOliveNativeView.TAG + " SWIFT loadChannel success")
                result(nil)
            case "play":
                print("SWIFT play!")
          default:
              result(FlutterMethodNotImplemented)
          }
        })
         
    }
    

    func view() -> UIView {
        return _view
    }
    
    func createNativeView(view _view: UIView){
        print("createNativeView")
        _view.backgroundColor = UIColor.yellow
        let label = UILabel()
        label.text = "THEOlive view should be here..."
        label.textColor = UIColor.black
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.translatesAutoresizingMaskIntoConstraints = false
        _view.addSubview(label)

    }
    
}
