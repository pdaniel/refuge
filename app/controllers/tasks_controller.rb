class TasksController < ApplicationController
  
  before_filter :check_token

  # GET /tasks/:name/:token
  # Tasks handler (called via cron + wget)                 HTML
  # -----------------------------------------------------------
  def trigger

    case params[:name]
    when 'remplitude'
      Location.update_remplitude
    when 'hours'
      Member.update_hours
    end

    render :nothing => true
  end

private

  # No crawlers and bots here plz
  def check_token    
    redirect_to '/users/sign_in' if params[:token] != $conf.tasks_token
  end
end

