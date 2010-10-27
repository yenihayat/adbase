module ApplicationHelper
  def new_record?
    params[:action] == "new"
  end
end
