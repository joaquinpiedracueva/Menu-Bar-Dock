//
//  BadgeMonitor.swift
//  MenuBarDock
//

import Cocoa
import ApplicationServices

// Reads notification badge counts from the macOS Dock using the Accessibility API.
// Technique from https://github.com/xiaogdgenuine/Doll — polls AXStatusLabel every second.
class BadgeMonitor {
    private var timer: Timer?
    private var callbacks: [String: (String?) -> Void] = [:] // appName -> callback

    func start() {
        timer?.invalidate()
        let t = Timer(timeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.poll()
        }
        RunLoop.main.add(t, forMode: .common)
        timer = t
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }

    func observe(appName: String, onUpdate: @escaping (String?) -> Void) {
        callbacks[appName] = onUpdate
    }

    func removeObserver(for appName: String) {
        callbacks.removeValue(forKey: appName)
    }

    private func poll() {
        guard AXIsProcessTrusted() else { return }
        guard let dock = NSWorkspace.shared.runningApplications.first(where: { $0.bundleIdentifier == "com.apple.dock" }) else { return }

        let dockElement = AXUIElementCreateApplication(dock.processIdentifier)

        var listsRef: CFTypeRef?
        AXUIElementCopyAttributeValue(dockElement, kAXChildrenAttribute as CFString, &listsRef)
        guard let lists = listsRef as? [AXUIElement] else { return }

        for list in lists {
            var itemsRef: CFTypeRef?
            AXUIElementCopyAttributeValue(list, kAXChildrenAttribute as CFString, &itemsRef)
            guard let items = itemsRef as? [AXUIElement] else { continue }

            for item in items {
                var titleRef: CFTypeRef?
                AXUIElementCopyAttributeValue(item, kAXTitleAttribute as CFString, &titleRef)
                guard let title = titleRef as? String, !title.isEmpty else { continue }
                guard let callback = callbacks[title] else { continue }

                var statusRef: CFTypeRef?
                AXUIElementCopyAttributeValue(item, "AXStatusLabel" as CFString, &statusRef)
                let badge = statusRef as? String
                callback(badge)
            }
        }
    }
}
