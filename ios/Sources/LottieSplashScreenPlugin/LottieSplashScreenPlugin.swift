//
//  LottieSplashScreenPlugin.swift
//  LottieSplashScreenPlugin
//
//  @description Capacitor bridge class for exposing Lottie splash screen to JS.
//

import Capacitor
import Foundation

/// Capacitor plugin entry point for Lottie splash screen features
@objc(LottieSplashScreenPlugin)
public class LottieSplashScreenPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "LottieSplashScreenPlugin"
    public let jsName = "LottieSplashScreen"

    /// Plugin method bindings exposed to JavaScript
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "hide", returnType: CAPPluginReturnNone),
        CAPPluginMethod(name: "show", returnType: CAPPluginReturnNone),
        CAPPluginMethod(name: "appLoaded", returnType: CAPPluginReturnNone),
        CAPPluginMethod(name: "isAnimating", returnType: CAPPluginReturnPromise),
    ]
    public static var isEnabledStatic = true
    private let implementation = LottieSplashScreen()

    /// JS → Native: Show the splash screen again
    @objc func show(_ call: CAPPluginCall) {
        implementation.show();
        call.resolve();
    }

    /// JS → Native: Hide the splash screen immediately
    @objc func hide(_ call: CAPPluginCall) {
        implementation.hide();
        call.resolve();
    }

    /// JS → Native: Notify the plugin that the app has loaded
    @objc func appLoaded(_ call: CAPPluginCall) {
        implementation.onAppLoaded()
        call.resolve();
    }

    /// Plugin lifecycle hook called after plugin is loaded
    override public func load() {
        guard LottieSplashScreenPlugin.isEnabledStatic else {
            log("Not enabled statically (!?)")
            return
        }
        let isEnabled = getConfig().getBoolean("enabled", true)
        
        log("Started")
        
        if isEnabled {
            var animation = getConfig().getString("animationLight", "")
            if (animation == ""){
                log("Animation must be provided in ionic.config.ts|json")
                return
            }
            var backgroundColor = getConfig().getString("backgroundLight", "#FFFFFF")
            
            let darkAnimation = getConfig().getString("animationDark", "")
            let darkBackgroundColor = getConfig().getString("backgroundDark", "#000000")
            
            let autoHide = getConfig().getBoolean("autoHide", false)
            var loopAnimation =  getConfig().getBoolean("loop", false)
            
            if autoHide, loopAnimation {
                log("autoHide and loop cannot be true at the same time. Loop will be disabled.")
                loopAnimation = false
            }
            
            if #available(iOS 13.0, *), UITraitCollection.current.userInterfaceStyle == .dark {
                log("Dark mode detected. Using dark animation and color")
                if darkAnimation != "" {
                    animation = darkAnimation
                }
                if darkBackgroundColor != "" {
                    backgroundColor = darkBackgroundColor
                }
            }
            
            log("Animation path:", animation)
            log("Background color:", backgroundColor)
            log("Auto Hide:", autoHide)
            log("Loop Animation:", loopAnimation)
            
            implementation.loadLottie(
                view: self.bridge?.viewController?.view,
                path: animation,
                backgroundColor: backgroundColor,
                autoHide: autoHide,
                loopMode: loopAnimation)
        }else{
            log("Not enabled")
        }
        implementation.onAnimationEvent = onAnimationEvent
    }

    /// Internal listener callback triggered on animation end
    public func onAnimationEvent(event: AnimationEventListener) {
        log("onAnimationEvent", event.listenerEvent)
        self.bridge?.triggerWindowJSEvent(eventName: event.listenerEvent)
        self.notifyListeners(event.listenerEvent, data: nil)
    }

    /// JS → Native: Check if the splash screen is animating
    @objc func isAnimating(_ call: CAPPluginCall) {
        call.resolve([
            "isAnimating": implementation.isAnimating()
        ])
    }
    
}
