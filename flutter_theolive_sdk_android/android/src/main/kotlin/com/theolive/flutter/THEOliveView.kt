package com.theolive.flutter

import android.content.Context
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import com.theolive.flutter.pigeon.PigeonNativePlayerConfiguration
import com.theolive.flutter.pigeon.THEOliveFlutterAPI
import com.theolive.flutter.pigeon.THEOliveNativeAPI
import com.theolive.player.EventListener
import com.theolive.player.PlayerView
import com.theolive.player.RenderingTarget
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class THEOliveView(context: Context, viewId: Int, args: Any?, messenger: BinaryMessenger) : PlatformView, EventListener, THEOliveNativeAPI {

    private val RENDERINGTARGET_SURFACE_VIEW = "surfaceView"

    private val id: Int
    private val pigeonMessenger: PigeonMultiInstanceBinaryMessengerWrapper
    private val flutterApi: THEOliveFlutterAPI
    private val linearLayout: LinearLayout
    private val playerView: PlayerView
    private val nativeRenderingTarget: String
    private val emptyCallback: (Result<Unit>) -> Unit = {}
    private val mainScope = CoroutineScope(Dispatchers.Main)

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

    init {
        id = viewId
        useHybridComposition = (args as? Map<*, *>)?.get("useHybridComposition") as? Boolean == true
        nativeRenderingTarget = ((args as? Map<*, *>)?.get("nativeRenderingTarget") as? String) ?: RENDERINGTARGET_SURFACE_VIEW //TODO: use enum and pigeon

        pigeonMessenger = PigeonMultiInstanceBinaryMessengerWrapper(messenger, "id_$viewId")
        THEOliveNativeAPI.setUp(pigeonMessenger, this)
        flutterApi = THEOliveFlutterAPI(pigeonMessenger)

        val layoutParams = ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT)
        linearLayout = LinearLayout(context)
        linearLayout.layoutParams = layoutParams
        linearLayout.id = viewId
        playerView = PlayerView(context)
        playerView.id = View.generateViewId()
        playerView.layoutParams = layoutParams
        linearLayout.addView(playerView)

        if (nativeRenderingTarget == RENDERINGTARGET_SURFACE_VIEW) {
            playerView.setRenderingTarget(RenderingTarget.SURFACE_VIEW)
        } else {
            playerView.setRenderingTarget(RenderingTarget.TEXTURE_VIEW)
        }

        playerView.player.addEventListener(this)
    }

    override fun getView(): View {
        return linearLayout
    }

    override fun preloadChannels(channelIDs: List<String>) {
        playerView.player.preloadChannels(channelIDs.toTypedArray())
    }

    override fun loadChannel(channelID: String) {
        playerView.player.loadChannel(channelID)
    }

    override fun play() {
        playerView.player.play()
    }

    override fun pause() {
        playerView.player.pause()
    }

    override fun isAutoplay(): Boolean {
        return playerView.player.isAutoplay
    }

    override fun setMuted(muted: Boolean) {
        playerView.player.muted = muted
    }

    override fun setBadNetworkMode(badNetworkMode: Boolean) {
        playerView.player.badNetworkMode = badNetworkMode
    }

    override fun goLive() {
        playerView.player.goLive()
    }

    override fun reset() {
        playerView.player.reset()
    }

    override fun updateConfiguration(configuration: PigeonNativePlayerConfiguration) {
        playerView.player.updateConfig(configuration.sessionId)
    }

    override fun manualDispose() {
        //DO NOTHING, normal dispose() flow should be called by Flutter
    }

    override fun onLifecycleResume() {
        playerView.onResume()
    }

    override fun onLifecyclePause() {
        playerView.onPause()
    }

    override fun onChannelLoadStart(channelId: String) {
        isFirstPlaying = false
        mainScope.launch {
            flutterApi.onChannelLoadStart(channelId, emptyCallback)
        }
    }

    override fun onChannelLoaded(channelId: String) {
        isFirstPlaying = false
        mainScope.launch {
            flutterApi.onChannelLoaded(channelId, emptyCallback)
        }
    }

    override fun onChannelOffline(channelId: String) {
        isFirstPlaying = false
        mainScope.launch {
            flutterApi.onChannelOffline(channelId, emptyCallback)
        }
    }

    override fun onWaiting() {
        mainScope.launch {
            flutterApi.onWaiting(emptyCallback)
        }
    }

    override fun onPlay() {
        mainScope.launch {
            flutterApi.onPlay(emptyCallback)
        }
    }

    override fun onPlaying() {
        if (!isFirstPlaying) {
            isFirstPlaying = true
        }

        mainScope.launch {
            flutterApi.onPlaying(emptyCallback)
        }
    }

    override fun onPause() {
        mainScope.launch {
            flutterApi.onPause(emptyCallback)
        }
    }

    override fun onMutedChange() {
        mainScope.launch {
            flutterApi.onMutedChange(emptyCallback)
        }
    }

    override fun onIntentToFallback() {
        isFirstPlaying = false
        mainScope.launch {
            flutterApi.onIntentToFallback(emptyCallback)
        }
    }

    override fun onEnterBadNetworkMode() {
        mainScope.launch {
            flutterApi.onEnterBadNetworkMode(emptyCallback)
        }
    }

    override fun onExitBadNetworkMode() {
        mainScope.launch {
            flutterApi.onExitBadNetworkMode(emptyCallback)
        }
    }

    override fun onReset() {
        isFirstPlaying = false
        mainScope.launch {
            flutterApi.onReset(emptyCallback)
        }
    }

    override fun onError(message: String) {
        isFirstPlaying = false
        mainScope.launch {
            flutterApi.onError(message, emptyCallback)
        }
    }

    override fun dispose() {
        playerView.player.removeEventListener(this)
        linearLayout.removeView(playerView)
        playerView.player.destroy()
        playerView.onDestroy()
    }

}