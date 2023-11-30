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


## Visual Studio Code (VS Code)

### Enable Remote Editing

- Command+P
    - Remote Tunnels: Turn on Remote Tunnel Access...


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
