class Admin::ConfController < ApplicationController

  before_filter :is_admin

  # GET /admin/conf
  # Show global conf params                                HTML
  # ----------------------------------------------------------
  def index
    $conf = Conf.find(1)
  end

  # POST /admin/conf
  # Update global conf params                          REDIRECT
  # -----------------------------------------------------------
  def create
    conf = Conf.find(1).update_attributes(params[:conf])    

    if params[:from]
      redirect_to params[:from]
    else
      redirect_to admin_conf_index_path
    end
  end

end

