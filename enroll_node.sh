#!/bin/bash

# =================================================================
# Description: Automated FreeIPA Client Installation for HPC Nodes
# =================================================================

# 1. Variables - Change these as per your configuration
IPA_SERVER="hpc-master.hpc.local"
IPA_DOMAIN="hpc.local"
IPA_REALM="HPC.LOCAL"
IPA_ADMIN="admin"
IPA_PASS="Admin1234"
MASTER_IP="192.168.100.1"

echo "----------------------------------------------------"
echo "Starting FreeIPA Client Enrollment for $(hostname)"
echo "----------------------------------------------------"

# 2. Install FreeIPA Client Package
echo "[1/4] Installing freeipa-client..."
dnf install freeipa-client -y > /dev/null 2>&1

# 3. Configure /etc/hosts
# We use a 'Here Document' to ensure the hosts file is exactly what we need
echo "[2/4] Configuring /etc/hosts..."
cat <<EOF > /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

${MASTER_IP}   ${IPA_SERVER} hpc-master
192.168.100.11   login.hpc.local login
192.168.100.12   storage.hpc.local storage
192.168.100.13   compute1.hpc.local compute1
192.168.100.14   compute2.hpc.local compute2
EOF

# 4. Run IPA Client Installation (Fully Unattended)
# Note: --fixed-primary and --no-ntp are added to skip the interactive prompts 
# you encountered regarding DNS discovery and Chrony.
echo "[3/4] Enrolling node in FreeIPA Domain..."
ipa-client-install --mkhomedir \
--server=${IPA_SERVER} \
--domain=${IPA_DOMAIN} \
--realm=${IPA_REALM} \
--hostname=$(hostname -f) \
--principal=${IPA_ADMIN} \
--password=${IPA_PASS} \
--fixed-primary \
--no-ntp \
--unattended

# 5. Verification
echo "[4/4] Verifying installation..."
if id amogh &>/dev/null; then
    echo "SUCCESS: User 'amogh' resolved successfully."
else
    echo "WARNING: Could not resolve IPA user 'amogh'. Check logs."
fi

echo "----------------------------------------------------"
echo "Enrollment Process Finished."