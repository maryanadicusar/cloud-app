#!/bin/bash
mkdir app
# Clone the project repository
git clone https://github.com/daniftodi/cloud-app.git app/
# Set as an executable
chmod +x k8s_setup_extended.sh


# run the setup
./k8s_setup_extended.sh