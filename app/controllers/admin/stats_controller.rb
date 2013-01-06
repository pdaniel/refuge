class Admin::StatsController < ApplicationController

  before_filter :is_admin

  # GET /admin/conf
  # Show global conf params                                HTML
  # ----------------------------------------------------------
  def index
    @users = User.order('sign_in_count DESC').all
  end

end

