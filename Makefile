default: build-all

# Clean will delete everything:
clean: destroy-all

# Each environment needs to have a specific location because Terraform
# will store state.  Only dev has the default folder as its source
#

build-init:
	mkdir -p ${BUILD_HOME}/build/${BUILD_ENV}
	git clone https://github.com/timowlmtn/snowflake.git ${BUILD_HOME}/build/${BUILD_ENV}

build-pull:
	git -C ${BUILD_HOME}/build/${BUILD_ENV} pull https://github.com/timowlmtn/snowflake.git

build-datalake: init-datalake apply-datalake
build-snowflake-db: init-snowflake-db apply-snowflake-db
build-snowflake-pipe: init-snowflake-pipe apply-snowflake-pipe

build-all: build-datalake build-snowflake-db build-snowflake-pipe
destroy-all: destroy-datalake destroy-snowflake-db

# -------------------------------------------------------------------------------------------------
# The Data Lake is the base layer S3 bucket and we create as a separate layer that has no
# explicit dependencies.  We manage the dependency with a consistent naming convention.
#
#	${var.prefix}-datalake-${var.environment}
#
init-datalake:
	terraform -chdir=src/terraform/layers/datalake init

plan-datalake:
	terraform -chdir=src/terraform/layers/datalake plan -var="aws_account_id=${AWS_ACCOUNT_ID}" \
 	-var-file="../../../../environments/${ENVIRONMENT}.tfvars"

apply-datalake:
	terraform -chdir=src/terraform/layers/datalake apply  -var="aws_account_id=${AWS_ACCOUNT_ID}" \
 	-var-file="../../../../environments/${ENVIRONMENT}.tfvars" -auto-approve

clean-s3-bucket:
	aws s3 rm s3://${PREFIX}-datalake-${ENVIRONMENT} --recursive

destroy-datalake: clean-s3-bucket
	terraform -chdir=src/terraform/layers/datalake destroy  -var="aws_account_id=${AWS_ACCOUNT_ID}" \
 	-var-file="../../../../environments/${ENVIRONMENT}.tfvars" -auto-approve


destroy-snowflake-db:
	terraform -chdir=src/terraform/layers/snowflake-db destroy -var="aws_account_id=${AWS_ACCOUNT_ID}" \
 	-var-file="../../../../environments/${ENVIRONMENT}.tfvars" -auto-approve


# -------------------------------------------------------------------------------------------------
# The Snowflake database is the base level database and is again created as a layer to avoid
# dependencies.  We also create the base schema skeleton in this layer.
#
# We manage the database with a naming convention:
#
#	upper("${var.environment}_CATALOG")
#
apply-snowflake-db:
	terraform -chdir=src/terraform/layers/snowflake-db apply -var-file="../../../../environments/${ENVIRONMENT}.tfvars" -auto-approve

destroy-snowflake-db:
	terraform -chdir=src/terraform/layers/snowflake-db destroy -var-file="../../../../environments/${ENVIRONMENT}.tfvars" -auto-approve

plan-snowflake-db:
	terraform -chdir=src/terraform/layers/snowflake-db plan -var-file="../../../../environments/${ENVIRONMENT}.tfvars"

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

destroy-snowflake-pipe:
	terraform -chdir=src/terraform/layers/snowflake-pipe destroy -var="aws_account_id=${AWS_ACCOUNT_ID}" \
		-var-file="../../../../environments/${ENVIRONMENT}.tfvars" -auto-approve

plan-snowflake-pipe:
	terraform -chdir=src/terraform/layers/snowflake-pipe plan -var-file="../../../../environments/dev.tfvars"

init-snowflake-pipe:
	terraform -chdir=src/terraform/layers/snowflake-pipe init -upgrade

sync-test-data:
	aws s3 sync data/logs s3://${PREFIX}-datalake-${BUILD_ENV}/stage/${SOURCE}/logs/ --exclude="*" --include="*.json"

sync-real-data:
	aws s3 sync s3://${PREFIX}-datalake-prod/stage/${SOURCE}/ s3://${PREFIX}-datalake-${BUILD_ENV}/stage/${SOURCE}/ \
 		--exclude="*" --include="*/202302*" # --dryrun


# -------------------------------------------------------------------------------------------------
# This is the brew method of installing Terraform for this example
#
install-terraform:
	brew install hashicorp/tap/terraform

install-dbt:
	pip install -r requirements.txt