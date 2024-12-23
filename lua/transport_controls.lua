function print_recent_midi_event()
  local idx = 0 -- Start with the most recent event
  local retval, buf, ts, devIdx, projPos, projLoopCnt = reaper.MIDI_GetRecentInputEvent(idx)

  if retval > 0 then
      -- Extract event details
      local status_byte = string.byte(buf, 1) or 0
      local data1 = string.byte(buf, 2) or 0
      local data2 = string.byte(buf, 3) or 0

      -- Interpret MIDI message type
      local message_type = (status_byte & 0xF0) >> 4 -- Upper nibble for type
      local channel = status_byte & 0x0F -- Lower nibble for channel

      -- Print the event details
      reaper.ShowConsoleMsg("---- Recent MIDI Event ----\n")
      reaper.ShowConsoleMsg("Timestamp (relative): " .. ts .. "\n")
      reaper.ShowConsoleMsg("Device Index: " .. (devIdx & 0xFFFF) .. "\n")
      reaper.ShowConsoleMsg("Control Device Only: " .. ((devIdx & 0x10000) ~= 0 and "Yes" or "No") .. "\n")
      reaper.ShowConsoleMsg("Project Position: " .. projPos .. "\n")
      reaper.ShowConsoleMsg("Loop Count: " .. projLoopCnt .. "\n")
      reaper.ShowConsoleMsg("Message Type: " .. message_type .. "\n")
      reaper.ShowConsoleMsg("Channel: " .. (channel + 1) .. "\n")
      reaper.ShowConsoleMsg("Data1: " .. data1 .. "\n")
      reaper.ShowConsoleMsg("Data2: " .. data2 .. "\n")
      reaper.ShowConsoleMsg("---------------------------\n")
  end

  -- Continuously listen for MIDI events
  reaper.defer(print_recent_midi_event)
end

-- Initialize script
print_recent_midi_event()
