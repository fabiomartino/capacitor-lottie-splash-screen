/**
 * @file web.ts
 * @description Web implementation of the LottieSplashScreen plugin.
 * This implementation is non-functional and serves as a fallback for web platforms.
 */
import { WebPlugin } from '@capacitor/core';
import type { LottieSplashScreenPlugin } from './definitions';
/**
 * @class LottieSplashScreenWeb
 * @extends WebPlugin
 * @implements LottieSplashScreenPlugin
 *
 * Stub implementation for the web. All methods are either no-ops or throw unimplemented exceptions.
 *
 */
export declare class LottieSplashScreenWeb extends WebPlugin implements LottieSplashScreenPlugin {
    /**
     * Show the splash screen (not implemented on web).
     */
    show(): Promise<void>;
    /**
     * Hide the splash screen (not implemented on web).
     */
    hide(): Promise<void>;
    /**
     * Notify that the app has loaded (not implemented on web).
     */
    appLoaded(): Promise<void>;
    /**
     * Check if the splash screen is animating (always false on web).
     *
     * @returns A resolved promise with `{ isAnimating: false }`
     */
    isAnimating(): Promise<{
        isAnimating: boolean;
    }>;
}
