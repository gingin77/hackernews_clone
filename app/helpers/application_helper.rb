module ApplicationHelper
  def show_errors_on_base(obj)
    if obj.errors.any? && obj.errors.messages[:base].present?
      content_tag(:div, obj.errors.full_messages_for(:base).join(", "), class: "alert alert-alert")
    end
  end

  def show_errors_inline(obj, field_name)
    if obj.errors.any? && obj.errors.full_messages_for(field_name).present? && !obj.errors[:base].present?
      content_tag(:div, obj.errors.full_messages_for(field_name).join(", "), class: "alert alert-alert inline-alert")
    end
  end
end
