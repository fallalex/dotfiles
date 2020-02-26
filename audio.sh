#!/usr/bin/env bash

sudo rm /Library/Preferences/Audio/com.apple.audio.SystemSettings.plist
sudo rm /Library/Preferences/Audio/com.apple.audio.DeviceSettings.plist
sudo killall coreaudiod
