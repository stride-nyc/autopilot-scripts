echo "Creating virtual environment..."
python3.11 -m venv ~/.autopilot/.venv
source ~/.autopilot/.venv/bin/activate

# If you don't have python 3.11 installed, here's how you can install it:
# Install Brew
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# brew install python@3.11
# brew link python@3.11

echo "Installing Autopilot.."
pip3.11 install git+https://github.com/stride-nyc/stride-autopilot

echo "Autopilot installed successfully..."
