import { WebPlugin } from '@capacitor/core';
export class LottieSplashScreenWeb extends WebPlugin {
    async show() {
        console.warn('LottieSplashScreen is not implemented on web.');
    }
    async hide() {
        console.warn('LottieSplashScreen is not implemented on web.');
    }
    async appLoaded() {
        console.warn('LottieSplashScreen appLoaded is not implemented on web.');
    }
    async isAnimating() {
        return { isAnimating: false };
    }
}
//# sourceMappingURL=web.js.map