Certainly! Here is a comprehensive documentation on how a user can run the `bchyper_testnet_setup.sh` file to easily set up a BC Hyper Chain RPC node.

---

# BC Hyper Chain RPC Node Setup Documentation

## Overview

This document provides instructions for setting up a BC Hyper Chain RPC node using the `bchyper_testnet_setup.sh` script. The script automates the installation and configuration process for running a BC Hyper Chain RPC node on an Ubuntu system.

## Prerequisites

Before running the setup script, ensure that you have:

1. **Ubuntu OS**: The setup is designed for Ubuntu systems.
2. **Internet Connection**: Required for downloading necessary files and dependencies.
3. **sudo Privileges**: You will need root or sudo access to install and configure software.

## Steps to Set Up BC Hyper Chain RPC Node

### 1. Clone the Repository

First, clone the repository containing the setup script.

```bash
git clone https://github.com/akashhalder3/bchyper-testnet-config.git
```

Navigate to the cloned directory:

```bash
cd bchyper-testnet-config
```

### 2. Make the Script Executable

Ensure that the script has executable permissions. Run the following command:

```bash
chmod +x bchyper_testnet_setup.sh
```

### 3. Run the Setup Script

Execute the setup script to start the installation and configuration process:

```bash
./bchyper_testnet_setup.sh
```

### 4. Follow the Script's Output

The script will provide real-time feedback as it performs the following actions:

1. **Installs Go 1.22.3**: Downloads and configures Go, which is required for running the BC Hyper Chain client.
2. **Creates a Hidden `.bchyper` Directory**: Sets up a directory for storing configuration files and data.
3. **Downloads the BC Hyper Chain Execution File**: Fetches the executable for running the BC Hyper Chain node.
4. **Downloads and Moves the Testnet Configuration File**: Retrieves and places the testnet configuration file in the `.bchyper` directory.
5. **Initializes the BC Hyper Testnet**: Runs the initialization command for setting up the testnet.
6. **Fetches and Displays the Public IP Address**: Determines and shows the public IP of your system.
7. **Creates and Configures a Systemd Service File**: Sets up a service to manage the BC Hyper Chain node.
8. **Enables and Starts the Service**: Activates the BC Hyper Chain service to start automatically on boot.

### 5. Verify Installation

After running the script, verify that the BC Hyper Chain RPC node is running correctly:

```bash
sudo systemctl status bchyper.service
```

You should see output indicating that the service is active and running.

### 6. Access the RPC Node

The RPC node will be accessible based on the configuration in the script. Typically, you can interact with it using tools that support RPC calls to the configured endpoint.

## Troubleshooting

If you encounter issues:

- **Check Logs**: View logs for the BC Hyper Chain service with:

    ```bash
    sudo journalctl -u bchyper.service
    ```

- **Ensure Dependencies**: Confirm that all dependencies and configurations are correct.
- **Consult Documentation**: Refer to the BC Hyper Chain documentation for additional details.

## Additional Information

For more information on BC Hyper Chain or to get involved with the project, visit the [BC Hyper Chain GitHub Repository](https://github.com/akashhalder3/bchyper-testnet-config).

---

Feel free to customize this documentation further based on your specific needs or additional details about the setup process.