#!/usr/bin/env bash
set -e # Fail immediately if any errors occur

function setup_prerequisites {
  echo "Caching password..."
  sudo -K
  sudo true
  clear

  # === INSTALL HOMEBREW ===
  if hash brew 2>/dev/null; then
    echo "Homebrew is already installed!"
  else
    echo "Installing Homebrew..."
    yes '' | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if which brew; then
      echo "Homebrew install verified"
    else
      echo "Adding Homebrew to your PATH"
      echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zprofile
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
  fi
  echo

  echo "Ensuring good setup"
  brew tap --repair
  echo

  echo "Ensuring you have the latest Homebrew..."
  brew update
  echo

  echo "Ensuring your Homebrew directory is writable..."
  sudo chown -Rf $(whoami) $(brew --prefix)/*

  echo "Cleaning up your Homebrew installation..."
  brew cleanup --quiet
  echo

  # === INSTALL DOCKER ===
  if [ -x "$(command -v docker)" ]; then
    echo "Docker is installed!"
  else
    echo "Installing docker"
    brew install --cask docker

  fi
  open /Applications/Docker.app # start docker
  echo

  echo "installing prerequisites for python-build"
  brew install \
    openssl \
    readline \
    sqlite3 \
    xz \
    zlib \
    tcl-tk
  echo

  if [ -x "$(command -v asdf)" ]; then
    echo "asdf is installed"
  else
    echo "installing asdf..."
    brew install asdf
    echo $SHELL
    case $(echo $SHELL) in
    "/bin/zsh")
      echo "setting up zsh"
      echo -e "\n\n# asdf" >>~/.zshrc
      echo -e ". $(brew --prefix asdf)/libexec/asdf.sh" >>~/.zshrc
      ;;
    "/bin/bash")
      echo "setting up bash"
      echo -e "\n\n# asdf" >>~/.bashrc
      echo -e ". \"$(brew --prefix asdf)/libexec/asdf.sh\"" >>~/.bashrc
      ;;
    esac
    source "$(brew --prefix asdf)/libexec/asdf.sh"
  fi
  echo

  NODE_VERSION=20.2.0
  echo "Ensuring node ${NODE_VERSON} installed..."
  asdf plugin add nodejs
  asdf install nodejs $NODE_VERSION
  asdf global nodejs $NODE_VERSION

  PYTHON_VERSION=3.11.8
  echo "Ensuring python ${PYTHON_VERSION} installed..."
  asdf plugin add python
  asdf install python $PYTHON_VERSION
  asdf global python $PYTHON_VERSION

  PIPX_VERSION=1.4.3
  echo "Ensuring pipx $PIPX_VERSION installed..."
  asdf plugin add pipx
  asdf install pipx $PIPX_VERSION
  asdf global pipx $PIPX_VERSION
  pipx ensurepath

  # === INSTALL TTAB ===
  echo "Ensuring ttab installed for demo script..."
  npx --yes ttab --help
}

function setup_frontend_demo {
  DEMO_HOME=${CONDUCTOR_DEMO_HOME:-~/Documents/CodeGen-demo/}
  mkdir -p $DEMO_HOME
  cd $DEMO_HOME

  # === SET UP DEMO FRONTENED APP ===
  DEMO_FRONTEND_APP_VERSION=v1.0.0
  if [ -d ./demo-todo-app ]; then
    echo "Directory exists: demo-todo-app"
  else
    echo "Pulling down demo-todo-app ${DEMO_FRONTEND_APP_VERSION} project code..."
    curl -L "https://github.com/stride-nyc/demo-todo-app/archive/refs/tags/$DEMO_FRONTEND_APP_VERSION.zip" -o demo-todo-app.zip
    unzip demo-todo-app.zip -d .
    rm -f demo-todo-app.zip
    mv demo-todo-app* demo-todo-app/
  fi
  echo

  echo "Setting up demo-todo-app dependencies..."
  (
    cd ./demo-todo-app
    npm install
  )
  echo

  # create demo-todo-app clean slate in git
  if [[ $(
    cd ./demo-todo-app
    git log
  ) ]]; then
    echo "Git is already set up!"
  else
    echo "Initializing project with git."
    (
      cd ./demo-todo-app
      git init
      git add .
      git commit -m "initial commit, HOOTY HOOT!"
    )
  fi
  echo

  # === SET UP FRONTEND DEMO SCRIPT ===
  echo "creating script ${DEMO_HOME}start_frontend_demo.sh"
  cat <<-'EOF' >./start_frontend_demo.sh
  echo "creating script $DEMO_HOME/start_frontend_demo.sh"
  #!/usr/bin/env bash
  set -e  # Fail immediately if any errors occur
  source ~/.conductor/env.sh  # set environment variables
  DEMO_HOME=${CONDUCTOR_DEMO_HOME:-~/Documents/CodeGen-demo/}
  cd $DEMO_HOME/demo-todo-app
  git checkout -f  # ensure the demo app is a clean slate
  npx ttab -- "npm start;"  # start demo app in a new tab
  open /Applications/Docker.app  # start docker
  echo

  echo "Run conductor init to ensure user and project config exists."
  echo

  ~/.conductor/run.sh
  cd -
EOF

  chmod +x ./start_frontend_demo.sh

  cd -
}

function setup_fullstack_demo {
  DEMO_HOME=${CONDUCTOR_DEMO_HOME:-~/Documents/CodeGen-demo/}
  mkdir -p $DEMO_HOME
  cd $DEMO_HOME

  # === SET UP DEMO FULLSTACK APP ===
  DEMO_FULLSTACK_APP_VERSION=v1.0.0
  if [ -d ./demo-todo-fullstack ]; then
    echo "Directory exists: demo-todo-fullstack"
  else
    echo "Pulling down demo-todo-fullstack ${DEMO_FULLSTACK_APP_VERSION} project code..."
    curl -L "https://github.com/stride-nyc/demo-todo-fullstack/archive/refs/tags/$DEMO_FULLSTACK_APP_VERSION.zip" -o demo-todo-fullstack.zip
    unzip demo-todo-fullstack.zip -d .
    rm -f demo-todo-fullstack.zip
    mv demo-todo-fullstack* demo-todo-fullstack/
  fi
  echo

  echo "Setting up demo-todo-fullstack dependencies..."
  (
    cd ./demo-todo-fullstack/frontend
    npm install
  )
  (
    cd ./demo-todo-fullstack/backend
    npm install
  )
  echo

  # create demo-todo-fullstack clean slate in git
  if [[ $(
    cd ./demo-todo-fullstack
    git log
  ) ]]; then
    echo "Git is already set up!"
  else
    echo "Initializing project with git."
    (
      cd ./demo-todo-fullstack
      git init
      git add .
      git commit -m "initial commit, HOOTY HOOT!"
    )
  fi
  echo

  # === SET UP FULLSTACK DEMO SCRIPT ===
  echo "creating script ${DEMO_HOME}start_fullstack_demo.sh"
  cat <<-'EOF' >./start_fullstack_demo.sh
  #!/usr/bin/env bash
  set -e  # Fail immediately if any errors occur
  source ~/.conductor/env.sh  # set environment variables
  DEMO_HOME=${CONDUCTOR_DEMO_HOME:-~/Documents/CodeGen-demo/}
  cd $DEMO_HOME/demo-todo-fullstack
  git checkout -f  # ensure the demo app is a clean slate
  npx ttab -- "cd backend; npm start;"  # start demo backend in a new tab
  npx ttab -- "cd frontend; npm start;"  # start demo frontend in a new tab
  open /Applications/Docker.app  # start docker
  echo

  echo "Run conductor init to ensure user and project config exists."
  echo

  ~/.conductor/run.sh
  cd -
EOF

  chmod +x ./start_fullstack_demo.sh
  cd -
}

function setup_env {
  if [ -x ~/.conductor/env.sh ]; then
    echo "Conductor environment script exists."
  else
    echo "Creating conductor environment script..."
    mkdir -p ~/.conductor
    echo "#!/usr/bin/env bash" >~/.conductor/env.sh
    echo "" >>~/.conductor/env.sh
    chmod +x ~/.conductor/env.sh
  fi

  source ~/.conductor/env.sh

  # === SET UP OPENAI KEY ===
  if [ -z "$CONDUCTOR_OPENAI_API_KEY" ]; then
    echo "What is your OpenAI api key?"
    echo "- View & Create: https://platform.openai.com/api-keys"

    read apikey
    CONDUCTOR_OPENAI_API_KEY=$apikey

    echo "export CONDUCTOR_OPENAI_API_KEY=$CONDUCTOR_OPENAI_API_KEY" >>~/.conductor/env.sh
    echo
  fi

  # === SET UP GITHUB USER FOR DOWNLOADING CONDUCTOR DOCKER IMAGE ===
  if [ -z "$CONDUCTOR_GITHUB_USER" ]; then
    echo "What is your GitHub username (email)?"

    read username
    CONDUCTOR_GITHUB_USER=$username

    echo "export CONDUCTOR_GITHUB_USER=$CONDUCTOR_GITHUB_USER" >>~/.conductor/env.sh
    echo
  fi

  # === SET UP GITHUB TOKEN FOR DOWNLOADING CONDUCTOR DOCKER IMAGE ===
  if [ -z "$CONDUCTOR_GITHUB_TOKEN" ]; then
    echo "What is your GitHub personal access token?"
    echo "- View: https://github.com/settings/tokens"
    echo "- Create new: https://github.com/settings/tokens/new"

    read token
    CONDUCTOR_GITHUB_TOKEN=$token

    echo "export CONDUCTOR_GITHUB_TOKEN=$CONDUCTOR_GITHUB_TOKEN" >>~/.conductor/env.sh
    echo
  fi

  if [ -z "$CONDUCTOR_VERSION" ]; then
    echo "Setting CONDUCTOR_VERSION=${CONDUCTOR_VERSION}..."
    CONDUCTOR_VERSION="v0.4.2"
    echo "export CONDUCTOR_VERSION=$CONDUCTOR_VERSION" >>~/.conductor/env.sh
    echo
  fi

  source ~/.conductor/env.sh

  echo "Set conductor environment variables..."
  env | grep "CONDUCTOR"
  echo
}

function install_docker_conductor {
  source ~/.conductor/env.sh
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/stride-nyc/conductor-scripts/${CONDUCTOR_SCRIPTS_VERSION:-main}/docker/install.sh)"
}

function install_pipx_conductor {
  source ~/.conductor/env.sh
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/stride-nyc/conductor-scripts/${CONDUCTOR_SCRIPTS_VERSION:-main}/python/install.sh)"
}

setup_prerequisites
setup_frontend_demo
setup_fullstack_demo
setup_env
install_docker_conductor
install_pipx_conductor
