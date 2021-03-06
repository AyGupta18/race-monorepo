variable block_time {
  type        = number
  description = "Number of seconds between each block"
}

variable celo_env {
  type        = string
  description = "Name of the testnet Celo environment"
}

variable ethstats_host {
  type        = string
  description = "Ethstats url or IP address"
}

variable gcloud_project {
  type        = string
  description = "Name of the Google Cloud project to use"
}

variable instance_types {
  description = "The instance type for each component"
  type        = map(string)

  default = {
    validator           = "n1-standard-2"
    proxy               = "n1-standard-2"
    txnode              = "n1-standard-1"
    attestation_service = "n1-standard-1"
    backup_node         = "n1-standard-1"
  }
}

variable geth_exporter_docker_image_repository {
  type        = string
  description = "Repository of the geth exporter docker image"
}

variable geth_exporter_docker_image_tag {
  type        = string
  description = "Tag of the geth exporter docker image"
}

variable geth_node_docker_image_repository {
  type        = string
  description = "Repository of the geth docker image"
}

variable geth_node_docker_image_tag {
  type        = string
  description = "Tag of the geth docker image"
}

variable geth_verbosity {
  type        = number
  description = "Verbosity of all geth nodes"
}

variable in_memory_discovery_table {
  type        = bool
  description = "Specifies whether to use an in memory discovery table"
}

variable istanbul_request_timeout_ms {
  type        = number
  description = "The number of ms for the istanbul request timeout"
}

variable network_id {
  type        = number
  description = "The network ID number"
}

variable network_name {
  type        = string
  description = "The name of the network to use"
}

variable tx_node_count {
  type        = number
  description = "Number of tx-nodes to create"
}

variable backup_node_count {
  type        = number
  description = "Number of backup_nodes to create"
}

variable validator_count {
  type        = number
  description = "Number of validators to create"
}

# New vars
variable gcloud_region {
  type        = string
  description = "Name of the Google Cloud region to use"
}

variable gcloud_zone {
  type        = string
  description = "Name of the Google Cloud zone to use"
}

variable validator_signer_account_addresses {
  type        = list(string)
  description = "Array with the Validator etherbase account addresses"
}

variable validator_signer_private_keys {
  type        = list(string)
  description = "Array with the Validator etherbase account private keys"
}

variable validator_signer_account_passwords {
  type        = list(string)
  description = "Array with the Validator etherbase account passwords"
}

variable validator_release_gold_addresses {
  type        = list(string)
  description = "Array with the Validator release gold address(es)"
}

variable proxy_enodes {
  type        = list(string)
  description = "Array list with the proxy enode address (without enode://)"
}

variable proxy_private_keys {
  type        = list(string)
  description = "Array with the Proxy private keys"
}

variable proxy_account_passwords {
  type        = list(string)
  description = "Array with the proxy etherbase account passwords"
}

variable reset_geth_data {
  type        = bool
  description = "Specifies if the existing chain data should be removed while creating the instance"
}

# Attestation service vars
variable attestation_service_count {
  type        = number
  description = "Number of Attestation Service to deploy"
}

variable attestation_service_db_username {
  type        = string
  description = "The User for the database"
  default     = "celo"
}

variable attestation_service_db_password {
  type        = string
  description = "The password for the database"
  default     = "secret"
}

variable attestation_service_docker_image_repository {
  type        = string
  description = "The docker image repository for the attestation service"
  default     = ""
}

variable attestation_service_docker_image_tag {
  type        = string
  description = "The docker image tag for the attestation service"
  default     = ""
}

variable attestation_signer_addresses {
  type        = list(string)
  description = "The account address for signing the attestations. Must be the address of the associated validator"
  default     = [""]
}

variable attestation_signer_private_keys {
  type        = list(string)
  description = "The account private key for signing the attestations. Must be the private key of the associated validator"
  default     = [""]
}

variable attestation_signer_account_passwords {
  type        = list(string)
  description = "Array with the attestation_signer account passwords"
}


variable attestation_service_celo_provider {
  type        = string
  description = "The URL for the RPC interface for the Celo network"
  default     = ""
}

variable attestation_service_sms_providers {
  type        = string
  description = "The SMS Service provider. Must be nexmo or twilio"
  default     = ""
}

variable attestation_service_nexmo_key {
  type        = string
  description = "Nexmo api key (check nexmo documentation)"
  default     = ""
}

variable attestation_service_nexmo_secret {
  type        = string
  description = "Nexmo api secret (check nexmo documentation)"
  default     = ""
}

variable attestation_service_nexmo_blacklist {
  type        = string
  description = "Nexmo blacklisted country codes, separated by comma (check nexmo documentation)"
  default     = ""
}

variable attestation_service_nexmo_unsupported_regions {
  type        = string
  description = "Nexmo unsupported country codes, separated by comma (check nexmo documentation)"
  default     = ""
}

variable attestation_service_twilio_account_sid {
  type        = string
  description = "Twilio account SID (check twilio documentation)"
  default     = ""
}

variable attestation_service_twilio_messaging_service_sid {
  type        = string
  description = "Twilio account messaging service SID (check twilio documentation)"
  default     = ""
}

variable attestation_service_twilio_verify_service_sid {
  type        = string
  description = "Twilio account verify service SID (check twilio documentation)"
  default     = ""
}

variable attestation_service_twilio_auth_token {
  type        = string
  description = "Twilio account Auth Token (check twilio documentation)"
  default     = ""
}

variable attestation_service_twilio_blacklist {
  type        = string
  description = "Twilio blacklisted country codes, separated by comma  (check twilio documentation)"
  default     = ""
}

variable attestation_service_twilio_unsupported_regions {
  type        = string
  description = "Twilio unsupported country codes, separated by comma  (check twilio documentation)"
  default     = ""
}

variable attestation_service_messagebird_api_key {
  type        = string
  description = "Messagebird API key"
  default     = ""
}

variable attestation_service_messagebird_unsupported_regions {
  type        = string
  description = "Messagebird unsupported country codes, separated by comma  (check Messagebird documentation)"
  default     = ""
}

variable validator_name {
  type        = string
  description = "The validator Name for ethstats"
}

variable proxy_name {
  type        = string
  description = "The proxy Name for ethstats"
}

variable proxy_addresses {
  type        = list(string)
  description = "The proxy address for ethstats"
}

variable "stackdriver_logging_exclusions" {
  description = "List of objects that define logs to exclude on stackdriver"
  type = map(object({
    description  = string
    filter       = string
  }))
}

variable "stackdriver_logging_metrics" {
  description = "List of objects that define COUNT (DELTA) logging metric filters to apply to Stackdriver to graph and alert on useful signals"
  type        = map(object({
    description = string
    filter      = string
  }))
}

variable "service_account_scopes" {
  description = "Scopes to apply to the service account which all nodes in the cluster will inherit"
  type        = list(string)
}