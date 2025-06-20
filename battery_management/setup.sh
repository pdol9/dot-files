#!/bin/bash

set -e

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

	# * Discover names of battery device(s):
	BAT=$(ls /sys/class/power_supply/ | grep -i '^BAT')
	if [ -z "$BAT" ]; then
		echo "No battery device found!"
		exit 1
	fi
	echo "Detected battery device: $BAT"
}

initialize_systemd_service()
{
	# Verify if systemd is present, else exit
	SERVICE=$(which systemctl)
	if [ -z "${SERVICE}" ]; then
		echo "systemd not installed. Exiting ..."
		exit 1
	fi

	# skip when testing ..
	# return

	# Copy the neccesary file: 
	sudo cp battery-threshold.service /etc/systemd/system/battery-threshold.service

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
set_up
initialize_systemd_service
verify_status
# end od procedure
