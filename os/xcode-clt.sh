# Make sure we have Xcode Command Line Tools installed.
if [[ ! -e /Applications/Xcode.app ]]; then
    echo 'Installing Xcode Command Line Tools. NOTE: This may take a while. Follow prompts.'
    sudo xcode-select --install

#     # This should agree to the license agreement for you.
#     if [[ 0 == $? ]]; then
#         sleep 1
#         osascript <<EOD
#             tell application "System Events"
#                 tell process "Install Command Line Developer Tools"
#                     keystroke return
#                     click button "Agree" of window "License Agreement"
#                 end tell
#             end tell
# EOD
#     fi
fi


# TODO: See if we need to accept the license for the currently-installed version of Xcode.
#       The code below is incomplete, but should do that.
#       See the following for help:
#           https://bigfix.me/fixlet/details/3770?force=true
#           https://apple.stackexchange.com/questions/107307/how-can-i-install-the-command-line-tools-completely-from-the-command-line
#           https://stackoverflow.com/questions/8649874/how-do-i-automate-the-installation-of-xcode/27497521#27497521
#
# # Get the current agreed-to license.
# xcode_license_type=$(defaults read /Applications/Xcode.app/Contents/Resources/LicenseInfo licenseType)
# xcode_license_id=$(defaults read /Applications/Xcode.app/Contents/Resources/LicenseInfo licenseID)

# # Get the last accepted license ID.
# if [[ $xcode_license_type == 'GM' ]]; then
#     accepted_xcode_license_id_gm=$(defaults read /Library/Preferences/com.apple.dt.Xcode IDELastGMLicenseAgreedTo)
# else
#     accepted_xcode_license_id_beta=$(defaults read /Library/Preferences/com.apple.dt.Xcode IDELastBetaLicenseAgreedTo)
# fi

# # Try a few different ways to accept the Xcode license programmatcally.
# [[ ! -z $xcode_license_id ]] && sudo /Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild -license accept
# if [[ $xcode_license_type == 'GM' ]]; then
# else
# fi

# if [[ $xcode_license_type.stdout == 'GM' ]]; then
#   defaults write /Library/Preferences/com.apple.dt.Xcode.plist IDELastGMLicenseAgreedTo -string "$xcode_license_id"
# else
#   defaults write /Library/Preferences/com.apple.dt.Xcode.plist IDELastBetaLicenseAgreedTo -string "$xcode_license_id"
# fi


# Print out which Xcode is currently selected.
xcode-select --print-path


# List packages that have been installed via MacOS Installer.
# TODO: Not sure why this is in here.
#pkgutil --pkgs




## NOTE: I've run into cases where the command-line tools are outdated.
## In those cases, I was told to run the following.
## It'd be nice if we could automate this.
# softwareupdate --all --install --force
# sudo rm -rf /Library/Developer/CommandLineTools
# sudo xcode-select --install
