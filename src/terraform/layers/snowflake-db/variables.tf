variable "datalake_storage" {
  description = "The Data Lake Storage "
  type        = string
  default     = null
}

variable "environment" {
  description = "Environment"
  type = string
}

variable "prefix" {
  description = "A unique prefix for the project."
  type        = string
}

variable "data_source" {
  description = "The data source for the raw data"
  type        = string
}

variable "stage_name" {
  description = "The name for the stage"
  type        = string
  default     = null
}

variable "stage_folder" {
  description = "The folder for the stage"
  type        = string
  default     = null
}

variable "snowflake_database" {
  description = "The database name"
  type        = string
  default     = null
}

variable "landing_zone_schema" {
  description = "The database schema for the landing zone data"
  type        = string
  default     = null
}

variable "storage_integration" {
  description = "The storage integration created in Snowflake"
  type        = string
  default     = null

}

variable "table_name" {
  description = "The data table for the pipe"
  type        = string
  default     = null
}

variable "cluster_columns" {
  description = "An array containing the clustering columns"
  type = list(string)
  default= []
}
