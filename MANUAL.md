# Manual Configuration

These are configuration items that need to be done manually.
Hopefully, many of them will eventually be automated.
(Use prefsniff to help automate.)

These are currently for MacOS Ventura (13), but will be migrating to Sonoma (14) soon.

## Host Name

NOTE: Using `sudo hostname 'my-host-name'` gets reverted every minute or so.
Changing it in System Settings -> General -> About does not change the HostName.

~~~ shell
sudo /Applications/Xcode.app/Contents/MacOS/Xcode /Library/Preferences/SystemConfiguration/preferences.plist
~~~

System -> System

- ComputerName: $HOST
- HostName: $HOST

## Firewall

System Settings -> Network -> Firewall

- ENABLE Firewall
- Options
    - DISABLE Block all incoming connections
        - because I often run web services
    - REMOVE any apps that are not needed
        - I actually removed **all** of them
            - I allowed `rapportd` when prompted
                - it allows Handoff communication between Apple devices
    - DISABLE Automatically allow built-in software to receive incoming connections
        - because I want to enable each app individually
    - DISABLE Automatically allow downloaded signed software to receive incoming connections
        - because I want to enable each app individually
    - ENABLE Enable stealth mode
        - for extra security

## Login Items

System Settings -> General -> Login Items

- UNCHECK as many things as possible

## Displays

System Settings -> Displays

- Arrange screens to match their physical locations
- Set Main display to 1352 x 878 on 14" MacBook Pro
    - Slightly larger text than Default

System Settings -> Displays -> Night Shift

- Schedule: Sunset to Sunrise

System Settings -> Wallpaper

- Set all monitors to Auto-Rotate Backgrounds
    - NOTE: Be sure there are appropriate background images in ~/Pictures/Backgrounds
    - Add Folder: ~/Pictures/Backgrounds
- Change picture: Every Hour
    - CHECK Randomly

System Settings -> Desktop & Dock

- Mission Control
    - CHECK Displays have separate Spaces
        - This should show a menu bar on each screen
    - Shortcuts
        - Mission Control: (none)
            - Use 4-finger up gesture
        - Application windows: (none)
            - Use 4-finger down gesture
        - Show Desktop: (none)

System Settings -> Screen Saver

- Set to Random

## Power

System Settings -> Battery

- Low Power Mode: Only on Battery

System Settings -> Displays -> Advanced

- CHECK Slightly dim the display on battery
- CHECK Prevent automatic sleeping on power adapter when the display is off

## Dock

System Settings -> Desktop & Dock

- CHECK Minimize windows into application icon

## Sound

Audio MIDI Setup

+ -> Create Multi-Output Device

- Select USB Audio Device
- Rename to "Headphone jack - iVanky Hub"

## Finder

Settings / General

* New Finder window shows: Home directory

Settings / Advanced

* When performing a search: Search the current folder


## Dictation, Speech, and Voice Control

System Settings -> Accessibility -> Motor -> Voice Control

- ENABLE Voice Control
    - Shortcut: Press Fn key twice
        - NOTE: This is the default shortcut

System Settings -> Keyboard -> Dictation

- ENABLE Dictation
    - Shortcut: Press 🎤 key
        - TODO: Consider changing this to a different key:
            - Right Command key twice
                - NOTE: KeyClu is Left Command key twice and hold
            - Control key twice
            - NOTE: Right Shift key twice is mapped to command palette / Paletro
        - TODO: Use Karabiner to map keys on external and internal keyboard
            - External keyboard: 🎤 key
                - NOTE: Consider using that key for other things
            - Internal keyboard: ???
                - Right Command key twice?

## Visual Studio Code (VS Code)

### Enable Remote Editing

- Command+P
    - Remote Tunnels: Turn on Remote Tunnel Access...


## Safari

TODO: See **Mac Setup (personal)** in Notes

### Settings

#### General

- Safari opens with: All windows from last session
- New windows open with: Start Page
- New tabs open with: Start Page
- Remove history items: After one year

#### Privacy

- Website tracking: ENABLE Prevent cross-site tracking

#### Websites

- Auto-Play
    - When visiting other websites: Never Auto-Play
- Pop-up Windows
    - When visiting other websites: Block and Notify

#### Advanced

- ENABLE Show features for web developers

### Start Page

- ENABLE Recently Closed Tabs
    - move it to the top
- DISABLE Suggestions
- DISABLE Shared with You
- DISABLE Background Image

### Extensions


## Work

Remove from Dock:

- Music
- News
- Numbers
- Keynote
- Pages
- App Store

Keep in Dock:

- Slack
