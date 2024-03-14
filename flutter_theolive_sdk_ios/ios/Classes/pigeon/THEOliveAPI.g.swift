// Autogenerated from Pigeon (v12.0.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation
#if os(iOS)
import Flutter
#elseif os(macOS)
import FlutterMacOS
#else
#error("Unsupported platform.")
#endif

private func isNullish(_ value: Any?) -> Bool {
  return value is NSNull || value == nil
}

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)"
  ]
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}

/// Generated class from Pigeon that represents data sent in messages.
struct PigeonNativePlayerConfiguration {
  var sessionId: String? = nil

  static func fromList(_ list: [Any?]) -> PigeonNativePlayerConfiguration? {
    let sessionId: String? = nilOrValue(list[0])

    return PigeonNativePlayerConfiguration(
      sessionId: sessionId
    )
  }
  func toList() -> [Any?] {
    return [
      sessionId,
    ]
  }
}
private class THEOliveNativeAPICodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
      case 128:
        return PigeonNativePlayerConfiguration.fromList(self.readValue() as! [Any?])
      default:
        return super.readValue(ofType: type)
    }
  }
}

private class THEOliveNativeAPICodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? PigeonNativePlayerConfiguration {
      super.writeByte(128)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class THEOliveNativeAPICodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return THEOliveNativeAPICodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return THEOliveNativeAPICodecWriter(data: data)
  }
}

class THEOliveNativeAPICodec: FlutterStandardMessageCodec {
  static let shared = THEOliveNativeAPICodec(readerWriter: THEOliveNativeAPICodecReaderWriter())
}

/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol THEOliveNativeAPI {
  func preloadChannels(channelIDs: [String]) throws
  func loadChannel(channelID: String) throws
  func play() throws
  func pause() throws
  func isAutoplay() throws -> Bool
  func setMuted(muted: Bool) throws
  func setBadNetworkMode(badNetworkMode: Bool) throws
  func goLive() throws
  func reset() throws
  func updateConfiguration(configuration: PigeonNativePlayerConfiguration) throws
  func dispose() throws
  func onLifecycleResume() throws
  func onLifecyclePause() throws
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class THEOliveNativeAPISetup {
  /// The codec used by THEOliveNativeAPI.
  static var codec: FlutterStandardMessageCodec { THEOliveNativeAPICodec.shared }
  /// Sets up an instance of `THEOliveNativeAPI` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: THEOliveNativeAPI?) {
    let preloadChannelsChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_theolive.THEOliveNativeAPI.preloadChannels", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      preloadChannelsChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let channelIDsArg = args[0] as! [String]
        do {
          try api.preloadChannels(channelIDs: channelIDsArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      preloadChannelsChannel.setMessageHandler(nil)
    }
    let loadChannelChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_theolive.THEOliveNativeAPI.loadChannel", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      loadChannelChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let channelIDArg = args[0] as! String
        do {
          try api.loadChannel(channelID: channelIDArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      loadChannelChannel.setMessageHandler(nil)
    }
    let playChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_theolive.THEOliveNativeAPI.play", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      playChannel.setMessageHandler { _, reply in
        do {
          try api.play()
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      playChannel.setMessageHandler(nil)
    }
    let pauseChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_theolive.THEOliveNativeAPI.pause", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      pauseChannel.setMessageHandler { _, reply in
        do {
          try api.pause()
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      pauseChannel.setMessageHandler(nil)
    }
    let isAutoplayChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_theolive.THEOliveNativeAPI.isAutoplay", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      isAutoplayChannel.setMessageHandler { _, reply in
        do {
          let result = try api.isAutoplay()
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      isAutoplayChannel.setMessageHandler(nil)
    }
    let setMutedChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_theolive.THEOliveNativeAPI.setMuted", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setMutedChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let mutedArg = args[0] as! Bool
        do {
          try api.setMuted(muted: mutedArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setMutedChannel.setMessageHandler(nil)
    }
    let setBadNetworkModeChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_theolive.THEOliveNativeAPI.setBadNetworkMode", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setBadNetworkModeChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let badNetworkModeArg = args[0] as! Bool
        do {
          try api.setBadNetworkMode(badNetworkMode: badNetworkModeArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setBadNetworkModeChannel.setMessageHandler(nil)
    }
    let goLiveChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_theolive.THEOliveNativeAPI.goLive", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      goLiveChannel.setMessageHandler { _, reply in
        do {
          try api.goLive()
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      goLiveChannel.setMessageHandler(nil)
    }
    let resetChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_theolive.THEOliveNativeAPI.reset", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      resetChannel.setMessageHandler { _, reply in
        do {
          try api.reset()
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      resetChannel.setMessageHandler(nil)
    }
    let updateConfigurationChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_theolive.THEOliveNativeAPI.updateConfiguration", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      updateConfigurationChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let configurationArg = args[0] as! PigeonNativePlayerConfiguration
        do {
          try api.updateConfiguration(configuration: configurationArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      updateConfigurationChannel.setMessageHandler(nil)
    }
    let disposeChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_theolive.THEOliveNativeAPI.dispose", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      disposeChannel.setMessageHandler { _, reply in
        do {
          try api.dispose()
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      disposeChannel.setMessageHandler(nil)
    }
    let onLifecycleResumeChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_theolive.THEOliveNativeAPI.onLifecycleResume", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      onLifecycleResumeChannel.setMessageHandler { _, reply in
        do {
          try api.onLifecycleResume()
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      onLifecycleResumeChannel.setMessageHandler(nil)
    }
    let onLifecyclePauseChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_theolive.THEOliveNativeAPI.onLifecyclePause", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      onLifecyclePauseChannel.setMessageHandler { _, reply in
        do {
          try api.onLifecyclePause()
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      onLifecyclePauseChannel.setMessageHandler(nil)
    }
  }
}
/// Generated protocol from Pigeon that represents Flutter messages that can be called from Swift.
protocol THEOliveFlutterAPIProtocol {
  func onChannelLoadStart(channelID channelIDArg: String, completion: @escaping (Result<Void, FlutterError>) -> Void) 
  func onChannelLoaded(channelID channelIDArg: String, completion: @escaping (Result<Void, FlutterError>) -> Void) 
  func onChannelOffline(channelID channelIDArg: String, completion: @escaping (Result<Void, FlutterError>) -> Void) 
  func onWaiting(completion: @escaping (Result<Void, FlutterError>) -> Void) 
  func onPlay(completion: @escaping (Result<Void, FlutterError>) -> Void) 
  func onPlaying(completion: @escaping (Result<Void, FlutterError>) -> Void) 
  func onPause(completion: @escaping (Result<Void, FlutterError>) -> Void) 
  func onMutedChange(completion: @escaping (Result<Void, FlutterError>) -> Void) 
  func onIntentToFallback(completion: @escaping (Result<Void, FlutterError>) -> Void) 
  func onEnterBadNetworkMode(completion: @escaping (Result<Void, FlutterError>) -> Void) 
  func onExitBadNetworkMode(completion: @escaping (Result<Void, FlutterError>) -> Void) 
  func onReset(completion: @escaping (Result<Void, FlutterError>) -> Void) 
  func onError(message messageArg: String, completion: @escaping (Result<Void, FlutterError>) -> Void) 
}
class THEOliveFlutterAPI: THEOliveFlutterAPIProtocol {
  private let binaryMessenger: FlutterBinaryMessenger
  init(binaryMessenger: FlutterBinaryMessenger){
    self.binaryMessenger = binaryMessenger
  }
  func onChannelLoadStart(channelID channelIDArg: String, completion: @escaping (Result<Void, FlutterError>) -> Void)  {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_theolive.THEOliveFlutterAPI.onChannelLoadStart", binaryMessenger: binaryMessenger)
    channel.sendMessage([channelIDArg] as [Any?]) { _ in
      completion(.success(Void()))
    }
  }
  func onChannelLoaded(channelID channelIDArg: String, completion: @escaping (Result<Void, FlutterError>) -> Void)  {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_theolive.THEOliveFlutterAPI.onChannelLoaded", binaryMessenger: binaryMessenger)
    channel.sendMessage([channelIDArg] as [Any?]) { _ in
      completion(.success(Void()))
    }
  }
  func onChannelOffline(channelID channelIDArg: String, completion: @escaping (Result<Void, FlutterError>) -> Void)  {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_theolive.THEOliveFlutterAPI.onChannelOffline", binaryMessenger: binaryMessenger)
    channel.sendMessage([channelIDArg] as [Any?]) { _ in
      completion(.success(Void()))
    }
  }
  func onWaiting(completion: @escaping (Result<Void, FlutterError>) -> Void)  {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_theolive.THEOliveFlutterAPI.onWaiting", binaryMessenger: binaryMessenger)
    channel.sendMessage(nil) { _ in
      completion(.success(Void()))
    }
  }
  func onPlay(completion: @escaping (Result<Void, FlutterError>) -> Void)  {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_theolive.THEOliveFlutterAPI.onPlay", binaryMessenger: binaryMessenger)
    channel.sendMessage(nil) { _ in
      completion(.success(Void()))
    }
  }
  func onPlaying(completion: @escaping (Result<Void, FlutterError>) -> Void)  {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_theolive.THEOliveFlutterAPI.onPlaying", binaryMessenger: binaryMessenger)
    channel.sendMessage(nil) { _ in
      completion(.success(Void()))
    }
  }
  func onPause(completion: @escaping (Result<Void, FlutterError>) -> Void)  {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_theolive.THEOliveFlutterAPI.onPause", binaryMessenger: binaryMessenger)
    channel.sendMessage(nil) { _ in
      completion(.success(Void()))
    }
  }
  func onMutedChange(completion: @escaping (Result<Void, FlutterError>) -> Void)  {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_theolive.THEOliveFlutterAPI.onMutedChange", binaryMessenger: binaryMessenger)
    channel.sendMessage(nil) { _ in
      completion(.success(Void()))
    }
  }
  func onIntentToFallback(completion: @escaping (Result<Void, FlutterError>) -> Void)  {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_theolive.THEOliveFlutterAPI.onIntentToFallback", binaryMessenger: binaryMessenger)
    channel.sendMessage(nil) { _ in
      completion(.success(Void()))
    }
  }
  func onEnterBadNetworkMode(completion: @escaping (Result<Void, FlutterError>) -> Void)  {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_theolive.THEOliveFlutterAPI.onEnterBadNetworkMode", binaryMessenger: binaryMessenger)
    channel.sendMessage(nil) { _ in
      completion(.success(Void()))
    }
  }
  func onExitBadNetworkMode(completion: @escaping (Result<Void, FlutterError>) -> Void)  {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_theolive.THEOliveFlutterAPI.onExitBadNetworkMode", binaryMessenger: binaryMessenger)
    channel.sendMessage(nil) { _ in
      completion(.success(Void()))
    }
  }
  func onReset(completion: @escaping (Result<Void, FlutterError>) -> Void)  {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_theolive.THEOliveFlutterAPI.onReset", binaryMessenger: binaryMessenger)
    channel.sendMessage(nil) { _ in
      completion(.success(Void()))
    }
  }
  func onError(message messageArg: String, completion: @escaping (Result<Void, FlutterError>) -> Void)  {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_theolive.THEOliveFlutterAPI.onError", binaryMessenger: binaryMessenger)
    channel.sendMessage([messageArg] as [Any?]) { _ in
      completion(.success(Void()))
    }
  }
}
