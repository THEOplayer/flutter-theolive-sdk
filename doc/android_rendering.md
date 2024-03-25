## Android rendering settings

There is an experimental API available for Android that allows us to change the rendering behaviour of the player.

Flutter on Android uses 3 different ways to render Platform views (native Android views).

You can read about it more [here](https://github.com/flutter/flutter/wiki/Android-Platform-Views).

With THEOlive we added the option to choose between them (at least between 2 of them, the ones that showed the best result) based on what is the purpose and the audience of the application.

### THEOlive - RenderingTarget
In the THEOlive Android SDK changing the rendering target is possible based on your needs.

Today THEOlive Android SDK supports 2 options:

- SurfaceView
  - rendering on a SurfaceView is more performant than on a TextureView, but SurfaceView is not the best choice, if we need to do view transitions, curved edges, advanced view manipulation, etc...
- TextureView
  - TextureView doesn't support DRM (content-protected) playback, however it allows you to tweak the view more.
- You can read more [here](https://source.android.com/docs/core/graphics/arch-tv#surface_or_texture)
  

### Flutter - Hybrid composition
(aka. `initExpensiveAndroidVew`)

- works best with SurfaceView
- uses a separate process to render video frames (offloads the work from the app)
- not very performance efficient on lower Android versions (<10), becuase it does double rendering for each frame.

### Flutter - Texture Layer Hybrid Composition
(aka. `initAndroidView`)

- works best with TextureView
- it has no double-rendering problems
- it does the rendering in the same process as the main application
- it doesn't support DRM

### API

When initializing THEOliveView, you can pass these parameters under `playerConfig`:

```dart
  late THEOlive _theoLive;

  @override
  void initState() {
    super.initState();
  
    _theoLive = THEOlive(
      playerConfig: PlayerConfig(
        AndroidConfig(
          useHybridComposition: false,
          nativeRenderingTarget: AndroidNativeRenderingTarget.textureView
        ),
      ),
      onCreate: () {
        // if you would like to listen to state changes
        _theoLive.setStateListener(() => setState(() {}));

        // automatically load the channel once the view is ready
        _theoLive.loadChannel("2vqqekesftg9zuvxu9tdme6kl");
      });
  }
```

If not specified, the default values are `useHybridComposition: true` and `nativeRenderingTarget: AndroidNativeRenderingTarget.surfaceView`.
