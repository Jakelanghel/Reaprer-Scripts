--- User Settings
local notes = {
    {61, 61},       --- Dflat, C
    {62},           --- D   
    {63},           --- Eflat
    {60},           --- C
    {67},           --- G  
    {59, 60, 67},   --- B3, C, G
    {67, 62},       --- G D
}

local rhythms = { -- in whole notes
    {1/16, 1/16, 1/16, 1/16},
    {1/8, 1/8},
    {1/4},
    {1/8, 1/16, 1/16}
}

local n_notes = 1000

local function TableCopy(t) 
    local t2 = {}
    for k, v in pairs(t) do
        t2[k] = v
    end
    return t2
end

----------------------------
local proj = 0
local midi_editor = reaper.midi_editor_get_active()

local take = reaper.midi_editor_EnumTakes(midi_editor, 0, true)

