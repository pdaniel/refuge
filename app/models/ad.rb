class Ad < ActiveRecord::Base
  belongs_to :category
  belongs_to :member

  scope :all_categories_for_location, lambda {|member|
    self.where(['end_at > ? AND (location_id = 0 OR location_id = ? OR member_id = ?) AND members.is_active = ?', Time.now, member.location_id, member.id, true]).order('ads.created_at DESC').includes(:member)
  }

  scope :for_location, lambda {|location_id|
    self.where(['ads.location_id = 0 OR ads.location_id = ?',location_id]).order('ads.created_at DESC')
  }

  scope :published, where(['end_at > ? AND members.is_active = ?', Time.now - 1.day, true]).includes(:member).order('created_at DESC')
end

