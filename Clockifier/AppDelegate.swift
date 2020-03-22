//
//  AppDelegate.swift
//  Clockifier
//
//  Created by Filippo Zaffoni on 21/03/2020.
//  Copyright © 2020 Filippo Zaffoni. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    // MARK: - Properties

    var window: NSWindow!
    
    var menuBarVC: NSPopover! { didSet {  } }
    var statusBarItem: NSStatusItem!

    var authManager    = AuthManager.shared
    var networkManager = NetworkManager.shared
    
    // MARK: - Lifecycle

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let rootView   = ContentView()
        setupPopOver(on: rootView)
        setupStatusBarItem()
    }

    func applicationWillTerminate(_ aNotification: Notification) { }
    
    func applicationWillResignActive(_ notification: Notification) { menuBarVC.performClose(nil) }
}

private extension AppDelegate {
    
    func setupPopOver(on rootView: ContentView) {
        let menuPopOver: NSPopover = {
            let _popover = NSPopover()
            _popover.contentSize           = NSSize(width: 400, height: 400)
            _popover.behavior              = .semitransient
            _popover.contentViewController = NSHostingController(
                rootView: rootView.environmentObject(authManager)
            )
            _popover.animates              = true
            return _popover
        }()

        WindowManager.shared.popOver = menuPopOver
        menuBarVC                    = menuPopOver
    }

    func setupStatusBarItem() {
        statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))

        if let button = statusBarItem.button {
             button.image  = NSImage(named: "icon_clean")
             button.action = #selector(togglePopover(_:))
        }
    }

    @objc
    func togglePopover(_ sender: AnyObject?) {
        guard let button = statusBarItem.button else { return }

        if menuBarVC.isShown {
            menuBarVC.performClose(sender)
        } else {
            menuBarVC.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            menuBarVC.contentViewController?.view.window?.becomeKey()
            NSApp.activate(ignoringOtherApps: true)
        }
    }
}
