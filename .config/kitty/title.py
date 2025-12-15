#!/usr/bin/env python3
import subprocess
from datetime import datetime

def run(cmd):
    return subprocess.check_output(cmd, shell=True).decode().strip()

battery = run("pmset -g batt | grep -o '[0-9]\\+%'")
volume  = run("osascript -e 'output volume of (get volume settings)'")
wifi    = run("/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print $2}'")
time    = datetime.now().strftime("%m/%d %H:%M")

print(f"{battery}   {volume}%   {wifi}   {time}")

