class Admin::HomesController < ApplicationController

  before_action :authenticate_admin!

  def redirect_url
    new_admin_session_path
  end

  def top
  end

end
