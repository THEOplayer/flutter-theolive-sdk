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

//TODO: This extension of Error is required to do use FlutterError in any Swift code.
//TODO: https://github.com/flutter/packages/blob/main/packages/pigeon/example/README.md#swift
extension FlutterError: Error {}

class THEOliveView: NSObject, FlutterPlatformView, THEOlivePlayerEventListener, THEOliveNativeAPI {

    private static var TAG = "FL_IOS_THEOliveView"
    private let _viewId: Int64
    private var _view: UIView
    private let _pigeonMessenger: PigeonMultiInstanceBinaryMessengerWrapper
    private let _flutterAPI: THEOliveFlutterAPI
    private let player = THEOliveSDK.THEOlivePlayer()
    private let emptyCompletion: (Result<Void, FlutterError>) -> Void = {result in }
    private var chromelessPlayerView: THEOliveSDK.THEOliveChromelessPlayerView?
    
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

    func createNativeView(view _view: UIView){
        _view.backgroundColor = UIColor.black

        let chromelessPlayerView = THEOliveSDK.THEOliveChromelessPlayerView(player: player)
        chromelessPlayerView.translatesAutoresizingMaskIntoConstraints = false
        chromelessPlayerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        chromelessPlayerView.frame = _view.bounds

        _view.addSubview(chromelessPlayerView)

        self.chromelessPlayerView = chromelessPlayerView
    }

    func setupEventListeners() {
        player.add(eventListener: self)
    }
    
    func view() -> UIView {
        return _view
    }

    func preloadChannels(channelIDs: [String]) throws {
        self.player.preloadChannels(channelIDs)
    }
    
    func loadChannel(channelID: String) throws {
        self.player.loadChannel(channelID)
    }

    func play() throws {
        self.player.play()
    }

    func pause() throws {
        self.player.pause()
    }

    func isAutoplay() throws -> Bool {
        return false // TODO: not implemented in native
    }
    
    func setMuted(muted: Bool) throws {
        self.player.muted = muted
    }
    
    func setBadNetworkMode(badNetworkMode: Bool) throws {
        // TODO: not implemented in native
    }
    
    func goLive() throws {
        self.player.goLive()
    }
    
    func reset() throws {
        self.player.reset()
    }

    func updateConfiguration(configuration: PigeonNativePlayerConfiguration) throws {
        let nativeConfig = THEOlivePlayer.Configuration(sessionId: configuration.sessionId)
        self.player.updateConfiguration(nativeConfig)
    }

    func dispose() throws {
        player.remove(eventListener: self)
        chromelessPlayerView?.removeFromSuperview()
        player.reset()
    }

    func onLifecycleResume() {
        // ignore on iOS
    }

    func onLifecyclePause() {
        // ignore on iOS
    }

    func onChannelLoadStart(channelId: String) {
        _flutterAPI.onChannelLoadStart(channelID: channelId, completion: emptyCompletion)
    }

    func onChannelLoaded(channelId: String) {
        _flutterAPI.onChannelLoaded(channelID: channelId, completion: emptyCompletion)
    }

    func onChannelOffline(channelId: String) {
        _flutterAPI.onChannelOffline(channelID: channelId, completion: emptyCompletion)
    }
    
    func onWaiting() {
        _flutterAPI.onWaiting(completion: emptyCompletion);
    }
    
    func onPlay() {
        _flutterAPI.onPlay(completion: emptyCompletion);
    }
    
    func onPlaying() {
        _flutterAPI.onPlaying(completion: emptyCompletion);
    }

    func onPause() {
        _flutterAPI.onPause(completion: emptyCompletion)
    }

    func onMutedChange() {
        _flutterAPI.onMutedChange(completion: emptyCompletion)
    }
    
    func onIntentToFallback() {
        _flutterAPI.onIntentToFallback(completion: emptyCompletion)
    }

//    func onEnterBadNetworkMode() {}
    
//    func onExitBadNetworkMode() {}
    
//    func onReset() {}
    
    func onError(message: String) {
        _flutterAPI.onError(message: message, completion: emptyCompletion)
    }

    deinit {
        os_log("deinit %d", log: log, type: .debug, _viewId)
    }
}
