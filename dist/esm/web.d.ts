import { WebPlugin } from '@capacitor/core';
import type { LottieSplashScreenPlugin } from './definitions';
export declare class LottieSplashScreenWeb extends WebPlugin implements LottieSplashScreenPlugin {
    show(): Promise<void>;
    hide(): Promise<void>;
    appLoaded(): Promise<void>;
    isAnimating(): Promise<{
        isAnimating: boolean;
    }>;
}
