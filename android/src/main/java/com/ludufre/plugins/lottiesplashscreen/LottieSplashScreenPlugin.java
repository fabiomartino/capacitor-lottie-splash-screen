package com.ludufre.plugins.lottiesplashscreen;

import android.content.Context;
import android.content.res.Configuration;
import android.os.Build;
import android.util.Log;

import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;

import java.util.Objects;

@CapacitorPlugin(name = "LottieSplashScreen")
public class LottieSplashScreenPlugin extends Plugin {
    private final LottieSplashScreen implementation = new LottieSplashScreen();
    public static boolean isEnabledStatic = true;

    @PluginMethod(returnType = PluginMethod.RETURN_NONE)
    public void show(PluginCall call) {
        ShowLottieSplashScreenDialog();
        call.resolve();
    }

    @PluginMethod(returnType = PluginMethod.RETURN_NONE)
    public void hide(PluginCall call) {
        implementation.hideDialog();
        call.resolve();
    }

    @PluginMethod(returnType = PluginMethod.RETURN_NONE)
    public void appLoaded(PluginCall call) {
        implementation.onAppLoaded();
        call.resolve();
    }

    @PluginMethod
    public void isAnimating(PluginCall call) {
        boolean isAnimating = implementation.isAnimating();
        JSObject ret = new JSObject();
        ret.put("isAnimating", isAnimating);
        call.resolve(ret);
    }

    public void load() {
        if (!isEnabledStatic) {
            Log.e(LottieSplashScreen.TAG, "Not enabled statically (!?)");
            return;
        }
        boolean isEnabled = this.getConfig().getBoolean("enabled", true);

        Log.i(LottieSplashScreen.TAG, "Started");

        if (isEnabled) {
            ShowLottieSplashScreenDialog();
        } else {
            Log.i(LottieSplashScreen.TAG, "Not enabled");
        }
        implementation.setAnimationEventListener(this::onAnimationEvent);
    }

    public void onAnimationEvent(String event) {
        Log.i(LottieSplashScreen.TAG, "onAnimationEvent");
        bridge.triggerWindowJSEvent(event);
        notifyListeners(event, null);
    }

    private void ShowLottieSplashScreenDialog() {
        Context context = this.getContext();

        String animation = this.getConfig().getString("animationLight", "");
        if (animation == "") {
            Log.e(LottieSplashScreen.TAG, "Animation must be provided in ionic.config.ts|json");
            return;
        }
        String backgroundColor = this.getConfig().getString("backgroundLight", "#FFFFFF");

        String darkAnimation = getConfig().getString("animationDark", "");
        String darkBackgroundcolor = getConfig().getString("backgroundDark", "#000000");

        boolean autoHide = getConfig().getBoolean("autoHide", false);
        boolean loopAnimation = getConfig().getBoolean("loop", false);

        if (autoHide && loopAnimation) {
            Log.e(LottieSplashScreen.TAG, "autoHide and loop cannot be true at the same time. Loop will be disabled.");
            loopAnimation = false;
        }

        if (isDarkMode()) {
            Log.i(LottieSplashScreen.TAG, "Dark mode detected. Using dark animation and color");
            if (!Objects.equals(darkAnimation, "")) {
                animation = darkAnimation;
            }
            if (!Objects.equals(darkBackgroundcolor, "")) {
                backgroundColor = darkBackgroundcolor;
            }
        }

        Log.i(LottieSplashScreen.TAG, "Animation path: " + animation);
        Log.i(LottieSplashScreen.TAG, "Background color: " + backgroundColor);
        Log.i(LottieSplashScreen.TAG, "Auto Hide: " + autoHide);
        Log.i(LottieSplashScreen.TAG, "Loop Animation: " + loopAnimation);

        implementation.ShowLottieSplashScreenDialog(context, animation, backgroundColor, autoHide, loopAnimation);
    }

    private boolean isDarkMode(){
        if(Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
        return false;
        }

        int nightModeFlags =
                getContext().getResources().getConfiguration().uiMode &
                        Configuration.UI_MODE_NIGHT_MASK;
        return switch (nightModeFlags) {
            case Configuration.UI_MODE_NIGHT_YES -> true;
            case Configuration.UI_MODE_NIGHT_NO -> false;
            case Configuration.UI_MODE_NIGHT_UNDEFINED -> false;
            default -> false;
        };
    }
}
