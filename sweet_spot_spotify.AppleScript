#!/usr/bin/env osascript
on run argv

  set msg to "Available Commands:\n"
  set msg to msg & "  start, play [uri]                 - Start playback / play uri\n"
  set msg to msg & "  start, play track  [song name]    - Search and play track\n"
  set msg to msg & "  start, play artist [artist name]  - Search and play artist\n"
  set msg to msg & "  start, play album  [album name]   - Search and play album\n"
  set msg to msg & "  pause, stop                       - Stop playback\n"
  set msg to msg & "  play/pause                        - Toggle playback\n"
  set msg to msg & "  n                                 - Next track\n"
  set msg to msg & "  p                                 - Previous track\n"
  set msg to msg & "  i                                 - Print track info\n"
  set msg to msg & "  fwd N                             - Jump N seconds forwards\n"
  set msg to msg & "  rwd N                             - Jump N seconds backwards\n"
  set msg to msg & "  s                                 - Toggle shuffle\n"
  set msg to msg & "  r                                 - Toggle repeat\n"
  set msg to msg & "  vol N, up, down                   - Set Volume to N (0...100)\n"
