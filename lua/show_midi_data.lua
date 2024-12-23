-- Function to print the data from the MIDI input event
local function printMIDIData()
    -- Get the most recent MIDI input event
    local retval, _, _, msg, _, _, _ = reaper.MIDI_GetRecentInputEvent(0)

    -- Check if a valid MIDI event is retrieved
    if retval and msg then
        -- Print the raw data returned by MIDI_GetRecentInputEvent
        reaper.ShowConsoleMsg("MIDI event data: \n")
        reaper.ShowConsoleMsg("retval: " .. tostring(retval) .. "\n")
        reaper.ShowConsoleMsg("Message (msg): " .. tostring(msg) .. "\n")
    else
        -- Print message if no MIDI event is detected
        reaper.ShowConsoleMsg("No MIDI event detected.\n")
    end

    -- Schedule the function to run again
    reaper.defer(printMIDIData)
end

-- Start the monitoring loop
printMIDIData()
