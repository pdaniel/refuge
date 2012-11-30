class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :is_logged, :load_conf, :current_member

  rescue_from ActiveRecord::RecordNotFound, :with => :not_found

  # Check we're logged
  def is_logged
    # Place here controllers where authentication is not required
    unsecured = ['devise/sessions', 'devise/passwords', 'iframes/members']

    redirect_to '/users/sign_in' if (!user_signed_in? && !unsecured.include?(params[:controller]))
  end

  # Check we're admin
  def is_admin
    redirect_to '/' unless (current_user.role == 'admin' && !current_user.view_as_user)
  end

  # Load global conf
  def load_conf
    $conf = Conf.find(1)
  end

  # 404 on record not found
  def not_found
    render :file => "#{Rails.root}/public/404.html", :layout => false, :status => 404
  end

  def current_member
    current_user.member if current_user
  end
  
  def update_occupation
    g_locations = Gardien::Location.all
    
    puts g_locations
    
    @members_on_site = {}
    
    g_locations.each do |g_location|
      r_location = Location.find_by_refuge_id(g_location.id)
      if r_location
        r_location.update_attributes({:occupation => g_location.members.count})
        
        @members_on_site[r_location.id] = g_location.members
      end
    end
  end

  helper_method :current_member

end

