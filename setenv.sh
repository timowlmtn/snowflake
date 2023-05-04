# Include private data here
source ~/.setenv.sh

export ENVIRONMENT=dev
export DOMAIN=radio
export PREFIX=owlmtn
export SOURCE=kexp

export BUILD_HOME=..

alias "make-demo"="make ENVIRONMENT=demo --directory=${BUILD_HOME}/build/demo"

alias "make-qa"="make ENVIRONMENT=qa --directory=${BUILD_HOME}/build/qa"

alias "make-prod"="make ENVIRONMENT=prod --directory=${BUILD_HOME}/build/prod"

