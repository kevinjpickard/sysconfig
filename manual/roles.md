# System Configuration Roles

The system's configuration is modularized into Ansible roles, located in the `ansible/roles/` directory. Each role is responsible for a specific slice of the system's functionality.

## Core Roles (Always Applied)
These roles form the foundation of the system and are always applied during provisioning and syncing.

*   **`system_setup`**: The bedrock of the system. It creates your user account, configures sudo privileges, sets up the Arch Linux base packages, and installs essential guest agents (like `qemu-guest-agent` and `spice-vdagent`) for when the system is running in a VM.
*   **`plasma_desktop`**: Configures the entire graphical environment. It installs KDE Plasma, SDDM (the login screen), Konsole, and Dolphin. Crucially, it fully configures the **Dracula Dark Theme**, extracts the SVG icons, and sets up Kvantum for native widget styling.

## Optional Roles
These roles are conditionally triggered based on the variables defined in `ansible/local_vars.yml`.

*   **`basic_system_tools`**: Installs everyday CLI utilities and necessities (e.g., git, vim, top, network tools).
*   **`software_development`**: Configures the system for programming. This typically includes compilers, IDEs, programming languages, and development environments.
*   **`docker`**: Installs the Docker daemon, enables the service, and adds your user to the `docker` group so you can manage containers without sudo.
*   **`gaming`**: Configures the system for gaming, typically installing Steam, Lutris, graphics drivers, and gaming optimizations.
*   **`media`**: Installs media consumption and production applications (e.g., VLC, Spotify, OBS).

## Maintenance & Base Roles
*   **`unattended_upgrades`**: Configures automatic system updates for Arch Linux, ensuring your packages stay secure and up-to-date without manual intervention.
*   **`bootstrap`**: A preliminary role often used to ensure the bare minimum requirements (like Python) are installed so Ansible can run effectively.
*   **`linux`** & **`configuration`**: Additional structural roles for generic Linux scaffolding and configuration management.
