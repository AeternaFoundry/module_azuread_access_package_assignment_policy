resource "azuread_access_package_assignment_policy" "access_package_assignment_policies" {
  for_each = var.access_package_assignment_policies

  access_package_id = each.value.access_package_id
  description       = each.value.description
  display_name      = each.value.display_name
  duration_in_days  = each.value.duration_in_days
  expiration_date   = each.value.expiration_date
  extension_enabled = each.value.extension_enabled

  dynamic "approval_settings" {
    for_each = each.value.approval_settings != null ? [each.value.approval_settings] : []
    content {
      approval_required               = approval_settings.value.approval_required
      approval_required_for_extension = approval_settings.value.approval_required_for_extension
      dynamic "approval_stage" {
        for_each = approval_settings.value.approval_stage != null ? approval_settings.value.approval_stage : []
        content {
          alternative_approval_enabled = approval_stage.value.alternative_approval_enabled
          dynamic "alternative_approver" {
            for_each = approval_stage.value.alternative_approver != null ? approval_stage.value.alternative_approver : []
            content {
              backup       = alternative_approver.value.backup
              object_id    = alternative_approver.value.object_id
              subject_type = alternative_approver.value.subject_type
            }
          }
          approval_timeout_in_days            = approval_stage.value.approval_timeout_in_days
          approver_justification_required     = approval_stage.value.approver_justification_required
          enable_alternative_approval_in_days = approval_stage.value.enable_alternative_approval_in_days
          dynamic "primary_approver" {
            for_each = approval_stage.value.primary_approver != null ? approval_stage.value.primary_approver : []
            content {
              backup       = primary_approver.value.backup
              object_id    = primary_approver.value.object_id
              subject_type = primary_approver.value.subject_type
            }
          }
        }
      }
      requestor_justification_required = approval_settings.value.requestor_justification_required
    }
  }

  dynamic "assignment_review_settings" {
    for_each = each.value.assignment_review_settings != null ? [each.value.assignment_review_settings] : []
    content {
      access_recommendation_enabled   = assignment_review_settings.value.access_recommendation_enabled
      access_review_timeout_behavior  = assignment_review_settings.value.access_review_timeout_behavior
      approver_justification_required = assignment_review_settings.value.approver_justification_required
      duration_in_days                = assignment_review_settings.value.duration_in_days
      enabled                         = assignment_review_settings.value.enabled
      review_frequency                = assignment_review_settings.value.review_frequency
      review_type                     = assignment_review_settings.value.review_type
      dynamic "reviewer" {
        for_each = assignment_review_settings.value.reviewer != null ? assignment_review_settings.value.reviewer : []
        content {
          backup       = reviewer.value.backup
          object_id    = reviewer.value.object_id
          subject_type = reviewer.value.subject_type
        }
      }
      starting_on = assignment_review_settings.value.starting_on
    }
  }

  dynamic "question" {
    for_each = each.value.question != null ? each.value.question : []
    content {
      dynamic "choice" {
        for_each = question.value.choice != null ? question.value.choice : []
        content {
          actual_value = choice.value.actual_value
          display_value {
            default_text = choice.value.display_value.default_text
            dynamic "localized_text" {
              for_each = choice.value.display_value.localized_text != null ? choice.value.display_value.localized_text : []
              content {
                content       = localized_text.value.content
                language_code = localized_text.value.language_code
              }
            }
          }
        }
      }
      required = question.value.required
      sequence = question.value.sequence
      text {
        default_text = question.value.text.default_text
        dynamic "localized_text" {
          for_each = question.value.text.localized_text != null ? question.value.text.localized_text : []
          content {
            content       = localized_text.value.content
            language_code = localized_text.value.language_code
          }
        }
      }
    }
  }

  dynamic "requestor_settings" {
    for_each = each.value.requestor_settings != null ? [each.value.requestor_settings] : []
    content {
      dynamic "requestor" {
        for_each = requestor_settings.value.requestor != null ? requestor_settings.value.requestor : []
        content {
          backup       = requestor.value.backup
          object_id    = requestor.value.object_id
          subject_type = requestor.value.subject_type
        }
      }
      requests_accepted = requestor_settings.value.requests_accepted
      scope_type        = requestor_settings.value.scope_type
    }
  }
}

