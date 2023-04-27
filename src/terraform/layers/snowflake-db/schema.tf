resource "snowflake_schema" "landing_zone" {
  database = upper("${var.environment}_CATALOG")
  name     = "LANDING_ZONE"
  comment  = "The Landing zone schema for new data"

  is_transient        = false
  is_managed          = false
}
