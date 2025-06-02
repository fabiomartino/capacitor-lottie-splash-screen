import Foundation
import Lottie
import UIKit

@objc public enum AnimationEventListener: Int {
    case onAnimationEnd
}

extension AnimationEventListener {
    var listenerEvent: String {
        switch self {
        case .onAnimationEnd:
            return "onAnimationEnd"
        }
    }
}

@objc public class LottieSplashScreen: NSObject {
    
    private var animationView: LottieAnimationView?
    private var isAppLoaded = false
    private var isAnimationEnded = !LottieSplashScreenPlugin.isEnabledStatic
    private var autoHide = false;
    private var loopMode = LottieLoopMode.playOnce;
    
    // Store parameters to allow re-showing the splash screen
    private var backgroundView: UIView?
    private var containerView: UIView?
    private var lottiePath: String?
    private var backgroundColor: UIColor?
    
    public static let TAG: String = "✨  Lottie-Splash-Screen:"
    public typealias AnimationEventListenerCallback = (AnimationEventListener) -> Void
    
    @objc public var onAnimationEvent: AnimationEventListenerCallback?
    
    public func isAnimating() -> Bool {
        return !isAnimationEnded
    }
    
    func onAppLoaded() {
        isAppLoaded = true
        if isAnimationEnded || loopMode == .loop {
            hideSplashScreen()
        }
    }
    
    @objc public func hide() -> Void {
        hideSplashScreen()
    }
    
    // Re-show the splash screen by reinstantiating the animation view
    @objc public func show() -> Void {
        DispatchQueue.main.async {
            guard let containerView = self.containerView,
                  let path = self.lottiePath,
                  let filename = path.components(separatedBy: ".").first else {
                return
            }
            
            self.isAnimationEnded = false
            
            // Criar view de fundo
            self.backgroundView = UIView()
            self.backgroundView!.backgroundColor = self.backgroundColor // ou qualquer cor
            self.backgroundView!.frame = UIScreen.main.bounds
            containerView.addSubview(self.backgroundView!)
            
            // Criar animação Lottie
            self.animationView = .init(name: filename)
            self.animationView!.frame = UIScreen.main.bounds
            self.animationView!.contentMode = .scaleAspectFit
            self.animationView!.loopMode = self.loopMode
            self.animationView!.animationSpeed = 1
            self.animationView!.translatesAutoresizingMaskIntoConstraints = false
            self.backgroundView!.addSubview(self.animationView!)
            
            NSLayoutConstraint.activate([
                self.animationView!.widthAnchor.constraint(equalTo: self.backgroundView!.widthAnchor),
                self.animationView!.heightAnchor.constraint(equalTo: self.backgroundView!.heightAnchor)
            ])
            
            self.animationView!.play { completed in
                if completed || (!completed && self.loopMode == .loop) {
                    self.isAnimationEnded = true
                    self.onAnimationEvent?(.onAnimationEnd)
                    if self.isAppLoaded || self.autoHide {
                        self.hideSplashScreen()
                    }
                }
            }
        }
    }
    
    // Set up the splash, storing values needed for a future 'show'
    public func loadLottie(view: UIView?, path: String?, backgroundColor: String? = nil, autoHide: Bool = false, loopMode: Bool = false) {
        
        
        // Save the container and asset information for re-showing the splash later.
        self.containerView = view
        self.lottiePath = path
        self.backgroundColor = UIColor.capacitor.color(fromHex: backgroundColor!)
        self.autoHide = autoHide
        if(loopMode == true){
            self.loopMode = .loop
        }
        
        
        // Initially display the splash screen.
        self.show()
    }
    
    func hideSplashScreen() {
        print("\(LottieSplashScreen.TAG) Hiding splash screen")
        DispatchQueue.main.async {
            self.animationView?.removeFromSuperview()
            self.backgroundView?.removeFromSuperview()
        }
    }
}
