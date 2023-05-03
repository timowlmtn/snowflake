# Demo Code showing Snowflake and AWS Integration with
# Terraform and dbt

##  Create a new environment

Create a build folder based on the current code state.

    make pull-qa

Source the setenv and build the system

    source setenv.sh
    make-qa all
