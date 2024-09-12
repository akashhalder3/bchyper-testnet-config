#!/bin/bash

# Step 1: Install Go 1.22.3 🚀
echo "🔧 Step 1: Installing Go 1.22.3..."
GO_VERSION="go1.22.3.linux-amd64.tar.gz"
GO_URL="https://go.dev/dl/$GO_VERSION"

# Download Go
echo "⬇️ Downloading Go version 1.22.3..."
wget $GO_URL

# Remove any existing Go installation
echo "🧹 Removing previous Go installation (if any)..."
sudo rm -rf /usr/local/go

# Extract the Go tarball to /usr/local
echo "📦 Extracting Go archive..."
sudo tar -C /usr/local -xzf $GO_VERSION

# Step 2: Configure Go environment variables ⚙️
echo "🔧 Step 2: Configuring Go environment variables..."
{
    echo "export GOROOT=/usr/local/go"
    echo "export GOPATH=\$HOME/go"
    echo "export GO111MODULE=on"
    echo "export PATH=\$PATH:/usr/local/go/bin:\$HOME/go/bin"
} >> $HOME/.profile

# Apply the environment variable changes to the current session
source $HOME/.profile
echo "✅ Go environment configured successfully."

# Step 3: Create hidden .bchyper folder 📁
echo "📁 Step 3: Creating .bchyper hidden folder in home directory..."
mkdir -p $HOME/.bchyper
echo "✅ .bchyper directory created successfully at $HOME/.bchyper"

# Step 4: Download the BC Hyper Chain Execution File 🔗
echo "🔗 Step 4: Downloading BC Hyper Chain execution file..."
BC_EXEC_URL="https://drive.google.com/uc?export=download&id=1u2uUhKnyAagSSa0kaQ8H7gGdo4eIPGAT"
BC_EXEC_FILE="bc-hyper-chain-exec"

# Download the BC Hyper Chain execution file
wget --no-check-certificate "$BC_EXEC_URL" -O $BC_EXEC_FILE

# Make the execution file executable
chmod +x $BC_EXEC_FILE

# Optionally move the execution file to /usr/local/bin to make it globally accessible
sudo mv $BC_EXEC_FILE /usr/local/bin/
echo "✅ BC Hyper Chain execution file installed."

# Step 5: Download the testnet config file ⚙️
echo "⚙️ Step 5: Downloading testnet config file..."
CONFIG_URL="https://raw.githubusercontent.com/akashhalder3/bchyper-testnet-config/main/testnetconfig.toml"
CONFIG_FILE="testnetconfig.toml"

# Download the testnet config file
wget "$CONFIG_URL" -O $CONFIG_FILE

# Move the config file to the .bchyper directory
mv $CONFIG_FILE $HOME/.bchyper/
echo "✅ Testnet config file moved to .bchyper directory."

# Step 6: Initialize BC Hyper testnet 🌐
echo "🌐 Step 6: Initializing BC Hyper testnet..."
$BC_EXEC_FILE --datadir $HOME/.bchyper init
echo "✅ BC Hyper Chain testnet initialization complete!"

# Step 7: Get and print the public IP address 🌍
echo "🌍 Step 7: Fetching public IP address..."
PUBLIC_IP=$(curl -s ifconfig.me)
echo "🌍 Public IP Address: $PUBLIC_IP"

# Step 8: Get the OS username 👤
echo "👤 Step 8: Getting the OS username..."
os_username=$(whoami)
echo "👤 OS Username: $os_username"

# Step 9: Create a systemd service file for BC Hyper Chain 🛠️
echo "🛠️ Step 9: Creating systemd service file..."

SERVICE_FILE="/lib/systemd/system/bchyper.service"
sudo bash -c "cat > $SERVICE_FILE" <<EOL
[Unit]
Description=BC Hyper Chain client
After=syslog.target network.target

[Service]
User=$os_username
Group=$os_username
Type=simple
ExecStart=$BC_EXEC_FILE --datadir $HOME/.bchyper --config $HOME/.bchyper/$CONFIG_FILE --gcmode "archive" --syncmode "full" --rpcvhosts "*" --http.corsdomain "*" --nat extip:$PUBLIC_IP
KillMode=process
KillSignal=SIGINT
TimeoutStopSec=90
Restart=on-failure
RestartSec=10s

[Install]
WantedBy=multi-user.target
EOL

# Step 10: Enable and start the service 💡
echo "💡 Step 10: Enabling BC Hyper Chain service..."
sudo systemctl daemon-reload
sudo systemctl enable bchyper.service
sudo systemctl start bchyper.service
echo "🚀 BC Hyper Chain service is now active!"

echo "🎉 BC Hyper Chain installation, configuration, and service setup complete! 🎉"
