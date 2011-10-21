class ApplicationController < ActionController::Base
  protect_from_forgery

  def set_user_tracking_columns(user_trackable, action)
    puts user_trackable.inspect
    puts action.inspect
    return if current_user.nil?
    if action=='create'
      user_trackable.update_attribute(:created_by_id, current_user.id)
    end
    user_trackable.update_attribute(:last_updated_by_id, current_user.id)
  end

end
