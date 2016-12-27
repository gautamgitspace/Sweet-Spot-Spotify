#!/usr/bin/env osascript
on run argv

  set msg to "Some Things You Can Ask Me:\n"
  set msg to msg & "  go, play [uri]                    - Start playback / play uri\n"
  set msg to msg & "  go, play track  [song name]       - Search and play track\n"
  set msg to msg & "  go, play artist [artist name]     - Search and play artist\n"
  set msg to msg & "  go, play album  [album name]      - Search and play album\n"
  set msg to msg & "  pause, stop                       - Stop playback\n"
  set msg to msg & "  play/pause                        - Toggle playback\n"
  set msg to msg & "  n                                 - Next track\n"
  set msg to msg & "  p, prev                           - Previous track\n"
  set msg to msg & "  i                                 - Print track info\n"
  set msg to msg & "  jump N                            - Jump to N seconds in the song\n"
  set msg to msg & "  forward N                         - Jump N seconds forwards\n"
  set msg to msg & "  rewind N                          - Jump N seconds backwards\n"
  set msg to msg & "  shuffle                           - Toggle shuffle\n"
  set msg to msg & "  repeat                            - Toggle repeat\n"
  set msg to msg & "  vol N, up, down                   - Set Volume to N (0...100)\n"
  set msg to msg & "  increasevolume N                  - Increment Volume by N (0...100)\n"
  set msg to msg & "  decreasevolume N                  - Decrement Volume by N (0...100)\n"

  set waitFlag to false

  if count of argv is equal to 0 then
    return msg
  end if
  set command to item 1 of argv
  using terms from application "Spotify"
    set info to "Error."
    -- Play
    if command is equal to "play" or command is equal to "go" then
      if count of argv is equal to 1 then
        tell application "Spotify" to play
      else
        set m_type to item 2 of argv
        set uri to m_type
        set modes to {"artist", "album", "track"}
        if modes contains m_type then
          if count of argv is equal to 2 then
            return "No Search Argument Provided"
          else
            set q to ""
            repeat with myArgv from 3 to (count of argv)
                set q to q & item myArgv of argv & " "
            end repeat
            log "Searching " & m_type & "s for " & q
            set spotifySearchAPI to "\"https://api.spotify.com/v1/search\""
            try
              set uri to do shell script  " curl s -G " & spotifySearchAPI & ¬
                                          " --data-urlencode \"q=" & q & "\"" & ¬
                                          " -d \"type=" & m_type & "&limit=1&offset=0\"" & ¬
                                          " -H \"Accept: application/json\" | grep -E -o \"spotify:" & ¬
                                          m_type & ":[a-zA-Z0-9]+\" -m 1"
            on error
              return "No results found for " & q
            end try
            log q & "Found in Spotify Cloud"
            set waitFlag to true
          end if
        end if
        tell application "Spotify" to play track uri
      end if
    -- Play/Pause
    else if command is equal to "play/pause" then
      tell application "Spotify" to playpause
      return "Control Toggled!"
    -- Pause
    else if command is equal to "pause" or command is equal to "stop" then
      tell application "Spotify" to pause
      return "Paused!"
    -- Next
    else if command is equal to "n" then
      tell application "Spotify" to next track
    -- Prev
    else if command is equal to "p" or command is equal to "prev" then
      tell application "Spotify" to previous track
