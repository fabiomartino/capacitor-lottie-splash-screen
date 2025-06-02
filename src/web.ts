import { WebPlugin } from '@capacitor/core';

import type { LottieSplashScreenPlugin } from './definitions';

export class LottieSplashScreenWeb extends WebPlugin implements LottieSplashScreenPlugin {
  async show(): Promise<void> {
    console.warn('LottieSplashScreen is not implemented on web.');
  }

  async hide(): Promise<void> {
    console.warn('LottieSplashScreen is not implemented on web.');
  }

  async appLoaded(): Promise<void> {
    console.warn('LottieSplashScreen appLoaded is not implemented on web.');
  }

  async isAnimating(): Promise<{ isAnimating: boolean }> {
    return { isAnimating: false };
  }
}
