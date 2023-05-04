# Demo Code showing Snowflake and AWS Integration with
# Terraform and dbt

##  Create a new environment

Create a build folder based on the current code state.

    BUILD_ENV=qa make build-init

Pull the latest changes the setenv 

    source setenv.sh
    ENVIRONMENT=qa make build-pull

The build-all target will build the Snowflake database, data pipelines and integrations.

    make-qa build-all
