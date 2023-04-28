
# -------------------------------------------------------------------------------------------------
# The Data Lake is the base layer S3 bucket and we create as a separate layer that has no
# explicit dependencies.  We manage the dependency with a consistent naming convention.
#
#	${var.prefix}-datalake-${var.environment}
#
init-datalake:
	terraform -chdir=src/terraform/layers/datalake init

plan-datalake:
	terraform -chdir=src/terraform/layers/datalake plan -var="prefix=${PREFIX}" -var="environment=${ENVIRONMENT}" \
		-var="domain=${DOMAIN}" -var="aws_account_id=${AWS_ACCOUNT_ID}"

apply-datalake:
	terraform -chdir=src/terraform/layers/datalake apply   -var="prefix=${PREFIX}" -var="environment=${ENVIRONMENT}" \
		-var="domain=${DOMAIN}" -var="aws_account_id=${AWS_ACCOUNT_ID}"  -auto-approve

# -------------------------------------------------------------------------------------------------
# The Snowflake database is the base level database and is again created as a layer to avoid
# dependencies.  We also create the base schema skeleton in this layer.
#
# We manage the database with a naming convention:
#
#	upper("${var.environment}_CATALOG")
#
apply-snowflake-db:
	terraform -chdir=src/terraform/layers/snowflake-db apply -var-file="../../../../environments/dev.tfvars" -auto-approve

plan-snowflake-db:
	terraform -chdir=src/terraform/layers/snowflake-db plan -var-file="../../../../environments/dev.tfvars"

init-snowflake-db:
	terraform -chdir=src/terraform/layers/snowflake-db init


# -------------------------------------------------------------------------------------------------
# The Snowflake Pipe Layer creates that basic integration including the STORAGE_INTEGRATION object
# and the PIPE integration, as well as all the AWS IAM roles and policies to ensure security with
# our automated pipeline automation.
#
apply-snowflake-pipe:
	terraform -chdir=src/terraform/layers/snowflake-pipe apply -var="aws_account_id=${AWS_ACCOUNT_ID}" \
		-var-file="../../../../environments/${ENVIRONMENT}.tfvars" -auto-approve

plan-snowflake-pipe:
	terraform -chdir=src/terraform/layers/snowflake-pipe plan -var-file="../../../../environments/dev.tfvars"

init-snowflake-pipe:
	terraform -chdir=src/terraform/layers/snowflake-pipe init -upgrade

# -------------------------------------------------------------------------------------------------
# Here is an example of a specific domain-level usage for managing auto-loading tables on Snowflake
# via Terraform configuration and JSON schema definitions.
#
apply-snowflake-pipe-kexp:
	terraform -chdir=src/terraform/layers/snowflake-pipe-kexp apply -var="aws_account_id=${AWS_ACCOUNT_ID}" \
		-var-file="../../../../environments/${ENVIRONMENT}.tfvars" -auto-approve

plan-snowflake-pipe-kexp:
	terraform -chdir=src/terraform/layers/snowflake-pipe-kexp plan -var-file="../../../../environments/${ENVIRONMENT}.tfvars"

init-snowflake-pipe-kexp:
	terraform -chdir=src/terraform/layers/snowflake-pipe-kexp init -upgrade


# -------------------------------------------------------------------------------------------------
# This is the brew method of installing Terraform for this example
#
install:
	brew install hashicorp/tap/terraform
