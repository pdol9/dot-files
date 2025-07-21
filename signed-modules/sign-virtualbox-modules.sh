#!/bin/bash

# CONFIGURATION
KEY_DIR="/root/signed-modules"
PRIV_KEY="$KEY_DIR/MOK.priv"
PUB_KEY="$KEY_DIR/MOK.der"
KERNEL_VERSION=$(uname -r)
MODULE_DIR="/lib/modules/$KERNEL_VERSION/misc"
SIGN_TOOL="/usr/src/kernels/$KERNEL_VERSION/scripts/sign-file"

echo "Signing VirtualBox modules for kernel: $KERNEL_VERSION"

err=0
for mod in vboxdrv.ko vboxnetflt.ko vboxnetadp.ko; do
    if [ -f "$MODULE_DIR/$mod" ]; then
        echo "Signing $mod..."
        sudo "$SIGN_TOOL" sha256 "$PRIV_KEY" "$PUB_KEY" "$MODULE_DIR/$mod"
    else
        echo "Skipping $mod (not found)"
        err=$((err + 1))
    fi
done

if [ $err -eq 0 ]; then
    echo "Done signing. You may now load modules with modprobe."
else
  echo "Module signing failed."
fi
