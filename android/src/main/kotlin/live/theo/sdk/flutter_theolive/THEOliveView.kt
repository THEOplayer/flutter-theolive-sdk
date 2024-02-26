package live.theo.sdk.flutter_theolive

import android.content.Context
import android.util.Log
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import com.theolive.player.EventListener
import com.theolive.player.PlayerView
import com.theolive.player.RenderingTarget
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import live.theo.sdk.flutter_theolive.pigeon.PigeonNativePlayerConfiguration
import live.theo.sdk.flutter_theolive.pigeon.THEOliveFlutterAPI
import live.theo.sdk.flutter_theolive.pigeon.THEOliveNativeAPI



class THEOliveView(context: Context, viewId: Int, args: Any?, messenger: BinaryMessenger) : PlatformView,
    EventListener, THEOliveNativeAPI {

    private val RENDERINGTARGET_SURFACE_VIEW = "surfaceView"

    private var playerView: PlayerView

    private val constraintLayout: LinearLayout

    private val flutterApi: THEOliveFlutterAPI

    private val pigeonMessenger: PigeonMultiInstanceBinaryMessengerWrapper

    private val id : Int

    private val emptyCallback: () -> Unit = {}

    private val nativeRenderingTarget: String
    // Workaround to eliminate the inital transparent layout with initExpensiveAndroidView
    // TODO: remove it once initExpensiveAndroidView is not used.
    private var useHybridComposition: Boolean = false
    private var isFirstPlaying: Boolean = false
        set(value) {
            if (!useHybridComposition) {
                return
            }

            if (value) {
                playerView.visibility = View.VISIBLE
            } else {
                playerView.visibility = View.INVISIBLE
            }
            field = value
        }

    // sync behavior with native iOS SDK
    // TODO: this logic should move to application level. The SDK should always stay paused after a "background to foreground" switch.
    private var wasPlayingBeforeActivityOnPause: Boolean = false;

    init {
        Log.d("THEOliveView_$viewId", "init $viewId");

        useHybridComposition = (args as? Map<*, *>)?.get("useHybridComposition") as? Boolean == true
        nativeRenderingTarget = ((args as? Map<*, *>)?.get("nativeRenderingTarget") as? String) ?: RENDERINGTARGET_SURFACE_VIEW //TODO: use enum and pigeon

        //setup pigeon
        pigeonMessenger = PigeonMultiInstanceBinaryMessengerWrapper(messenger, "id_$viewId");
        THEOliveNativeAPI.setUp(pigeonMessenger, this)
        flutterApi = THEOliveFlutterAPI(pigeonMessenger)

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

        if (nativeRenderingTarget == RENDERINGTARGET_SURFACE_VIEW) {
            Log.d("THEOliveView_$id", "nativeRenderingTarget: surfaceView");
            playerView.setRenderingTarget(RenderingTarget.SURFACE_VIEW);
        } else {
            Log.d("THEOliveView_$id", "nativeRenderingTarget: textureView");
            playerView.setRenderingTarget(RenderingTarget.TEXTURE_VIEW);
        }

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

    override fun onLifecycleResume() {
        Log.d("THEOliveView_$id", "onLifecycleResume");
        playerView.onResume();
        if (wasPlayingBeforeActivityOnPause) {
            wasPlayingBeforeActivityOnPause = false;
            play();
        }
    }

    override fun onLifecyclePause() {
        Log.d("THEOliveView_$id", "onLifecyclePause");
        wasPlayingBeforeActivityOnPause = !playerView.player.paused
        playerView.onPause();
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

    override fun updateConfiguration(configuration: PigeonNativePlayerConfiguration) {
        this.playerView.player.updateConfig(configuration.sessionId)
    }

}