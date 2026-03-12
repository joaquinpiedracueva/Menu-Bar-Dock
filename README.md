# MenuBarDock

Shows your running and pinned apps as icons in the macOS menu bar — with notification badges mirrored from the Dock.

![Preview](./assets/menu-bar-dock-preview.png)

![Preferences](./assets/menu-bar-dock-prefs.png)

## Features

- **App icons in the menu bar** — click to open, right-click for options (hide, quit, reveal in Finder)
- **Notification badges** — badge counts from the Dock are displayed directly on the menu bar icons
- **Running apps** — automatically shows your currently open apps
- **Pinned apps** — add any app to always show it regardless of whether it's running
- **Customizable** — adjust icon size, slot width, sorting, and opening behavior per app
- **Launch at login** — start automatically when you log in

## Requirements

- macOS 10.15 or later
- Xcode 13 or later
- [CocoaPods](https://cocoapods.org) — install with `sudo gem install cocoapods`

## Run locally

**1. Clone the repo**
```bash
git clone https://github.com/joaquinpiedracueva/menubar-sentry.git
cd menubar-sentry
```

**2. Install dependencies**
```bash
pod install
```

**3. Open the workspace** (not the `.xcodeproj`)
```bash
open MenuBarDock.xcworkspace
```

**4. Configure signing**

In Xcode, select the **MenuBarDock** target → **Signing & Capabilities** → uncheck **Automatically manage signing** → set **Signing Certificate** to **Sign to Run Locally**. Repeat for the **Launcher** target. No developer account needed.

**5. Build and run**

Press **Cmd+R**. The app will appear in your menu bar.

**6. Grant Accessibility permission**

On first launch macOS will prompt for Accessibility access — this is required for notification badges to work. You can also add it manually in **System Settings → Privacy & Security → Accessibility**.

## Install to Applications

After a successful build in Xcode:

1. In the left sidebar, expand the **Products** group
2. Right-click **MenuBarDock.app** → **Show in Finder**
3. Drag the `.app` to your **Applications** folder
