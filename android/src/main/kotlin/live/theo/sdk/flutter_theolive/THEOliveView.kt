package live.theo.sdk.flutter_theolive

import android.content.Context
import android.view.View
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.ComposeView
import com.theolive.player.api.THEOliveChromeless
import com.theolive.player.api.rememberTHEOlivePlayer
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView
import kotlinx.coroutines.launch

class THEOliveView(context: Context, viewId: Int, args: Any?, messenger: BinaryMessenger) : PlatformView {
    val cv: ComposeView

    init {
        cv = ComposeView(context)
        cv.setContent {
            val scope = rememberCoroutineScope()
            val player = rememberTHEOlivePlayer()

            THEOliveChromeless(modifier = Modifier.fillMaxSize(), player = player)
            LaunchedEffect(key1 = player) {
                scope.launch {
                    player.loadChannel(channelId = "0nhw9z5zaz6bek27vdng81be5")
                }
            }
        }
    }


    override fun getView(): View? {
        return cv
    }

    override fun dispose() {
        //TODO("Not yet implemented")
    }
}