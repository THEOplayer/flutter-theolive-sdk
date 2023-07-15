package live.theo.sdk.flutter_theolive

import android.content.Context
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
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
    private val cv: ComposeView
    private val constraintLayout: LinearLayout

    init {

        constraintLayout = LinearLayout(context)

        val layoutParams = ViewGroup.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT,
            ViewGroup.LayoutParams.MATCH_PARENT)
        constraintLayout.layoutParams = layoutParams

        cv = ComposeView(context)
        cv.id = View.generateViewId();
        constraintLayout.addView(cv)

        cv.setContent {
            val scope = rememberCoroutineScope()
            val player = rememberTHEOlivePlayer()

            THEOliveChromeless(modifier = Modifier.fillMaxSize(), player = player)
            //TODO: move this into a MethodChannel call
            LaunchedEffect(key1 = player) {
                scope.launch {
                    player.loadChannel(channelId = "0nhw9z5zaz6bek27vdng81be5")
                }
            }
        }

    }


    override fun getView(): View? {
        return constraintLayout
    }

    override fun dispose() {
        //TODO("Not yet implemented")
    }
}