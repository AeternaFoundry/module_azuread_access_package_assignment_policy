variable "access_package_assignment_policies" {
  description = <<EOT
Map of access_package_assignment_policies, attributes below
Required:
    - access_package_id
    - description
    - display_name
Optional:
    - duration_in_days
    - expiration_date
    - extension_enabled
    - approval_settings (block):
        - approval_required (optional)
        - approval_required_for_extension (optional)
        - approval_stage (optional, block):
            - alternative_approval_enabled (optional)
            - alternative_approver (optional, block):
                - backup (optional)
                - object_id (optional)
                - subject_type (required)
            - approval_timeout_in_days (required)
            - approver_justification_required (optional)
            - enable_alternative_approval_in_days (optional)
            - primary_approver (optional, block):
                - backup (optional)
                - object_id (optional)
                - subject_type (required)
        - requestor_justification_required (optional)
    - assignment_review_settings (block):
        - access_recommendation_enabled (optional)
        - access_review_timeout_behavior (optional)
        - approver_justification_required (optional)
        - duration_in_days (optional)
        - enabled (optional)
        - review_frequency (optional)
        - review_type (optional)
        - reviewer (optional, block):
            - backup (optional)
            - object_id (optional)
            - subject_type (required)
        - starting_on (optional)
    - question (block):
        - choice (optional, block):
            - actual_value (required)
            - display_value (required, block):
                - default_text (required)
                - localized_text (optional, block):
                    - content (required)
                    - language_code (required)
        - required (optional)
        - sequence (optional)
        - text (required, block):
            - default_text (required)
            - localized_text (optional, block):
                - content (required)
                - language_code (required)
    - requestor_settings (block):
        - requestor (optional, block):
            - backup (optional)
            - object_id (optional)
            - subject_type (required)
        - requests_accepted (optional)
        - scope_type (optional)
EOT

  type = map(object({
    access_package_id = string
    description       = string
    display_name      = string
    duration_in_days  = optional(number)
    expiration_date   = optional(string)
    extension_enabled = optional(bool)
    approval_settings = optional(object({
      approval_required               = optional(bool)
      approval_required_for_extension = optional(bool)
      approval_stage = optional(list(object({
        alternative_approval_enabled = optional(bool)
        alternative_approver = optional(list(object({
          backup       = optional(bool)
          object_id    = optional(string)
          subject_type = string
        })))
        approval_timeout_in_days            = number
        approver_justification_required     = optional(bool)
        enable_alternative_approval_in_days = optional(number)
        primary_approver = optional(list(object({
          backup       = optional(bool)
          object_id    = optional(string)
          subject_type = string
        })))
      })))
      requestor_justification_required = optional(bool)
    }))
    assignment_review_settings = optional(object({
      access_recommendation_enabled   = optional(bool)
      access_review_timeout_behavior  = optional(string)
      approver_justification_required = optional(bool)
      duration_in_days                = optional(number)
      enabled                         = optional(bool)
      review_frequency                = optional(string)
      review_type                     = optional(string)
      reviewer = optional(list(object({
        backup       = optional(bool)
        object_id    = optional(string)
        subject_type = string
      })))
      starting_on = optional(string)
    }))
    question = optional(list(object({
      choice = optional(list(object({
        actual_value = string
        display_value = object({
          default_text = string
          localized_text = optional(list(object({
            content       = string
            language_code = string
          })))
        })
      })))
      required = optional(bool)
      sequence = optional(number)
      text = object({
        default_text = string
        localized_text = optional(list(object({
          content       = string
          language_code = string
        })))
      })
    })))
    requestor_settings = optional(object({
      requestor = optional(list(object({
        backup       = optional(bool)
        object_id    = optional(string)
        subject_type = string
      })))
      requests_accepted = optional(bool)
      scope_type        = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.access_package_assignment_policies : (
        can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", v.access_package_id))
      )
    ])
    error_message = "must be a valid UUID"
  }
  validation {
    condition = alltrue([
      for k, v in var.access_package_assignment_policies : (
        length(v.display_name) > 0
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.access_package_assignment_policies : (
        length(v.description) > 0
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.access_package_assignment_policies : (
        v.duration_in_days == null || (v.duration_in_days >= 0 && v.duration_in_days <= 3660)
      )
    ])
    error_message = "must be between 0 and 3660"
  }
  validation {
    condition = alltrue([
      for k, v in var.access_package_assignment_policies : (
        v.requestor_settings == null || (v.requestor_settings.requestor == null || alltrue([for item in v.requestor_settings.requestor : (contains([for v in ["ConnectedOrganizationMembers", "ExternalSponsors", "GroupMembers", "InternalSponsors", "RequestorManager", "SingleUser", "TargetUserSponsors"] : lower(v)], lower(item.subject_type)))]))
      )
    ])
    error_message = "must be one of: ConnectedOrganizationMembers, ExternalSponsors, GroupMembers, InternalSponsors, RequestorManager, SingleUser, TargetUserSponsors"
  }
  validation {
    condition = alltrue([
      for k, v in var.access_package_assignment_policies : (
        v.approval_settings == null || (v.approval_settings.approval_stage == null || alltrue([for item in v.approval_settings.approval_stage : (item.primary_approver == null || alltrue([for item in item.primary_approver : (contains([for v in ["ConnectedOrganizationMembers", "ExternalSponsors", "GroupMembers", "InternalSponsors", "RequestorManager", "SingleUser", "TargetUserSponsors"] : lower(v)], lower(item.subject_type)))]))]))
      )
    ])
    error_message = "must be one of: ConnectedOrganizationMembers, ExternalSponsors, GroupMembers, InternalSponsors, RequestorManager, SingleUser, TargetUserSponsors"
  }
  validation {
    condition = alltrue([
      for k, v in var.access_package_assignment_policies : (
        v.approval_settings == null || (v.approval_settings.approval_stage == null || alltrue([for item in v.approval_settings.approval_stage : (item.alternative_approver == null || alltrue([for item in item.alternative_approver : (contains([for v in ["ConnectedOrganizationMembers", "ExternalSponsors", "GroupMembers", "InternalSponsors", "RequestorManager", "SingleUser", "TargetUserSponsors"] : lower(v)], lower(item.subject_type)))]))]))
      )
    ])
    error_message = "must be one of: ConnectedOrganizationMembers, ExternalSponsors, GroupMembers, InternalSponsors, RequestorManager, SingleUser, TargetUserSponsors"
  }
  validation {
    condition = alltrue([
      for k, v in var.access_package_assignment_policies : (
        v.assignment_review_settings == null || (v.assignment_review_settings.reviewer == null || alltrue([for item in v.assignment_review_settings.reviewer : (contains([for v in ["ConnectedOrganizationMembers", "ExternalSponsors", "GroupMembers", "InternalSponsors", "RequestorManager", "SingleUser", "TargetUserSponsors"] : lower(v)], lower(item.subject_type)))]))
      )
    ])
    error_message = "must be one of: ConnectedOrganizationMembers, ExternalSponsors, GroupMembers, InternalSponsors, RequestorManager, SingleUser, TargetUserSponsors"
  }
  # Note: 8 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

