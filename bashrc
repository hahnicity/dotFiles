alias ll="ls -lah"
alias rr="rm -rf"
alias gut=git
alias vun=vim
alias flintrock="flintrock --config flintrock.config.yml"
alias gpg=gpg2
export PATH=$PATH:/usr/local/sbin/
export HOMEBREW_GITHUB_API_TOKEN=c1621909d2cf1ce5aa829934e4e470c04ef3c15b
export MEG_SERVER_CFG=/Users/greg/.megconfig/config.yml
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# Add dia. You'll need to set DISPLAY=:0 as well.
#
# If you want a better drawing program; draw.io is free and better.
# Or google draw. whatevs
export PATH=$PATH:/Applications/Dia.app/Contents/Resources/bin

# Add gradle
export GRADLE_HOME=/Users/greg/workspace/groovy/gradle-2.3
export PATH=$PATH:$GRADLE_HOME/bin

# Android
export PATH=$PATH:/Applications/Android\ Studio.app/Contents/MacOS
export ANDROID_HOME=/Users/greg/Library/Android/sdk

# wireshark
export PATH=$PATH:/usr/local/Cellar/wireshark/2.0.1_1/bin

# other bash stuff
export GREP_OPTIONS='--color=always'

activate() {
    source $1/bin/activate
}

activate() {
    local venv=$1
    if [[ -z $venv ]]; then
        echo "Enter a virtualenv to activate"
        exit 1
    fi
    source ${venv}/bin/activate
}

connect_to_hospital_vpn() {
    sudo openconnect --config ~/.openconnect connect.ucdmc.ucdavis.edu
}

deploy_megserver() {
    cd $HOME/workspace/python/meg-server/ansible
    activate buildvenv
    local api_key=`cat ~/.megconfig/config.yml | grep gcm | awk '{print $2}'`
    local meg_user_password=`cat ~/.megconfig/config.yml | grep password | awk '{print $2}'`
    local sendgrid_api_key=`cat ~/.megconfig/config.yml | grep sendgrid_api_key | awk '{print $2}'`
    # Set this as a separate var because ansible evaluates variables as
    # literals over the command line so you cannot pass things in like
    # --extra-args foo=$foo because ansible will not ask shell if it has
    # an env var
    local extra_args="megserver_gcm_api_key=$api_key meg_user_password=$meg_user_password sendgrid_api_key=$sendgrid_api_key"
    ansible-playbook -i inventory deploy.yml --extra-vars "$extra_args" -t megserver
    deactivate
}

push_cur_branch() {
    /usr/local/bin/git push origin $(cur_branch)
}

pull_cur_branch() {
    git pull --rebase origin `cur_branch`
}

cur_branch() {
    local GREP_OPTIONS=
    echo $(git branch | grep \* | tr -d \* | tr -d ' ')
}

cycle_wifi() {
    sudo ifconfig en0 down
    sudo ifconfig en0 up
}

torrent() {
    local path=$1
    if [[ -z $path ]]; then
        echo "Enter a path to the file you want to download"
        exit 1
    fi
    transmission-cli $path -er -w ~/Downloads/
}
