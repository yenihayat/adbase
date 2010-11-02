module ApplicationHelper
  def new_record?
    params[:action] == "new"
  end

  # Collect & recraft form error messages. Simpler than default one.
  def form_error_messages(errors)
    if errors.any?
      message = "<div id='form-errors'>"
      errors.full_messages.each do |msg|
        message += msg + (msg == errors.full_messages.last ? "" : ", ")
      end
      message += "</div>"
      return message.html_safe
    end
  end
end
