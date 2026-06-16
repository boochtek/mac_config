#!/bin/bash

## Install and Chrome web browser.

# Install Chrome browser.
brew install --quiet --cask google-chrome
dockutil --add '/Applications/Google Chrome.app' --replacing 'Google Chrome' --before 'Safari'

# Chrome TODO (manual):
#   * Make sure 1Password works properly. FIXME: Need cask apps deployed into /Applications instead of locally.
#   * Install AdBlocker Ultimate extension.
#   * Install OneTab (recommended by Mikhail).

## Install Chromium browser.
#brew install --quiet --cask chromium
#dockutil --add '/Applications/Chromium.app' --replacing 'Chromium' --after 'Google Chrome'

# Install `extension` utility to install Chrome (or Edge or Arc) extensions from CLI.
# NOTE: Use `extension listen chrome` to listen for config changes.
brew install --quiet 8ta4/extension/extension

# Install Chrome extensions.
# NOTE: You may be prompted for your password.
# NOTE: You may need to restart Chrome to see the extensions.
# NOTE: You may need to enable the extensions in Chrome.
# NOTE: You may need to configure the extensions.
# NOTE: You may need to log in to the extensions.

# uBlock Origin
extension install chrome cjpalhdlnbpafiamejdnhcphjbkeiagm

# 1Password
extension install chrome aeblfdkhhhdcdjpifhhbdiojplfjncoa

# OneTab
# TODO: Consider alternatives: [Session Buddy](https://chromewebstore.google.com/detail/session-buddy/edacconmaakjimmfgnblocblbcdcpbko)
extension install chrome chphlpgkkbolifaimnlloiipkdnihall

# [Web Developer](https://chromewebstore.google.com/detail/web-developer/bfbameneiokkgbdmiekhjnmfkcnldhhm)
extension install chrome bfbameneiokkgbdmiekhjnmfkcnldhhm

# [React Developer Tools](https://chromewebstore.google.com/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi)
extension install chrome fmkadmapgofadopljbjfkapdkoienihi

# [Lighthouse](https://chromewebstore.google.com/detail/lighthouse/blipmdconlkpinefehnmjammfjpmpbjk)
extension install chrome blipmdconlkpinefehnmjammfjpmpbjk

# [Next Experience Developer Tools](https://chromewebstore.google.com/detail/next-experience-developer/ilkodijinjhpdnnfpccijledlapkfmhc)
extension install chrome ilkodijinjhpdnnfpccijledlapkfmhc

# Stylish
# TODO: Consider alternatives: [Stylus](https://chromewebstore.google.com/detail/stylus/clngdbkpkpeebahjckkjfobafhncgmne)
extension install chrome fjnbnpbmkenffdnngjfgmeleoegfcffe

# [GitHub Code Folding](https://chromewebstore.google.com/detail/github-code-folding/lefcpjbffalgdcdgidjdnmabfenecjdf)
extension install chrome lefcpjbffalgdcdgidjdnmabfenecjdf

# [Obsidian Web Clipper](https://chromewebstore.google.com/detail/obsidian-web-clipper/cnjifjpddelmedmihgijeibhnjfabmlf)
extension install chrome cnjifjpddelmedmihgijeibhnjfabmlf

# Official [Wayback Machine](https://chromewebstore.google.com/detail/wayback-machine/fpnmgdkabkmnadcjpehmlllkndpkmiak)
extension install chrome fpnmgdkabkmnadcjpehmlllkndpkmiak

# [Web Archives](https://chromewebstore.google.com/detail/web-archives/hkligngkgcpcolhcnkgccglchdafcnao)
extension install chrome hkligngkgcpcolhcnkgccglchdafcnao

# [Internet Archive Assistant](https://chromewebstore.google.com/detail/internet-archive-assistan/behpdfoepanebmpljobdjgbkkekidhfh)
extension install chrome behpdfoepanebmpljobdjgbkkekidhfh

# [Save ChatGPT to Obsidian](https://chromewebstore.google.com/detail/save-chatgpt-to-obsidian/bdkpamdmcgamabdeaeehfmaiaejcdfko)
extension install chrome bdkpamdmcgamabdeaeehfmaiaejcdfko

# [Claude to Obsidian](https://chromewebstore.google.com/detail/claude-to-obsidian/ehacefdknbaacgjcikcpkogkocemcdil)
extension install chrome ehacefdknbaacgjcikcpkogkocemcdil

# [JSON Formatter](https://chromewebstore.google.com/detail/json-formatter/bcjindcccaagfpapjjmafapmmgkkhgoa)
extension install chrome bcjindcccaagfpapjjmafapmmgkkhgoa

# [Wappalyzer](https://chromewebstore.google.com/detail/wappalyzer/gppongmhjkpfnbhagpmjfkannfbllamg)
extension install chrome gppongmhjkpfnbhagpmjfkannfbllamg

# [OCR Image Reader](https://chromewebstore.google.com/detail/ocr-image-reader/bhbhjjkcoghibhibegcmbomkbakkpdbo)
extension install chrome bhbhjjkcoghibhibegcmbomkbakkpdbo

# [Copy as Markdown](https://chromewebstore.google.com/detail/copy-as-markdown/nlaionblcaejecbkcillglodmmfhjhfi)
extension install chrome nlaionblcaejecbkcillglodmmfhjhfi

# [Consent-O-Matic](https://chromewebstore.google.com/detail/consent-o-matic/mdjildafknihdffpkfmmpnpoiajfjnjd)
extension install chrome mdjildafknihdffpkfmmpnpoiajfjnjd

# [Just Read](https://chromewebstore.google.com/detail/just-read/dgmanlpmmkibanfdgjocnabmcaclkmod)
extension install chrome dgmanlpmmkibanfdgjocnabmcaclkmod
