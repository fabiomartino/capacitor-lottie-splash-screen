/**
 * @file index.ts
 * @description Entry point for the LottieSplashScreen plugin.
 * This file defines the plugin's registration and export interfaces for all platforms.
 */
import type { LottieSplashScreenPlugin } from './definitions';
/**
 * Registers the `LottieSplashScreen` plugin.
 *
 * - The plugin name `LottieSplashScreen` is used to bridge native implementations with the JavaScript runtime.
 * - On web, a stub implementation is dynamically imported to prevent runtime errors during PWA or dev server use.
 *
 */
declare const LottieSplashScreen: LottieSplashScreenPlugin;
/**
 * Re-export plugin definitions for external TypeScript consumers.
 * This allows direct access to the `LottieSplashScreenPlugin` interface.
 */
export * from './definitions';
/**
 * Exports the registered plugin instance.
 * Users can call methods like `LottieSplashScreen.show()` from their app code.
 */
export { LottieSplashScreen };
