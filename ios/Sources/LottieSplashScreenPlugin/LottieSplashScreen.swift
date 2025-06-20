//
//  LottieSplashScreen.swift
//  LottieSplashScreenPlugin
//
//  @description Native Swift logic for showing and hiding a Lottie-based splash screen overlay.
//

import Foundation
import Lottie
import UIKit
import Capacitor

/// Enumeration for supported animation lifecycle events
@objc public enum AnimationEventListener: Int {
    case onAnimationEnd
}

extension AnimationEventListener {
    /// JavaScript-friendly event string
    var listenerEvent: String {
        switch self {
        case .onAnimationEnd:
            return "onAnimationEnd"
        }
    }
}

/// Core controller class for managing the Lottie splash screen lifecycle
@objc public class LottieSplashScreen: NSObject {

    // MARK: - Internal State

    private var animationView: LottieAnimationView?
    private var isAppLoaded = false
    private var isAnimationEnded = !LottieSplashScreenPlugin.isEnabledStatic
    private var autoHide = false
    private var loopMode = LottieLoopMode.playOnce

    // Store parameters to allow re-showing the splash screen
    private var backgroundView: UIView?
    private var containerView: UIView?
    private var lottiePath: String?
    private var backgroundColor: UIColor?

    public typealias AnimationEventListenerCallback = (AnimationEventListener) -> Void

    @objc public var onAnimationEvent: AnimationEventListenerCallback?

    // MARK: - Public API

    /// Check whether the splash animation is currently active
    public func isAnimating() -> Bool {
        return !isAnimationEnded
    }

    /// Notify the plugin that the app has fully loaded
    func onAppLoaded() {
        isAppLoaded = true
        if isAnimationEnded || loopMode == .loop {
            hideSplashScreen()
        }
    }

    /// Hide the splash screen immediately
    @objc public func hide() {
        hideSplashScreen()
    }

    /// Show the splash screen again programmatically
    @objc public func show() {
        DispatchQueue.main.async {
            guard let containerView = self.containerView,
                  let path = self.lottiePath,
                  let filename = path.components(separatedBy: ".").first else {
                return
            }

            self.isAnimationEnded = false

            // Set up background
            self.backgroundView = UIView()
            self.backgroundView!.backgroundColor = self.backgroundColor
            self.backgroundView!.frame = UIScreen.main.bounds
            containerView.addSubview(self.backgroundView!)

            // Set up Lottie animation
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

    /// Initialize the splash screen with animation and color configuration
    public func loadLottie(view: UIView?, path: String?, backgroundColor: String? = nil, autoHide: Bool = false, loopMode: Bool = false) {

        // Save the container and asset information for re-showing the splash later.
        self.containerView = view
        self.lottiePath = path
        self.backgroundColor = UIColor.capacitor.color(fromHex: backgroundColor!)
        self.autoHide = autoHide
        if loopMode == true {
            self.loopMode = .loop
        }

        // Initially display the splash screen.
        self.show()
    }

    // MARK: - Internal Methods

    func hideSplashScreen() {
        log("Hiding splash screen")
        DispatchQueue.main.async {
            self.animationView?.removeFromSuperview()
            self.backgroundView?.removeFromSuperview()
        }
    }
}
