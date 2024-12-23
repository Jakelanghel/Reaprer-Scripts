-- Set your target MIDI channel (1-16)
local target_channel = 1

-- Function to execute when a message is received
local function onMidiMessage()
    reaper.ShowConsoleMsg("MIDI message received on channel " .. target_channel .. "!\n")
end

-- Main function to check for MIDI messages
local function monitorMidi()
    -- Get the most recent MIDI input event
    local retval, _, _, msg, _, _, _ = reaper.MIDI_GetRecentInputEvent(0)

    if retval and msg then
        local status = msg:byte(1)
        local channel = (status & 0x0F) + 1 -- Extract channel from status byte

        -- Check if the message is from the target channel
        if channel == target_channel then
            onMidiMessage()
        end
    end

    -- Schedule the function to run again
    reaper.defer(monitorMidi)
end

-- Start the monitoring loop
monitorMidi()
