class MembersController < ApplicationController

  # GET /members
  # List all members                                    HTML
  # --------------------------------------------------------
  def index
    @members = Member.active.order('first_name ASC')
  end

  # POST /members/search
  # Search for members                                  HTML
  # --------------------------------------------------------
  def search
    @members = Member.search_by params[:category], params[:keywords], params[:is_active]

    render :template => 'members/index'
  end

  # GET /member/:id
  # Show member's profile                               HTML
  # --------------------------------------------------------
  def show
    @member = Member.active.find(params[:id], :include=>:profiles)

    @user_profiles = @member.profiles.map{|p|{p.network_id=>p.url}}
    @pro_networks = Network.with_urls(@user_profiles, :pro)
    @perso_networks = Network.with_urls(@user_profiles, :perso)

    if Member.can_edit?(current_user, @member.id)
      render :template => '/members/edit'
    else
      render :template => '/members/show'
    end

  end

  # POST /members
  # Create a new user                               REDIRECT
  # --------------------------------------------------------
  def create
    
    new_user = User.create(params[:user])

    if new_user.id
      unless params[:no_welcome_email]
        Notifier.welcome_message({
          :to   => params[:user][:email],
          :body => params[:article][:content]
        }).deliver
      end

      redirect_to member_path(new_user.member.id)
    else
      flash[:notice] = t('warnings.check_new_user_parameters')
      redirect_to members_path
    end
  end

  # PUT /members/:id
  # Update a member                                 REDIRECT
  # --------------------------------------------------------
  def update
    params[:member][:logo] = nil if params[:logo_reset] == 'true'

    @member = Member.find(params[:id])

    # EMail, password & role
    if params[:user]
      User.find(@member.user_id).update_attributes(params[:user])
    end

    # Member's profile
    if params[:member]
      @member.update_attributes(params[:member])
      Profile.update(params[:profile], @member.id)
    end

    @user_profiles = @member.profiles.map{|p|{p.network_id=>p.url}}

    @pro_networks = Network.with_urls(@user_profiles, :pro)
    @perso_networks = Network.with_urls(@user_profiles, :perso)

    render :template => '/members/edit'

  end

  # DELETE /members/:id
  # Delete a member                                 REDIRECT
  # --------------------------------------------------------
  def destroy
    User.destroy(params[:id])

    redirect_to members_path
  end

  # POST /members/mail
  # Send an Email to member                         REDIRECT
  # --------------------------------------------------------
  def mail_member

    @from = Member.find(current_user.member.id)
    @to   = Member.find(params[:recipient_id])

    Notifier.mail_message({
      :reply_addr => @from.user.email,
      :to         => @to.user.email,
      :name       => "#{@from.first_name} #{@from.last_name}",
      :subject    => params[:email][:subject],
      :body       => params[:email][:body]
    }).deliver

    redirect_to params[:origin]
  end
  
  def view_as_user
    if current_user.role == 'admin'
      user = User.find(current_user.id)
      user.toggle!(:view_as_user)
    
      render :text => 'toggled'
    else
      render :text => 'error'
    end
  end
end

