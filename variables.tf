variable "allow_image_builder" {
  type        = bool
  description = "Allow EC2 Image Builder to send messages to SNS topics encrypted with this key."
  default     = false
}

variable "description" {
  type        = string
  description = ""
  default     = "A KMS key used to encrypt SNS messages at-rest."
}

variable "key_deletion_window_in_days" {
  type        = string
  description = "Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days."
  default     = 30
}

variable "name" {
  type        = string
  description = "The display name of the alias. The name must start with the word \"alias\" followed by a forward slash (alias/)."
  default     = "alias/sns"
}

variable "services" {
  type        = list(string)
  description = "Services that can use this KMS key."
  default     = ["cloudwatch.amazonaws.com", "events.amazonaws.com", "sns.amazonaws.com"]
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to the KMS key."
  default     = {}
}
