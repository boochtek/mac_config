# Make sure we have Xcode Command Line Tools installed.
if ! xcode-select --print-path > /dev/null ; then
    echo 'Installing Xcode Command Line Tools. NOTE: This may take a while. Follow prompts.'

    while ! pkgutil --pkg-info=com.apple.pkg.CLTools_Executables > /dev/null ; do
        if [ -z "$xcode_cli_installing" ]; then
            xcode-select --install
            xcode_cli_installing='yes'
        else
            sleep 1
        fi
    done
    echo 'Xcode Command Line Tools have been installed.'
fi


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


## NOTE: I've run into cases where the command-line tools are outdated.
## In those cases, I was told to run the following.
## It'd be nice if we could automate this.
# softwareupdate --all --install --force
# rm -rf /Library/Developer/CommandLineTools
# xcode-select --install
