/**
 * @file web.ts
 * @description Web implementation of the LottieSplashScreen plugin.
 * This implementation is non-functional and serves as a fallback for web platforms.
 */
import { WebPlugin } from '@capacitor/core';
/**
 * @class LottieSplashScreenWeb
 * @extends WebPlugin
 * @implements LottieSplashScreenPlugin
 *
 * Stub implementation for the web. All methods are either no-ops or throw unimplemented exceptions.
 *
 */
export class LottieSplashScreenWeb extends WebPlugin {
    /**
     * Show the splash screen (not implemented on web).
     */
    async show() {
        console.warn('LottieSplashScreen show() is not supported on web.');
        return Promise.resolve();
        // throw this.createUnimplementedError();
    }
    /**
     * Hide the splash screen (not implemented on web).
     */
    async hide() {
        console.warn('LottieSplashScreen hide() is not supported on web.');
        return Promise.resolve();
        // throw this.createUnimplementedError();
    }
    /**
     * Notify that the app has loaded (not implemented on web).
     */
    async appLoaded() {
        console.warn('LottieSplashScreen appLoaded() is not supported on web.');
        return Promise.resolve();
        // throw this.createUnimplementedError();
    }
    /**
     * Check if the splash screen is animating (always false on web).
     *
     * @returns A resolved promise with `{ isAnimating: false }`
     */
    async isAnimating() {
        return { isAnimating: false };
    }
}
//# sourceMappingURL=web.js.map