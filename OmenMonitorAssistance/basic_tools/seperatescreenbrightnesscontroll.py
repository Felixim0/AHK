import screen_brightness_control as sbc
import sys

for i, arg in enumerate(sys.argv):
    print(f"Argument {i}: {arg}")

# List all connected monitors
monitors = sbc.list_monitors()
print("Connected Monitors:", monitors)

# Set brightness and contrast for each monitor
# Adjust the indices as per your setup

brightness = sys.argv[1]

# Set brightness for all monitors
sbc.set_brightness(brightness, display=0)  
sbc.set_brightness(brightness, display=1)  
sbc.set_brightness(brightness, display=2)  

