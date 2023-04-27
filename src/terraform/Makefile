apply-datalake:
	terraform -chdir=layers/datalake apply   -var="prefix=${PREFIX}" -var="environment=${ENVIRONMENT}" \
		-var="domain=${DOMAIN}" -var="aws_account_id=${AWS_ACCOUNT_ID}"  -auto-approve

plan-datalake:
	terraform -chdir=layers/datalake plan -var="prefix=${PREFIX}" -var="environment=${ENVIRONMENT}" \
		-var="domain=${DOMAIN}" -var="aws_account_id=${AWS_ACCOUNT_ID}"

init-datalake:
	terraform -chdir=modules/datalake init

output-snowflake:
	terraform -chdir=layers/snowflake output

destroy-snowflake:
	terraform -chdir=layers/snowflake destroy -var="prefix=${PREFIX}" -var="environment=${ENVIRONMENT}" \
		-var="domain=${DOMAIN}" -var="aws_account_id=${AWS_ACCOUNT_ID}" -var="data_source=${SOURCE}"  -auto-approve

apply-snowflake-db:
	terraform -chdir=layers/snowflake-db apply -var-file="../../../../environments/dev.tfvars" -auto-approve

plan-snowflake-db:
	terraform -chdir=layers/snowflake-db plan -var-file="../../../../environments/dev.tfvars"

init-snowflake-db:
	terraform -chdir=layers/snowflake-db init

apply-snowflake-pipe:
	terraform -chdir=layers/snowflake-pipe apply -var="aws_account_id=${AWS_ACCOUNT_ID}" -var-file="../../../../environments/dev.tfvars" -auto-approve

plan-snowflake-pipe:
	terraform -chdir=layers/snowflake-pipe plan -var-file="../../../../environments/dev.tfvars"

init-snowflake-pipe:
	terraform -chdir=layers/snowflake-pipe init -upgrade


init-snowflake-module:
	terraform -chdir=modules/snowflake init

apply-databricks:
	terraform -chdir=layers/databricks apply -auto-approve -var-file="../../environments/owlmtn.tfvars"

plan-databricks:
	terraform -chdir=layers/databricks plan -var-file="../../environments/owlmtn.tfvars"

# Initialize a working directory containing the terraform config files
init-databricks:
	terraform -chdir=layers/databricks init

install:
	brew install hashicorp/tap/terraform

get-session-token:
	aws --profile databricks_user sts get-session-token --duration-seconds 129600
