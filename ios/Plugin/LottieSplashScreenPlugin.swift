import Capacitor
import Foundation

@objc(LottieSplashScreenPlugin)
public class LottieSplashScreenPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "LottieSplashScreenPlugin"
    public let jsName = "LottieSplashScreen"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "hide", returnType: CAPPluginReturnNone),
        CAPPluginMethod(name: "show", returnType: CAPPluginReturnNone),
        CAPPluginMethod(name: "appLoaded", returnType: CAPPluginReturnNone),
        CAPPluginMethod(name: "isAnimating", returnType: CAPPluginReturnPromise),
    ]
    public static var isEnabledStatic = true
    private let implementation = LottieSplashScreen()
    
    @objc func show(_ call: CAPPluginCall) {
        implementation.show();
        call.resolve();
    }
    
    @objc func hide(_ call: CAPPluginCall) {
        implementation.hide();
        call.resolve();
    }
    
    @objc func appLoaded(_ call: CAPPluginCall) {
        implementation.onAppLoaded()
        call.resolve();
    }
    
    override public func load() {
        if !LottieSplashScreenPlugin.isEnabledStatic {
            print("\(LottieSplashScreen.TAG) Not enabled statically (!?)")
            return
        }
        let isEnabled = getConfig().getBoolean("enabled", true)
        
        print("\(LottieSplashScreen.TAG) Started")
        
        if isEnabled {
            var animation = getConfig().getString("animationLight", "")
            if (animation == ""){
                NSLog("\(LottieSplashScreen.TAG) Animation must be provided in ionic.config.ts|json")
                return
            }
            var backgroundColor = getConfig().getString("backgroundLight", "#FFFFFF")
            
            let darkAnimation = getConfig().getString("animationDark", "")
            let darkBackgroundColor = getConfig().getString("backgroundDark", "#000000")
            
            let autoHide = getConfig().getBoolean("autoHide", false)
            var loopAnimation =  getConfig().getBoolean("loop", false)
            
            if autoHide, loopAnimation {
                NSLog("\(LottieSplashScreen.TAG) autoHide and loop cannot be true at the same time. Loop will be disabled.")
                loopAnimation = false
            }
            
            if #available(iOS 13.0, *), UITraitCollection.current.userInterfaceStyle == .dark {
                print("\(LottieSplashScreen.TAG) Dark mode detected. Using dark animation and color")
                if darkAnimation != "" {
                    animation = darkAnimation
                }
                if darkBackgroundColor != "" {
                    backgroundColor = darkBackgroundColor
                }
            }
            
            print("\(LottieSplashScreen.TAG) Animation path: \(animation ?? "")")
            print("\(LottieSplashScreen.TAG) Background color: \(backgroundColor ?? "")")
            print("\(LottieSplashScreen.TAG) Auto Hide: \(autoHide)")
            print("\(LottieSplashScreen.TAG) Loop Animation: \(loopAnimation)")
            
            implementation.loadLottie(
                view: self.bridge?.viewController?.view,
                path: animation,
                backgroundColor: backgroundColor,
                autoHide: autoHide,
                loopMode: loopAnimation)
        }else{
            print("\(LottieSplashScreen.TAG) Not enabled")
        }
        implementation.onAnimationEvent = onAnimationEvent
    }
    
    public func onAnimationEvent(event: AnimationEventListener) {
        print("\(LottieSplashScreen.TAG) onAnimationEvent", event.listenerEvent)
        self.bridge?.triggerWindowJSEvent(eventName: event.listenerEvent)
        self.notifyListeners(event.listenerEvent, data: nil)
    }
    
    @objc func isAnimating(_ call: CAPPluginCall) {
        call.resolve([
            "isAnimating": implementation.isAnimating()
        ])
    }
    
}
