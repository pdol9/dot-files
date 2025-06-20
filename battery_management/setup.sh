#!/bin/bash

set -xe

set_up()
{
	echo "Start the setup."

	# AC power: find name of AC adapter:
	AC=$(ls /sys/class/power_supply/ | grep -i '^AC')
	if [ -z "$AC" ]; then
		echo "No AC device found!"
		exit 1
	fi
	echo "Detected AC device: $AC"

	# Discover names of battery device:
	BAT=$(ls /sys/class/power_supply/ | grep -i '^BAT')
	if [ -z "$BAT" ]; then
		echo "No battery device found!"
		exit 1
	fi
	echo "Detected battery device: $BAT"

	# Get arguments
	INPUT_VALUES_UPPER="$1"
	INPUT_VALUES_LOWER="$2"

	# Check if both arguments are provided
	if [[ -z "$INPUT_VALUES_UPPER" || -z "$INPUT_VALUES_LOWER" ]]; then
		echo "Usage: $0 <upper_limit> <lower_limit>"
		exit 1
	fi

	# Check if both are integers using regex
	if ! [[ "$INPUT_VALUES_UPPER" =~ ^[0-9]+$ && "$INPUT_VALUES_LOWER" =~ ^[0-9]+$ ]]; then
		echo "Both values must be integers."
		exit 1
	fi

	# Convert to integers for comparison
	UPPER_INT=$((INPUT_VALUES_UPPER))
	LOWER_INT=$((INPUT_VALUES_LOWER))

	# Range check
	if (( UPPER_INT < 25 || UPPER_INT > 100 || LOWER_INT < 25 || LOWER_INT > 100 )); then
		echo "Values must be between 25 and 100."
		exit 1
	fi

	# Logical order check
	if (( UPPER_INT <= LOWER_INT )); then
		echo "Upper limit must be greater than lower limit."
		exit 1
	fi

	echo "Input values are valid: upper=$UPPER_INT, lower=$LOWER_INT"

	# Insert updated charging treshold limits and battery name
	SERVICE_FILE="battery-threshold.service"
	NEW_LINE="ExecStart=/bin/bash -c 'echo \"${INPUT_VALUES_UPPER}\" > /sys/class/power_supply/${BAT}/charge_control_end_threshold && echo \"${INPUT_VALUES_LOWER}\" > /sys/class/power_supply/${BAT}/charge_control_start_threshold'"

	# Escape ampersands (&) in NEW_LINE so sed doesn't misinterpret them
	ESCAPED_LINE=$(printf '%s\n' "$NEW_LINE" | sed 's/&/\\&/g')

	# Replace the existing ExecStart line
	sed -i "s|^ExecStart=.*|$ESCAPED_LINE|" "$SERVICE_FILE"
	# testing
	# exit
}

initialize_systemd_service()
{
	# Verify if systemd is present, else exit
	SERVICE=$(which systemctl)
	if [ -z "${SERVICE}" ]; then
		echo "systemd not installed. Exiting ..."
		exit 1
	fi

	# skip when testing
	# return

	# Copy the neccesary file: 
	sudo cp ${SERVICE_FILE} /etc/systemd/system/battery-threshold.service

	# Setup systemd service:
	sudo systemctl daemon-reexec
	sudo systemctl daemon-reload
	sudo systemctl enable --now battery-threshold.service
}

verify_status()
{
	# Verify status of the service:
	systemctl --no-pager status battery-threshold.service || true

	ACPI=$(which acpi)
	if [ -e "${ACPI}" ]; then
		acpi -a
	fi

	# Verify AC status:
	if [[ "$(cat /sys/class/power_supply/${AC}/online)" -eq 1 ]]; then
		echo "Device is AC powered"
	else
		echo "Device is on battery"
	fi

	# Verify if battery is being charged:
	echo -n "Current status of the battery: "
	cat /sys/class/power_supply/${BAT}/status

	# * Check if specified battery treshold is correct:
	UPPER_LIMIT=$(cat /sys/class/power_supply/${BAT}/charge_control_end_threshold)
	echo "Upper charging limit is at %: " ${UPPER_LIMIT}
	LOWER_LIMIT=$(cat /sys/class/power_supply/${BAT}/charge_control_start_threshold)
	echo "Lower charging limit is at %: " ${LOWER_LIMIT}

	echo "Setup successfully completed."
}

# start procedure
set_up "$1" "$2"
initialize_systemd_service
verify_status
# end od procedure
