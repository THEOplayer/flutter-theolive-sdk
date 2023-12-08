package live.theo.sdk.flutter_theolive

import android.content.Context
import android.util.Log
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import com.theolive.player.EventListener
import com.theolive.player.PlayerView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import live.theo.sdk.flutter_theolive.pigeon.THEOliveFlutterAPI
import live.theo.sdk.flutter_theolive.pigeon.THEOliveNativeAPI


class THEOliveView(context: Context, viewId: Int, args: Any?, messenger: BinaryMessenger) : PlatformView,
    EventListener, THEOliveNativeAPI {

    private var playerView: PlayerView

    private val constraintLayout: LinearLayout

    private val flutterApi: THEOliveFlutterAPI

    private val id : Int

    private val emptyCallback: () -> Unit = {}

    // Workaround to eliminate the inital transparent layout with initExpensiveAndroidView
    // TODO: remove it once initExpensiveAndroidView is not used.
    private var isFirstPlaying: Boolean = false
        set(value) {
            if (value) {
                playerView.visibility = View.VISIBLE
            } else {
                playerView.visibility = View.INVISIBLE
            }
            field = value
        }
    init {
        Log.d("THEOliveView_$viewId", "init $viewId");

        THEOliveNativeAPI.setUp(messenger, this);
        flutterApi = THEOliveFlutterAPI(messenger);

        constraintLayout = LinearLayout(context)

        val layoutParams = ViewGroup.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT,
            ViewGroup.LayoutParams.MATCH_PARENT)
        constraintLayout.layoutParams = layoutParams
        //constraintLayout.setBackgroundColor(android.graphics.Color.BLUE)

        id = viewId
        constraintLayout.id = viewId
        playerView = PlayerView(context)
        playerView.id = View.generateViewId()
        playerView.layoutParams = layoutParams
        //playerView.setBackgroundColor(android.graphics.Color.RED)
        constraintLayout.addView(playerView)

        playerView.player.addEventListener(this)

    }

    override fun onChannelLoadStart(channelId: String) {
        Log.d("THEOliveView_$id", "onChannelLoadStart: $channelId");
        isFirstPlaying = false
        CoroutineScope(Dispatchers.Main).launch {
            flutterApi.onChannelLoadStartEvent(channelId, emptyCallback);
        }

    }
    override fun onChannelLoaded(channelId: String) {
        Log.d("THEOliveView_$id", "onChannelLoaded:");
        isFirstPlaying = false
        CoroutineScope(Dispatchers.Main).launch {
            flutterApi.onChannelLoadedEvent(channelId, emptyCallback);
        }
    }

    override fun onChannelOffline(channelId: String) {
        Log.d("THEOliveView_$id", "onChannelOffline: $channelId");
        isFirstPlaying = false
        CoroutineScope(Dispatchers.Main).launch {
            flutterApi.onChannelOfflineEvent(channelId, emptyCallback);
        }
    }

    override fun onPlaying() {
        Log.d("THEOliveView_$id", "onPlaying");

        if (!isFirstPlaying) {
            isFirstPlaying = true
        }

        CoroutineScope(Dispatchers.Main).launch {
            flutterApi.onPlaying(emptyCallback)
        }
    }

    override fun onWaiting() {
        Log.d("THEOliveView_$id", "onWaiting");
        CoroutineScope(Dispatchers.Main).launch {
            flutterApi.onWaiting(emptyCallback)
        }
    }

    override fun onPause() {
        Log.d("THEOliveView_$id", "onPause");
        CoroutineScope(Dispatchers.Main).launch {
            flutterApi.onPause(emptyCallback)
        }
    }

    override fun onPlay() {
        Log.d("THEOliveView_$id", "onPlay");
        CoroutineScope(Dispatchers.Main).launch {
            flutterApi.onPlay(emptyCallback)
        }
    }

    override fun onIntentToFallback() {
        Log.d("THEOliveView_$id", "onIntentToFallback");
        isFirstPlaying = false
        CoroutineScope(Dispatchers.Main).launch {
            flutterApi.onIntentToFallback(emptyCallback)
        }
    }

    override fun onReset() {
        Log.d("THEOliveView_$id", "onReset");
        isFirstPlaying = false
        CoroutineScope(Dispatchers.Main).launch {
            flutterApi.onReset(emptyCallback)
        }
    }

    override fun onError(message: String) {
        Log.d("THEOliveView_$id", "error: $message");
        isFirstPlaying = false
        CoroutineScope(Dispatchers.Main).launch {
            flutterApi.onError(message, emptyCallback)
        }
    }

    override fun getView(): View? {
        return constraintLayout
    }

    override fun dispose() {
        Log.d("THEOliveView_$id", "dispose");

        playerView.player.removeEventListener(this);
        constraintLayout.removeView(playerView)
        playerView.player.destroy()
        playerView.onDestroy()
    }

    override fun loadChannel(channelID: String) {
        Log.d("THEOliveView_$id", "loadChannel called, $channelID");
        playerView.player.loadChannel(channelID);
    }

    override fun manualDispose() {
        Log.d("THEOliveView_$id", "manualDispose");
        //DO NOTHING, normal dispose() flow should be called by Flutter
    }


    override fun preloadChannels(channelIDs: List<String>) {
        this.playerView.player.preloadChannels(channelIDs.toTypedArray());
    }

    override fun play() {
        this.playerView.player.play();
    }

    override fun pause() {
        this.playerView.player.pause()
    }

    override fun goLive() {
        this.playerView.player.goLive()
    }

}