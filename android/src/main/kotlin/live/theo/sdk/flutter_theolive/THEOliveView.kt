package live.theo.sdk.flutter_theolive

import android.content.Context
import android.util.Log
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.ComposeView
import com.theolive.player.api.*
import com.theoplayer.android.api.event.player.PlayerEventTypes
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.platform.PlatformView
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import live.theo.sdk.flutter_theolive.pigeon.THEOliveNativeAPI


class THEOliveView(context: Context, viewId: Int, args: Any?, messenger: BinaryMessenger) : PlatformView,
    MethodChannel.MethodCallHandler, EventListener, THEOliveNativeAPI {

    private val cv: ComposeView
    private lateinit var player: THEOlivePlayer
    private val constraintLayout: LinearLayout

    private val methodChannel: MethodChannel

    init {

        THEOliveNativeAPI.setUp(messenger, this);
        constraintLayout = LinearLayout(context)

        val layoutParams = ViewGroup.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT,
            ViewGroup.LayoutParams.MATCH_PARENT)
        constraintLayout.layoutParams = layoutParams

        cv = ComposeView(context)
        cv.id = View.generateViewId(); //TODO: use viewId here, or on the wrapper
        constraintLayout.addView(cv)

        cv.setContent {
            val scope = rememberCoroutineScope()
            val player = rememberTHEOlivePlayer()
            Log.d("THEOliveView", "player: $player");
            this.player = player

            THEOliveChromeless(modifier = Modifier.fillMaxSize(), player = player)
            //TODO: move this into a MethodChannel call
            /*
            LaunchedEffect(key1 = player) {
                scope.launch {
                    player.loadChannel(channelId = "0nhw9z5zaz6bek27vdng81be5")
                }
            }
             */

            player.addEventListener(this);

        }

        methodChannel = MethodChannel(messenger, "THEOliveView/$viewId")
        methodChannel.setMethodCallHandler(this)

    }

    override fun onChannelLoaded(channelInfo: ChannelInfo) {
        super.onChannelLoaded(channelInfo)
        //TODO: instead of null, we can pass a result callback, if we care about a response from the receiver side too
        methodChannel.invokeMethod("onChannelLoaded", channelInfo.channelId, null)
    }


    override fun getView(): View? {
        return constraintLayout
    }

    override fun dispose() {
        //TODO("Not yet implemented")
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        // receive calls from Dart
        Log.d("THEOliveView", "onMethodCall: $call.method");

        when (call.method) {
            "play" -> {
                this.player.play();
                result.success(true);
            }
            "pause" -> {
                this.player.pause();
                result.success(true);
            }
            "loadChannel" -> {
                val channelId = call.argument<String>("channelId");
                Log.d("THEOliveView", "channelId: $channelId");
                Log.d("THEOliveView", "player: $player");
                channelId?.let {
                    //TODO: check this
                    runBlocking {
                        Log.d("THEOliveView", "player: $player");
                        player.loadChannel(channelId = it)
                    }
                    result.success(null)
                } ?: {
                    result.error("ERROR_1", "Missing channelId!", null)
                }
            }
            else -> { // Note the block
                result.notImplemented()
            }
        }
    }

    override fun loadChannel(channelID: String) {
        runBlocking {
            Log.d("THEOliveView", "loadChannel: $channelID, player: $player");
            player.loadChannel(channelID)
        }
    }
}