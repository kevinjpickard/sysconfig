# HashiCorp Atlas Token (Vagrant)
export ATLAS_TOKEN='BhJWmmzU4ZbYVw.atlasv1.3SZsoMpK2KZzrA.atlasv1.IAZhza6plWZIqd3fC76qzdU3TnnsYoAQseeNzeuKw1zwiAeyNV3ERmaRl4BgqMOdtHI'

# Initiate rbenv
eval "$(rbenv init -)"

# JumpCloud Connect Keys for provision_agnets.yml (vagrant/ansible)
export JUMPCLOUD_CONNECTKEY_PRD='098a04df16f30159e19c3f3ed0b07e3d82164c2d'
export JUMPCLOUD_CONNECTKEY_STG='kjpstg'

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
ssh-add ~/.ssh/google_compute_engine &> /dev/null
ssh-add ~/.ssh/AWSQaTest.pem ~/.ssh/AmazonNewKey.pem ~/.ssh/KJP-AWS-QA.pem &> /dev/null

fish
