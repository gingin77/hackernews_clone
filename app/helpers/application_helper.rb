module ApplicationHelper
  def show_errors_on_base(object)
    if object.errors.any? && object.errors.messages[:base].present?
      content_tag(:div, object.errors.full_messages_for(:base).join(", "), class: "alert alert-alert")
    end
  end

  def show_errors_inline(object, field_name)
    if object.errors.any? && object.errors.full_messages_for(field_name).present? && !new_post.errors[:base].present?
      content_tag(:div, object.errors.full_messages_for(field_name).join(", "), class: "alert alert-alert inline-alert")
    end
  end
end
