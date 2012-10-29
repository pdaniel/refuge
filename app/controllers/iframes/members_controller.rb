class Iframes::MembersController < ApplicationController

  layout 'iframe'

  # GET /iframes/members
  # List all members                                    HTML
  # --------------------------------------------------------
  def index
    @members = Member.order('first_name ASC')
  end

  # POST /iframes/members/search
  # Search for members                                  HTML
  # --------------------------------------------------------
  def search
    @members = Member.search_by(params[:category], params[:keywords], params[:is_active])

    render :template => '/iframes/members/index'
  end

  # GET /iframes/members/:id
  # Show member's profile                               HTML
  # --------------------------------------------------------
  def show
    @member = Member.where(['members.id = ?', params[:id]]).first

    raise ActiveRecord::RecordNotFound.new(:not_found) if !@member

  end

end

