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

    private let player = THEOliveSDK.THEOlivePlayer()

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
        _view.frame = frame
        _channel = FlutterMethodChannel(name: "THEOliveView/\(viewId)", binaryMessenger: messenger!)
        
        super.init()
        
        // iOS views can be created here
        createNativeView(view: _view)
        setupEventListeners()
                
        _channel.setMethodCallHandler({ (call: FlutterMethodCall, result: FlutterResult) -> Void in
          // receive calls from Dart
          switch call.method {
              case "loadChannel":
               guard let args = call.arguments as? [String: Any],
                 let channelId = args["channelId"] as? String else {
                 result(FlutterError(code: "ERROR_1", message: "Missing channelId!", details: nil))
                 return
               }
                self.player.loadChannel(channelId)
                print(THEOliveNativeView.TAG + " SWIFT loadChannel success")
                result(nil)
            case "play":
                print("SWIFT play!, not implemented")
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


        let newPlayerView = THEOliveSDK.THEOlivePlayerViewController(player: player)
        //parent.addChild(playerViewController) //TODO: get main VC, if needed

        newPlayerView.view.translatesAutoresizingMaskIntoConstraints = false
        newPlayerView.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //newPlayerView.didMove(toParent: parent)
        newPlayerView.view.frame = _view.bounds
        _view.addSubview(newPlayerView.view)

    }
    
    func setupEventListeners() {
        /*
        player.addEventListener(type: PlayerEventTypes.ChannelLoaded) { event in
            // method channel invokeMethod with callback
            self._channel.invokeMethod("onChannelLoaded", arguments: event.configuration.channelID) { (result) in
                print(THEOliveNativeView.TAG + "SWIFT onChannelLoaded ack received: " + String(describing: result))
            }
        }
        */
    }
    
}
