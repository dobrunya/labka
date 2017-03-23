class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def function
    Math.tan(5*params[:val].to_i)
  end

  def log_action(id, danger_level, message)
    ActionJournal.create(user_id: id, danger_level: danger_level, comment: message)
  end
end
