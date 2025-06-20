# Battery management

## Description

A minimalistic systemd service on a Linux system to preserve battery life span.
With this service enabled, system will be powered through AC, meanwhile the battery
will stay charged at 80 % or any other desired level.

Even though there are many working solutions like TLP or GNOME's Battery Health
Charging, quite often they are not comprehensible to a beginner nor working properly.

## Usage

Run script ```setup.sh``` while specifying charging limits to execute automated setup:
    ./setup.sh <upper_limit_value> <lower_limit_value>
```bash
# Example:
./setup.sh 80 60
```

- The upper limit is the charge percentage at which charging stops.
- The lower limit is the percentage at which charging resumes.


