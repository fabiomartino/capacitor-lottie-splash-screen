package com.ludufre.plugins.lottiesplashscreen;

import android.animation.Animator;
import android.app.Dialog;
import android.content.Context;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.view.View;
import android.view.WindowManager;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.airbnb.lottie.LottieAnimationView;
import com.airbnb.lottie.LottieDrawable;
import com.capacitor.lottie.R;

public class LottieSplashScreen {

    interface AnimationEventListener{
        void onAnimationEvent(String event);
    }

    @Nullable
    AnimationEventListener animationEventListener;
    private boolean isAppLoaded = false;
    private boolean autoHide = false;
    private boolean loopMode = false;
    private String backgroundColor;
    final public static String TAG = "Lottie-Splash-Screen:";
    private boolean isAnimationEnded = !LottieSplashScreenPlugin.isEnabledStatic;
    final public static String ON_ANIMATION_END = "onAnimationEnd";
    private LottieAnimationView lottieAnimationView;

    Dialog dialog = null;

    public void setAnimationEventListener(@Nullable AnimationEventListener animationEventListener) {
        this.animationEventListener = animationEventListener;
    }

    public void onAppLoaded() {
        isAppLoaded = true;
        if(isAnimationEnded || loopMode){
            hideDialog();
        }
    }
    public void hideDialog() {
        if (dialog != null) {
            dialog.cancel();
        }
    }

    public boolean isAnimating() {
        return !isAnimationEnded;
    }

    public void ShowLottieSplashScreenDialog(Context context, String lottiePath, String backgroundColor, boolean autoHide, boolean loopAnimation) {
        new Handler(Looper.getMainLooper()).post(() -> {
            if (dialog != null) {
                lottieAnimationView.playAnimation();
                dialog.show();
                return;
            }

            this.autoHide = autoHide;
            this.loopMode = loopAnimation;
            this.backgroundColor = backgroundColor;

            dialog = new Dialog(context, R.style.AppTheme_LottieSplashScreen);

            dialog.setContentView(R.layout.activity_lottie_splash_screen);
            dialog.setCancelable(false);

            loadLottie(dialog, lottiePath);

            View decorView = dialog.getWindow().getDecorView();
            int uiOptions = decorView.getSystemUiVisibility();
            uiOptions |= View.SYSTEM_UI_FLAG_LAYOUT_STABLE | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN;
            decorView.setSystemUiVisibility(uiOptions);
            dialog.getWindow().setStatusBarColor(Color.TRANSPARENT);
            dialog.getWindow().setFlags(WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS, WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS);
            // Definindo a cor de fundo do dialog para #FF0000
            dialog.getWindow().setBackgroundDrawable(new ColorDrawable(Color.parseColor(backgroundColor)));

            dialog.show();
        });
    }

    private void loadLottie(Dialog dialog, String lottiePath) {
        lottieAnimationView = dialog.findViewById(R.id.animationView);
        lottieAnimationView.setAnimation(lottiePath);
        lottieAnimationView.setRepeatCount(loopMode ? 999_999 : 0);
        lottieAnimationView.setSpeed(1F);
        lottieAnimationView.playAnimation();
        lottieAnimationView.addAnimatorListener(new Animator.AnimatorListener() {
            @Override
            public void onAnimationStart(@NonNull Animator animator) {
                Log.i("LOG", "Check");
            }

            @Override
            public void onAnimationEnd(@NonNull Animator animation) {
                try {
                    isAnimationEnded = true;
                    animationEventListener.onAnimationEvent(ON_ANIMATION_END);
                    if (autoHide) {
                        hideDialog();
                    }
                } catch (Exception ex) {
                    ex.toString();
                }
            }

            @Override
            public void onAnimationCancel(@NonNull Animator animator) {
            }

            @Override
            public void onAnimationRepeat(@NonNull Animator animator) {
            }

        });
    }

}
