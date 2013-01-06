class Admin::MenusController < ApplicationController

  before_filter :is_admin

  # GET /admin/menus
  # Show available pages                                  HTML
  # ----------------------------------------------------------
  def index
    @items = Menu.order('position ASC').all
  end

  # POST /admin/conf
  # Update pages attributes                            REDIRECT
  # -----------------------------------------------------------
  def create
    # Since unchecked checkboxes are not sent in params, populate them manually
    params[:item].each {|item, value| value.update('published' => false) if !value.has_key?('published')}
 
    Menu.update(params[:item].keys, params[:item].values)    

    redirect_to admin_menus_path
  end

end

