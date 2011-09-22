class ApplicationController < ActionController::Base
  protect_from_forgery

  def set_user_tracking_columns(user_trackable, action)
    if action=='create'
      user_trackable.update_attribute(:created_by_id, current_user.id)
    end
    user_trackable.update_attribute(:last_updated_by_id, current_user.id)
  end

end
