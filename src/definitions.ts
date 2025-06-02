import type { PluginListenerHandle } from '@capacitor/core';

export interface LottieSplashScreenPlugin {
  /**
   * Indicate to the plugin that the app has loaded.
   *
   * Run as early as possible when your app is loaded.
   * This will ensure that on animation end the layer of the splash screen is removed
   * and touch interactions will go to the app.
   *
   * If `loop` is set to `true` the splash screen will be terminated immediately.
   **/
  appLoaded(): void;

  /**
   * Show the splash screen programatically.
   **/
  show(): void;

  /**
   * Hide the splash screen.
   *
   * This will hide the splash screen without waiting for animation end.
   **/
  hide(): void;

  /**
   * Check if the splash screen is currently animating.
   */
  isAnimating(): Promise<{ isAnimating: boolean }>;

  /**
   * Add a listener for the 'onAnimationEnd' event.
   *
   * This event is triggered when the splash screen animation ends.
   */
  addListener(eventName: 'onAnimationEnd', listenerFunc: () => void): Promise<PluginListenerHandle>;
}
