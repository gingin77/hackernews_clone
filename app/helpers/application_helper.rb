module ApplicationHelper
  def show_errors_on_base(resource, field_name)
    if resource.errors.any? && resource.errors.messages[field_name].present?
      content_tag(:div, resource.errors.full_messages_for(field_name).join(", "), class: "alert alert-alert")
    end
  end

  def show_errors_inline(resource, field_name)
    if resource.errors.any? && resource.errors.full_messages_for(field_name).present? && !resource.errors[:base].present?
      content_tag(:div, resource.errors.full_messages_for(field_name).join(", "), class: "alert alert-alert inline-alert")
    end
  end

  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
  end
end