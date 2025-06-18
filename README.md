<p align="center"><br><img src="https://user-images.githubusercontent.com/236501/85893648-1c92e880-b7a8-11ea-926d-95355b8175c7.png" width="128" height="128" /></p>
<h3 align="center">Lottie Splash Screen</h3>
<p align="center"><strong><code>capacitor-lottie-splash-screen</code></strong></p>
<p align="center">
  Lottie Splash Screen plugin for Ionic Capacitor
</p>

<p align="center">
  <img src="https://img.shields.io/maintenance/yes/2025?style=flat-square" />
  <a href="https://www.npmjs.com/package/capacitor-lottie-splash-screen"><img src="https://img.shields.io/npm/l/capacitor-lottie-splash-screen?style=flat-square" /></a>
  <a href="https://www.npmjs.com/package/capacitor-lottie-splash-screen"><img src="https://img.shields.io/npm/dw/capacitor-lottie-splash-screen?style=flat-square" /></a>
  <a href="https://www.npmjs.com/package/capacitor-lottie-splash-screen"><img src="https://img.shields.io/npm/v/capacitor-lottie-splash-screen?style=flat-square" /></a>
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
<a href="#contributors-"><img src="https://img.shields.io/badge/all%20contributors-0-orange?style=flat-square" /></a>
<!-- ALL-CONTRIBUTORS-BADGE:END -->
<br />
<a href="https://www.buymeacoffee.com/ludufre"><img src="https://img.shields.io/badge/Buy%20me%20a%20coffee-ludufre-fce802?style=flat-square" alt="Buy me a coffee"></a>
</p>

## Preview

<div align="center">
  <img src="./example-app/src/assets/ios.gif" alt="Preview" width="150" style="max-width:150px;">
  <img src="./example-app/src/assets/android.gif" alt="Preview" width="150" style="max-width:150px;"><br>
  
  [Angular Example](./example-app/README.md)
</div>

## Maintainers

| Maintainer             | GitHub                                | Social                            | LinkedIn                                                           |
| ---------------------- | ------------------------------------- | --------------------------------- | ------------------------------------------------------------------ |
| Luan Freitas (ludufre) | [ludufre](https://github.com/ludufre) | [@ludufre](https://x.com/ludufre) | [Luan Freitas](https://www.linkedin.com/in/luan-freitas-14341687/) |

## Installation

```bash
npm install capacitor-lottie-splash-screen
npx cap sync

# or using pnpm
pnpm add capacitor-lottie-splash-screen
npx cap sync
```

Add to `capacitor.config.ts` or `capcitor.config.json`

```typescript
const config: CapacitorConfig = {
  ...
  LottieSplashScreen: {
    enabled: true, // Enables the Lottie splash (can still be shown manually)
    animationLight: 'public/assets/[path/to.json]', // REQUIRED: Path to Lottie file for light mode
    animationDark: 'public/assets/[path/to.json]',   // Optional: Lottie for dark mode (defaults to animationLight)
    backgroundLight: '#FFFFFF', // Optional: background color in light mode (default: #FFFFFF)
    backgroundDark: '#000000', // Optional: background color in dark mode (default: #000000)
    autoHide: false, // Auto-hide after animation ends (if false, call appLoaded manually)
    loop: false,     // Loop animation (not recommended with autoHide: true)
  },
  SplashScreen: {
    launchAutoHide: true, // Disables @capacitor/splash-screen
    launchShowDuration: 0
  },
  ...
};
```

### **⚠️ Important Notes!**

- **autoHide true:**

  - The splash screen will hide automatically after the animation ends.
  - If you call `LottieSplashScreen.appLoaded()` _before_ the animation ends, it will wait until the animation finishes.
  - Calling `LottieSplashScreen.hide()` will hide it immediately without waiting for the end.

- **autoHide false (default):**

  - You must call `LottieSplashScreen.appLoaded()` to hide the splash screen after your app is loaded. If you do not call it, the splash screen will remain visible indefinitely with last frame displayed.

- **Loop behavior:**

  - If `loop` is `true`, the animation will continue looping until `LottieSplashScreen.appLoaded()` is called (which stops it immediately).
  - To play the animation only once, set `loop` to `false` (default behavior).
  - Tip: If `loop: true` and `autoHide: true`, the plugin will disable looping automatically (they’re incompatible). Use `loop: true` only when you’re controlling the splash manually.

- **Manual display:**
  - When calling `LottieSplashScreen.show()`, the splash screen appears and starts playing the animation immediately.
  - You must call `LottieSplashScreen.hide()` to remove the splash screen; the animation end is not waited for.

## Example

See the [Angular Example](./example-app/README.md) for a complete example of how to use the plugin in an Ionic Angular application.

Call `LottieSplashScreen.appLoaded();` when the App is ready.

```typescript
// Splash screen will only close after this call and the animation ends unless you set "autoHide: true" which will hide it automatically.
import { Platform } from '@ionic/angular';
import { LottieSplashScreen } from 'capacitor-lottie-splash-screen';

constructor(private platform: Platform) {
  this.platform.ready().then(() => {
    // Call this AFTER the app is ready and bootstrapped
    LottieSplashScreen.appLoaded();
  });
}

// Another way with Angular provideAppInitializer() (reaplces APP_INITIALIZER) to ensure the app is loaded before proceeding
bootstrapApplication(AppComponent, {
  providers: [
    ...,
    provideAppInitializer(async () => {
      await inject(...).init(); // Your initialization logic here
      await LottieSplashScreen.appLoaded();
    }),
    ...
  ],
})...

// Programmatically show the splash screen
LottieSplashScreen.show();

// Programmatically hide the splash screen (without waiting for animation end)
LottieSplashScreen.hide();

// Check if the splash screen is animating
LottieSplashScreen.isAnimating().then((result) => {
  console.log('Is animating:', result.isAnimating);
});

// Add a listener for the animation end event
LottieSplashScreen.addListener('onAnimationEnd', () => {
  console.log('Animation ended');
});
```

## Highly Inspired / Credits

- https://github.com/Get-Local/capacitor-lottie-splash-screen
- https://github.com/MorphoodInc/capacitor-lottie-splash-screen
- https://github.com/muhammadosmanali/capacitor-lottie-splash-screen

<a href="https://www.buymeacoffee.com/ludufre"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png"></a>

## API

<docgen-index>

* [`appLoaded()`](#apploaded)
* [`show()`](#show)
* [`hide()`](#hide)
* [`isAnimating()`](#isanimating)
* [`addListener('onAnimationEnd', ...)`](#addlisteneronanimationend-)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### appLoaded()

```typescript
appLoaded() => void
```

Notify the plugin that the app has fully loaded.

Call this method as early as possible after your app has bootstrapped.
It allows the plugin to gracefully finish or remove the splash animation overlay.
If the splash is configured to loop, this will forcibly stop it.

**Since:** 7.0.0

--------------------


### show()

```typescript
show() => void
```

Programmatically show the splash screen animation again.

This is useful for scenarios like restarting the splash for a specific action or navigation flow.

**Since:** 7.0.0

--------------------


### hide()

```typescript
hide() => void
```

Hide the splash screen immediately, skipping the animation completion.

Use this when you want to forcefully remove the splash overlay (e.g., on error or timeout).

**Since:** 7.0.0

--------------------


### isAnimating()

```typescript
isAnimating() => Promise<{ isAnimating: boolean; }>
```

Check if the splash animation is currently running.

Returns a boolean wrapped in a promise indicating the splash screen’s active state.

**Returns:** <code>Promise&lt;{ isAnimating: boolean; }&gt;</code>

**Since:** 7.0.0

--------------------


### addListener('onAnimationEnd', ...)

```typescript
addListener(eventName: 'onAnimationEnd', listenerFunc: () => void) => Promise<PluginListenerHandle>
```

Register a listener for the splash animation end event.

This event is triggered once the animation finishes and the overlay is removed.

| Param              | Type                          | Description                                                   |
| ------------------ | ----------------------------- | ------------------------------------------------------------- |
| **`eventName`**    | <code>'onAnimationEnd'</code> | - Must be `'onAnimationEnd'`                                  |
| **`listenerFunc`** | <code>() =&gt; void</code>    | - A callback function that runs when the animation completes. |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

**Since:** 7.0.0

--------------------


### Interfaces


#### PluginListenerHandle

| Prop         | Type                                      |
| ------------ | ----------------------------------------- |
| **`remove`** | <code>() =&gt; Promise&lt;void&gt;</code> |

</docgen-api>
