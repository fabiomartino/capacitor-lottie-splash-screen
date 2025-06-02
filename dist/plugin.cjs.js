'use strict';

var core = require('@capacitor/core');

const LottieSplashScreen = core.registerPlugin('LottieSplashScreen', {
    web: () => Promise.resolve().then(function () { return web; }).then(m => new m.LottieSplashScreenWeb()),
});

class LottieSplashScreenWeb extends core.WebPlugin {
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

var web = /*#__PURE__*/Object.freeze({
    __proto__: null,
    LottieSplashScreenWeb: LottieSplashScreenWeb
});

exports.LottieSplashScreen = LottieSplashScreen;
//# sourceMappingURL=plugin.cjs.js.map
