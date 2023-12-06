// Autogenerated from Pigeon (v10.1.6), do not edit directly.
// See also: https://pub.dev/packages/pigeon

package live.theo.sdk.flutter_theolive.pigeon

import android.util.Log
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.common.StandardMessageCodec
import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer

private fun wrapResult(result: Any?): List<Any?> {
  return listOf(result)
}

private fun wrapError(exception: Throwable): List<Any?> {
  if (exception is FlutterError) {
    return listOf(
      exception.code,
      exception.message,
      exception.details
    )
  } else {
    return listOf(
      exception.javaClass.simpleName,
      exception.toString(),
      "Cause: " + exception.cause + ", Stacktrace: " + Log.getStackTraceString(exception)
    )
  }
}

/**
 * Error class for passing custom error details to Flutter via a thrown PlatformException.
 * @property code The error code.
 * @property message The error message.
 * @property details The error details. Must be a datatype supported by the api codec.
 */
class FlutterError (
  val code: String,
  override val message: String? = null,
  val details: Any? = null
) : Throwable()

/** Generated interface from Pigeon that represents a handler of messages from Flutter. */
interface THEOliveNativeAPI {
  fun loadChannel(channelID: String, callback: (Result<Unit>) -> Unit)
  fun play()
  fun pause()
  fun manualDispose()
  fun preloadChannels(channelIDs: List<String>)

  companion object {
    /** The codec used by THEOliveNativeAPI. */
    val codec: MessageCodec<Any?> by lazy {
      StandardMessageCodec()
    }
    /** Sets up an instance of `THEOliveNativeAPI` to handle messages through the `binaryMessenger`. */
    @Suppress("UNCHECKED_CAST")
    fun setUp(binaryMessenger: BinaryMessenger, api: THEOliveNativeAPI?) {
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_theolive.THEOliveNativeAPI.loadChannel", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val channelIDArg = args[0] as String
            api.loadChannel(channelIDArg) { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_theolive.THEOliveNativeAPI.play", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            var wrapped: List<Any?>
            try {
              api.play()
              wrapped = listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_theolive.THEOliveNativeAPI.pause", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            var wrapped: List<Any?>
            try {
              api.pause()
              wrapped = listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_theolive.THEOliveNativeAPI.manualDispose", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            var wrapped: List<Any?>
            try {
              api.manualDispose()
              wrapped = listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_theolive.THEOliveNativeAPI.preloadChannels", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val channelIDsArg = args[0] as List<String>
            var wrapped: List<Any?>
            try {
              api.preloadChannels(channelIDsArg)
              wrapped = listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }
}
/** Generated class from Pigeon that represents Flutter messages that can be called from Kotlin. */
@Suppress("UNCHECKED_CAST")
class THEOliveFlutterAPI(private val binaryMessenger: BinaryMessenger) {
  companion object {
    /** The codec used by THEOliveFlutterAPI. */
    val codec: MessageCodec<Any?> by lazy {
      StandardMessageCodec()
    }
  }
  fun onChannelLoadedEvent(channelIDArg: String, callback: () -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_theolive.THEOliveFlutterAPI.onChannelLoadedEvent", codec)
    channel.send(listOf(channelIDArg)) {
      callback()
    }
  }
  fun onPlaying(callback: () -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_theolive.THEOliveFlutterAPI.onPlaying", codec)
    channel.send(null) {
      callback()
    }
  }
}
