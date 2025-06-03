import type { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'io.ionic.starter',
  appName: 'capacitor-lottie-splash-screen-example',
  webDir: 'www',
  plugins: {
    LottieSplashScreen: {
      enabled: true, // Can be disabled and called manually with .show() & .hide(). Can coexist with @capacitor/splash-screen
      animationLight: 'public/assets/light.json', // Required!
      animationDark: 'public/assets/light.json', // Optional (default: same as animationLight)
      backgroundLight: '#FF0000', // Optional (default: #FFFFFF)
      backgroundDark: '#00FF00', // Optional (default: #000000)
      autoHide: false, // Hide after animation ends - Optional (default: false)
      loop: false, // Enable animation loop - Optional (default: false)
    },
    SplashScreen: {
      launchAutoHide: true, // Disables @capacitor/splash-screen
      launchShowDuration: 0,
    },
  },
};

export default config;
