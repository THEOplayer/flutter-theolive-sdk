//
//  THEOliveView.swift
//  flutter_theolive
//
//  Created by Daniel on 16/07/2023.
//

import Foundation
import Flutter
import UIKit
import THEOliveSDK
import os

let log = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "live.theo.THEOlive.Flutter" , category: "THEOliveView")

class THEOliveView: NSObject, FlutterPlatformView, THEOlivePlayerEventListener, THEOliveNativeAPI {

    private static var TAG = "FL_IOS_THEOliveView"
    private var _view: UIView
    private let _viewId: Int64
    private let _flutterAPI: THEOliveFlutterAPI
    private let _pigeonMessenger: PigeonMultiInstanceBinaryMessengerWrapper

    private let player = THEOliveSDK.THEOlivePlayer()
    
    var newPlayerView: THEOliveSDK.THEOliveChromelessPlayerView?
    
    private let emptyCompletion: () -> Void = {}
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _viewId = viewId
        _view = UIView()
        _view.frame = frame

        //setup pigeon
        _pigeonMessenger = PigeonMultiInstanceBinaryMessengerWrapper(with: messenger!, channelSuffix: "id_\(viewId)")
        _flutterAPI = THEOliveFlutterAPI(binaryMessenger: _pigeonMessenger)

        super.init()

        THEOliveNativeAPISetup.setUp(binaryMessenger: _pigeonMessenger, api: self)

        // iOS views can be created here
        createNativeView(view: _view)
        setupEventListeners()

    }


    func view() -> UIView {
        return _view
    }

    func createNativeView(view _view: UIView){
        _view.backgroundColor = UIColor.black

        let newPlayerView = THEOliveSDK.THEOliveChromelessPlayerView(player: player)

        newPlayerView.translatesAutoresizingMaskIntoConstraints = false
        newPlayerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        newPlayerView.frame = _view.bounds

        _view.addSubview(newPlayerView)

        self.newPlayerView = newPlayerView

    }

    func setupEventListeners() {

        player.add(eventListener: self)

    }

    // THEOliveNativeAPI
    func loadChannel(channelID: String) throws {
        os_log("loadChannel: %@", log: log, type: .debug, channelID)
        self.player.loadChannel(channelID)
    }

    func play() throws {
        self.player.play()
    }

    func pause() throws {
        self.player.pause()
    }

    func preloadChannels(channelIDs: [String]) throws {
        self.player.preloadChannels(channelIDs)
    }


    // Fix for https://github.com/flutter/flutter/issues/97499
    // The PlatformViews are not deallocated in time, so we clean up upfront.
    func manualDispose() throws {
        os_log("manualDispose", log: log, type: .debug)
        player.remove(eventListener: self)
        newPlayerView?.removeFromSuperview()
        player.reset()

    }

    // THEOlivePlayerEventListener
    func onChannelLoaded(channelId: String) {
        os_log("onChannelLoaded: %@", log: log, type: .debug, channelId)
        _flutterAPI.onChannelLoadedEvent(channelID: channelId, completion: emptyCompletion)
    }
    
    
    func goLive() throws {
        os_log("onPlaying", log: log, type: .debug)
        player.goLive()
    }

    func onPlaying() {
        os_log("onPlaying", log: log, type: .debug)
        _flutterAPI.onPlaying(completion: emptyCompletion);
    }

    func onError(message: String) {
        os_log("onError: %@" , log: log, type: .debug, message)
        _flutterAPI.onError(message: message, completion: emptyCompletion)
    }

    func onChannelOffline(channelId: String) {
        os_log("onChannelOffline: %@" , log: log, type: .debug, channelId)
        _flutterAPI.onChannelOfflineEvent(channelID: channelId, completion: emptyCompletion)
    }

    func onChannelLoadStart(channelId: String) {
        os_log("onChannelLoadStart: %@" , log: log, type: .debug, channelId)
        _flutterAPI.onChannelLoadStartEvent(channelID: channelId, completion: emptyCompletion)
    }

    func onWaiting() {
        os_log("onWaiting", log: log, type: .debug)
        _flutterAPI.onWaiting(completion: emptyCompletion);
    }

    func onPlay() {
        os_log("onPlay", log: log, type: .debug)
        _flutterAPI.onPlay(completion: emptyCompletion);
    }

    func onPause() {
        os_log("onPause", log: log, type: .debug)
        _flutterAPI.onPause(completion: emptyCompletion)
    }

    func onIntentToFallback() {
        os_log("onIntentToFallback", log: log, type: .debug)
        _flutterAPI.onIntentToFallback(completion: emptyCompletion)
    }

    deinit {
        os_log("deinit %d", log: log, type: .debug, _viewId)
    }
}
