import { registerPlugin } from '@capacitor/core';
const LottieSplashScreen = registerPlugin('LottieSplashScreen', {
    web: () => import('./web').then(m => new m.LottieSplashScreenWeb()),
});
export * from './definitions';
export { LottieSplashScreen };
//# sourceMappingURL=index.js.map