output "access_package_assignment_policies_id" {
  description = "Map of id values across all access_package_assignment_policies, keyed the same as var.access_package_assignment_policies"
  value       = { for k, v in azuread_access_package_assignment_policy.access_package_assignment_policies : k => v.id if v.id != null && length(v.id) > 0 }
}
output "access_package_assignment_policies_access_package_id" {
  description = "Map of access_package_id values across all access_package_assignment_policies, keyed the same as var.access_package_assignment_policies"
  value       = { for k, v in azuread_access_package_assignment_policy.access_package_assignment_policies : k => v.access_package_id if v.access_package_id != null && length(v.access_package_id) > 0 }
}
output "access_package_assignment_policies_approval_settings" {
  description = "Map of approval_settings values across all access_package_assignment_policies, keyed the same as var.access_package_assignment_policies"
  value       = { for k, v in azuread_access_package_assignment_policy.access_package_assignment_policies : k => one(v.approval_settings) if v.approval_settings != null && length(v.approval_settings) > 0 }
}
output "access_package_assignment_policies_assignment_review_settings" {
  description = "Map of assignment_review_settings values across all access_package_assignment_policies, keyed the same as var.access_package_assignment_policies"
  value       = { for k, v in azuread_access_package_assignment_policy.access_package_assignment_policies : k => one(v.assignment_review_settings) if v.assignment_review_settings != null && length(v.assignment_review_settings) > 0 }
}
output "access_package_assignment_policies_description" {
  description = "Map of description values across all access_package_assignment_policies, keyed the same as var.access_package_assignment_policies"
  value       = { for k, v in azuread_access_package_assignment_policy.access_package_assignment_policies : k => v.description if v.description != null && length(v.description) > 0 }
}
output "access_package_assignment_policies_display_name" {
  description = "Map of display_name values across all access_package_assignment_policies, keyed the same as var.access_package_assignment_policies"
  value       = { for k, v in azuread_access_package_assignment_policy.access_package_assignment_policies : k => v.display_name if v.display_name != null && length(v.display_name) > 0 }
}
output "access_package_assignment_policies_duration_in_days" {
  description = "Map of duration_in_days values across all access_package_assignment_policies, keyed the same as var.access_package_assignment_policies"
  value       = { for k, v in azuread_access_package_assignment_policy.access_package_assignment_policies : k => v.duration_in_days if v.duration_in_days != null }
}
output "access_package_assignment_policies_expiration_date" {
  description = "Map of expiration_date values across all access_package_assignment_policies, keyed the same as var.access_package_assignment_policies"
  value       = { for k, v in azuread_access_package_assignment_policy.access_package_assignment_policies : k => v.expiration_date if v.expiration_date != null && length(v.expiration_date) > 0 }
}
output "access_package_assignment_policies_extension_enabled" {
  description = "Map of extension_enabled values across all access_package_assignment_policies, keyed the same as var.access_package_assignment_policies"
  value       = { for k, v in azuread_access_package_assignment_policy.access_package_assignment_policies : k => v.extension_enabled if v.extension_enabled != null }
}
output "access_package_assignment_policies_question" {
  description = "Map of question values across all access_package_assignment_policies, keyed the same as var.access_package_assignment_policies"
  value       = { for k, v in azuread_access_package_assignment_policy.access_package_assignment_policies : k => v.question if v.question != null && length(v.question) > 0 }
}
output "access_package_assignment_policies_requestor_settings" {
  description = "Map of requestor_settings values across all access_package_assignment_policies, keyed the same as var.access_package_assignment_policies"
  value       = { for k, v in azuread_access_package_assignment_policy.access_package_assignment_policies : k => one(v.requestor_settings) if v.requestor_settings != null && length(v.requestor_settings) > 0 }
}

