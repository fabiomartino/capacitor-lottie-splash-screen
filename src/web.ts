/**
 * @file web.ts
 * @description Web implementation of the LottieSplashScreen plugin.
 * This implementation is non-functional and serves as a fallback for web platforms.
 */

import { CapacitorException, ExceptionCode, WebPlugin } from '@capacitor/core';
import type { LottieSplashScreenPlugin } from './definitions';

/**
 * @class LottieSplashScreenWeb
 * @extends WebPlugin
 * @implements LottieSplashScreenPlugin
 *
 * Stub implementation for the web. All methods are either no-ops or throw unimplemented exceptions.
 *
 */
export class LottieSplashScreenWeb extends WebPlugin implements LottieSplashScreenPlugin {
  /**
   * Show the splash screen (not implemented on web).
   */
  async show(): Promise<void> {
    console.warn('LottieSplashScreen show() is not supported on web.');
    throw this.createUnimplementedError();
  }

  /**
   * Hide the splash screen (not implemented on web).
   */
  async hide(): Promise<void> {
    console.warn('LottieSplashScreen hide() is not supported on web.');
    throw this.createUnimplementedError();
  }

  /**
   * Notify that the app has loaded (not implemented on web).
   */
  async appLoaded(): Promise<void> {
    console.warn('LottieSplashScreen appLoaded() is not supported on web.');
    throw this.createUnimplementedError();
  }

  /**
   * Check if the splash screen is animating (always false on web).
   *
   * @returns A resolved promise with `{ isAnimating: false }`
   */
  async isAnimating(): Promise<{ isAnimating: boolean }> {
    return { isAnimating: false };
  }

  /**
   * Create a standardized exception for unimplemented web methods.
   *
   * @returns {CapacitorException} A descriptive exception with `Unimplemented` code.
   */
  private createUnimplementedError(): CapacitorException {
    return new CapacitorException(
      'LottieSplashScreen is not supported on the web.',
      ExceptionCode.Unimplemented
    );
  }
}