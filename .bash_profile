<<<<<<< HEAD
source ~/.myenvvars
eval "$(rbenv init -)"
=======
# HashiCorp Atlas Token (Vagrant)
export ATLAS_TOKEN=''

# Initiate rbenv
eval "$(rbenv init -)"

# JumpCloud Connect Keys for provision_agnets.yml (vagrant/ansible)
export JUMPCLOUD_CONNECTKEY_PRD=''
export JUMPCLOUD_CONNECTKEY_STG='kjpstg'

>>>>>>> e09c3ce8ae424e7675197199a251d94ecf9b8ee6
# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH
PATH="/Users/kevin/Scripts:${PATH}"
export PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f /Users/kevin/Downloads/google-cloud-sdk/path.bash.inc ]; then
  source '/Users/kevin/Downloads/google-cloud-sdk/path.bash.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /Users/kevin/Downloads/google-cloud-sdk/completion.bash.inc ]; then
  source '/Users/kevin/Downloads/google-cloud-sdk/completion.bash.inc'
fi

ssh-add &> /dev/null

fish
