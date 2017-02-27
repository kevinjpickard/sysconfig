#source ~/.myenvvars
# Initiate rbenv
eval "$(rbenv init -)"

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH
PATH="/Users/kevin/Scripts:${PATH}"
export PATH

# Setting up Golang
#export GOPATH=$HOME/Documents/go
#export GOBIN=$GOPATH/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f /Users/kevin/Downloads/google-cloud-sdk/path.bash.inc ]; then
  source '/Users/kevin/Downloads/google-cloud-sdk/path.bash.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /Users/kevin/Downloads/google-cloud-sdk/completion.bash.inc ]; then
  source '/Users/kevin/Downloads/google-cloud-sdk/completion.bash.inc'
fi

ssh-add &> /dev/null
ssh-add ~/.ssh/google_compute_engine &> /dev/null
ssh-add ~/.ssh/AWSQaTest.pem ~/.ssh/AmazonNewKey.pem ~/.ssh/KJP-AWS-QA.pem &> /dev/null

# Docker-Machine SSH Agent forwarding
export SSH_AUTH_SOCK=/tmp/ssh-rFLX4BViP6/agent.12982

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export JUMPCLOUD_WORKSPACE=/Users/kevin/Documents/github/jumpcloud
