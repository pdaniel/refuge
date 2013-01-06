class Admin::HeadlinesController < ApplicationController

  before_filter :is_admin

  # GET /admin/headlines
  # Show current headline                                  HTML
  # -----------------------------------------------------------
  def create
    $conf = Conf.find(1)
  end
  
  # POST /admin/headlines
  # Update headline                                    REDIRECT
  # -----------------------------------------------------------
  def create
    Conf.find(1).update_attributes(params[:conf])
   
    redirect_to admin_headlines_path
  end

end

