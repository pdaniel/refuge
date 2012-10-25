class PagesController < ApplicationController

  before_filter :is_logged
  before_filter :load_conf

  # GET /pages
  # Redirect ot first existent page                          REDIRECT
  # -----------------------------------------------------------------
  def index
    # CRAPPY !!!!!! TODO : improve pages/menus managment to allow multiple "pages" layout 
    redirect_to page_path('meetings')
  end
  
  # GET /pages/:id
  # Show pages in given category                                 HTML
  # -----------------------------------------------------------------
  def show
    @articles = Article.get_page_articles(current_user.member.location_id, params[:id])

    @locations = Location.all
  end

  # POST /pages
  # Create new article                                       REDIRECT
  # -----------------------------------------------------------------
  def create

    Article.create(params[:article])

    redirect_to "/pages/#{params[:article][:category]}"

  end

  # POST /pages/:id
  # Update an article                                        REDIRECT
  # -----------------------------------------------------------------
  def update

    Article.find(params[:id]).update_attributes(params[:article])

    redirect_to "/pages/#{params[:article][:category]}"

  end

  # DELETE /pages/:id
  # Delete an article                                        REDIRECT
  # -----------------------------------------------------------------
  def destroy
    delete_article = Article.destroy(params[:id])

    redirect_to "/pages/#{delete_article.category}"

  end

end

