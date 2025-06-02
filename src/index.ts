import { registerPlugin } from '@capacitor/core';

import type { LottieSplashScreenPlugin } from './definitions';

const LottieSplashScreen = registerPlugin<LottieSplashScreenPlugin>(
  'LottieSplashScreen',
  {
    web: () =>
      import('./web').then(m => new m.LottieSplashScreenWeb()),
  },
);

export * from './definitions';
export { LottieSplashScreen };
