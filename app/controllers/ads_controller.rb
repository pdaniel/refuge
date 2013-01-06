class AdsController < ApplicationController
  
  # GET /ads
  # Show all ads                                           HTML
  # -----------------------------------------------------------
  def index
    @categories = Category.all
    @ads = Ad.published.for_location(current_member.location_id)
  end

  # POST /ads
  # Create/update adds                                 REDIRECT
  # -----------------------------------------------------------
  def create

    params[:ad][:member_id] = current_member.id

    if params[:ad_id].strip.blank?
      Ad.create(params[:ad])
    else
      ad = Ad.find(params[:ad_id])
      ad.update_attributes(params[:ad])
    end

    redirect_to  ads_path
  end

  # DELETE /ads/:id
  # Delete an ad                                       REDIRECT
  # -----------------------------------------------------------
  def destroy

    Ad.find(params[:id]).update_attributes(:end_at => Time.now - 1.day)

    redirect_to  ads_path
  end

end

