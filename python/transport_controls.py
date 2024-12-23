import mido
from mido import MidiFile, MidiTrack, Message

# Define MIDI port and transport control mapping
midi_port = 'Launchkey MK3'  # Update this with your Launchkey's MIDI input port name

# Map the MIDI controls to REAPER transport functions
control_map = {
    0x20: 'play',  # Play button (use correct MIDI CC for your device)
    0x21: 'stop',  # Stop button
    0x22: 'record',  # Record button
    0x23: 'rewind',  # Rewind button (if available)
    0x24: 'fast_forward'  # Fast Forward button (if available)
}

# Open the MIDI input port
try:
    midi_input = mido.open_input(midi_port)
    print(f"Listening for MIDI input on {midi_port}...")
except Exception as e:
    print(f"Error opening MIDI port: {e}")
    exit()

# Define REAPER actions for transport controls
def trigger_reaper_action(action):
    # Here you can send commands to REAPER (through ReaScript or other methods)
    # For example, send keypresses, or use REAPER API calls to control transport
    print(f"Triggering REAPER action: {action}")
    # You can map this to REAPER-specific actions using ReaScript or MIDI to REAPER communication

# Listen for MIDI messages and map them to transport controls
for msg in midi_input:
    if msg.type == 'control_change':
        control = msg.control
        if control in control_map:
            action = control_map[control]
            trigger_reaper_action(action)
