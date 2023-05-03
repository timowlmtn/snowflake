# Include private data here
source ~/.setenv.sh

export ENVIRONMENT=dev
export DOMAIN=radio
export PREFIX=owlmtn
export SOURCE=kexp

alias "make-demo"="make ENVIRONMENT=demo --directory=build/demo"

alias "make-qa"="make ENVIRONMENT=qa --directory=build/qa"

alias "make-prod"="make ENVIRONMENT=prod --directory=build/prod"

