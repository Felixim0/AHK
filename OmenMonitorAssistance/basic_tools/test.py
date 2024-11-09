import wmi
from monitorcontrol import get_monitors

# Initialize WMI interface
w = wmi.WMI(namespace='WMI')

# Retrieve WMI monitor information
wmi_monitors = w.WmiMonitorID()
monitors = get_monitors()

# Check if the number of monitors matches
if len(monitors) != len(wmi_monitors):
    print("Mismatch in the number of monitors detected by WMI and monitorcontrol.")
    print("Proceeding, but monitor mappings may not be accurate.\n")

# Create a mapping between WMI monitors and monitorcontrol monitors
monitor_mappings = []

for i in range(len(monitors)):
    # Get WMI monitor info
    if i < len(wmi_monitors):
        wmi_monitor = wmi_monitors[i]
        serial = ''.join([chr(c) for c in wmi_monitor.SerialNumberID if c != 0]).strip()
        manufacturer = ''.join([chr(c) for c in wmi_monitor.ManufacturerName if c != 0]).strip()
        model = ''.join([chr(c) for c in wmi_monitor.UserFriendlyName if c != 0]).strip()
    else:
        serial = None
        manufacturer = None
        model = None

    monitor_mappings.append({
        'monitorcontrol_monitor': monitors[i],
        'serial': serial,
        'manufacturer': manufacturer,
        'model': model
    })

# Display the monitor mappings
for i, mapping in enumerate(monitor_mappings):
    print(f"Monitor {i}:")
    print(f"  Manufacturer: {mapping['manufacturer']}")
    print(f"  Model: {mapping['model']}")
    print(f"  Serial Number: {mapping['serial']}\n")

# Define your monitor serial numbers based on the output you provided
acer_serial = '38900119'          # ACER VG271U
omen_serial_1 = 'CNC35139TP'      # OMEN 27k (First)
omen_serial_2 = 'CNC32016BK'      # OMEN 27k (Second)
sony_serial = '16843009'          # SONY TV

# Adjust brightness and contrast based on serial numbers
# liminance and contrast numbers
luminance = 60
contrast = 70

for mapping in monitor_mappings:
    serial = mapping['serial']
    monitor = mapping['monitorcontrol_monitor']

    with monitor:
        if serial == omen_serial_1:
            # Adjust settings for the first OMEN monitor
            print(f"Adjusting settings for OMEN 27k (Serial: {serial})")
            monitor.set_luminance(luminance)   # Brightness to 50%
            monitor.set_contrast(contrast)    # Contrast to 70%
        elif serial == omen_serial_2:
            # Adjust settings for the second OMEN monitor
            print(f"Adjusting settings for OMEN 27k (Serial: {serial})")
            monitor.set_luminance(luminance)   # Brightness to 60%
            monitor.set_contrast(contrast)    # Contrast to 75%
        elif serial == acer_serial:
            # Adjust settings for the ACER monitor
            print(f"Adjusting settings for ACER VG271U (Serial: {serial})")
            monitor.set_luminance(luminance)   # Brightness to 40%
            monitor.set_contrast(contrast)    # Contrast to 65%
        elif serial == sony_serial:
            # Adjust settings for SONY TV
            print(f"Adjusting settings for SONY TV (Serial: {serial})")
            monitor.set_luminance(luminance)   # Brightness to 30%
            monitor.set_contrast(contrast)    # Contrast to 60%
        else:
            print(f"Unknown monitor with serial {serial}. Skipping adjustments.")
