local notes = { ---MIDI notes
    {68},
    {69},
    {71},
    {70},
    {69,68,69}
} 

local keys = {
    {60, 62, 64, 65, 67, 69, 71, 72},  -- C major (C, D, E, F, G, A, B, C)
    {62, 64, 66, 67, 69, 71, 73, 74},  -- D major (D, E, F#, G, A, B, C#, D)
    {64, 66, 68, 69, 71, 73, 75, 76},  -- E major (E, F#, G#, A, B, C#, D#, E)
    {57, 59, 60, 62, 64, 65, 67, 69},  -- A minor (A, B, C, D, E, F, G, A)
    {55, 57, 59, 60, 62, 64, 66, 67},  -- G major (G, A, B, C, D, E, F#, G)
}

local rhythms = { -- in whole notes
    {1/8, 1/8},
    {1/8, 1/16, 1/16},
    {1/16,1/16,1/8},
    {1/4},  
    {1/12,1/12,1/12}
} 

local n_notes = 1000
--------------
local function copy_table(t) 
    local t2 = {}
    for k, v in pairs(t) do
        t2[k] = v
    end
    return t2
end

local function get_usr_input()
    reaper.ShowConsoleMsg("Choose a key (1 = C Major, 2 = D Major, 3 = E Major, 4 = A Minor, 5 = G Major): ")
    local retval, usr_input = reaper.GetUserInputs("Choose Key", 1, "Please enter a number from 1 to 5 to select a key (C: 1, D: 2, E: 3, A: 4, G: 5)", "")
    
    if retval == false then
        reaper.ShowConsoleMsg("\nUser canceled the input.\n")
        return nil
    else
        return tonumber(usr_input)  -- Convert the input to a number if valid
    end
end

--------------
local proj = 0
local midi_editor = reaper.MIDIEditor_GetActive()

local take = reaper.MIDIEditor_EnumTakes( midi_editor, 0, true )

local selected_key = get_usr_input()

if selected_key == nil then
    reaper.ShowConsoleMsg("No valid input, exiting...\n")
    return  -- Exit the script if no valid input was provided
end

reaper.ShowConsoleMsg("\nUser selected key: " .. selected_key .. "\n")

local sel_pitch, sel_rhythms = {}, {}
local pos = 0 -- ppq 
local pos_qn = reaper.MIDI_GetProjQNFromPPQPos( take, pos )
reaper.MIDI_DisableSort(take)
for i = 0, n_notes-1 do
  if #sel_pitch == 0 then
    sel_pitch = copy_table(keys[selected_key])  -- Use the selected key's notes
  end
  if #sel_rhythms == 0 then
    sel_rhythms = copy_table(rhythms[math.random(#rhythms)])
  end
  -- Velocity
  local vel = 20 + math.random(40)
  -- Pitches
  local pitch = sel_pitch[1]
  -- Position
  local startppqpos = pos 
  local rhythm = sel_rhythms[1] -- in whole notes
  pos_qn = pos_qn + (rhythm * 4)
  local endppqpos = reaper.MIDI_GetPPQPosFromProjQN( take, pos_qn )
  pos = endppqpos
  ---
  reaper.MIDI_InsertNote(take, false, false, startppqpos, endppqpos, 0, pitch, vel, false)
  
  table.remove(sel_pitch, 1)
  table.remove(sel_rhythms, 1)
end
reaper.MIDI_Sort(take)
