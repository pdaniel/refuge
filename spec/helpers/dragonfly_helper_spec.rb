require 'spec_helper'
require 'RMagick'

describe DragonflyHelper do

  before :all do
    @member = FactoryGirl.create :member  

    FileUtils.rm_rf("#{Rails.root}/public/images/cache")
    resource = "#{Rails.root}/public/system/dragonfly/test/#{@member.avatar_uid}"
    
    image = Magick::Image.new(100, 100)
    image.write(resource)

    @stamp = File.new(resource).mtime.to_i
  end

  after :all do
    DatabaseCleaner.clean
    FileUtils.rm_rf("#{Rails.root}/public/images/cache")
    FileUtils.rm_rf("#{Rails.root}/public/system/dragonfly/test/#{@member.avatar_uid}")
  end

  describe "image tag generator" do

    it "should return an image tag with a default alt, width and height attributes" do
      thumbnail_tag(@member.avatar, '10x10')
        .should == "<img src='/images/cache/10x10/default_avatar.png?#{@stamp}' width='10px' height='10px' alt='default_avatar' />"
    end

    it "should have generate a thumb in proper directory" do
      File.exists?("#{Rails.root}/public/images/cache/10x10/default_avatar.png").should == true
      FileUtils.rm_rf("#{Rails.root}/public/images/cache")
    end

    it "should return an image tag with named alt" do
      thumbnail_tag(@member.avatar, '10x10', :alt => 'image title')
        .should == "<img src='/images/cache/10x10/default_avatar.png?#{@stamp}' width='10px' height='10px' alt='image title'  />"
    end

    it "should have generate a thumb in proper directory" do
      File.exists?("#{Rails.root}/public/images/cache/10x10/default_avatar.png").should == true
      FileUtils.rm_rf("#{Rails.root}/public/images/cache")
    end

    it "should return an image tag with a style attribute" do
      thumbnail_tag(@member.avatar, '10x10', :alt => 'image title', :style => 'height:10px;')
        .should == "<img src='/images/cache/10x10/default_avatar.png?#{@stamp}' width='10px' height='10px' alt='image title' style='height:10px;'  />"
    end

    it "should have generate a thumb in proper directory" do
      File.exists?("#{Rails.root}/public/images/cache/10x10/default_avatar.png").should == true
      FileUtils.rm_rf("#{Rails.root}/public/images/cache")
    end

    it "should return an image tag with data attributes" do
      thumbnail_tag(@member.avatar, '10x10', :data => {:do => 'some_action', :handle =>'a_thing'})
        .should == "<img src='/images/cache/10x10/default_avatar.png?#{@stamp}' width='10px' height='10px' data-do='some_action' data-handle='a_thing' alt='default_avatar' />"
    end

    it "should have generate a thumb in proper directory" do
      File.exists?("#{Rails.root}/public/images/cache/10x10/default_avatar.png").should == true
      FileUtils.rm_rf("#{Rails.root}/public/images/cache")
    end

    it "should return an image tag without width and height params" do
      thumbnail_tag(@member.avatar, '10x')
        .should == "<img src='/images/cache/10x/default_avatar.png?#{@stamp}'  alt='default_avatar' />"
    end

    it "should have generate a thumb in proper directory" do
      File.exists?("#{Rails.root}/public/images/cache/10x/default_avatar.png").should == true
      FileUtils.rm_rf("#{Rails.root}/public/images/cache")
    end

    it "should return an image tag without width and height params" do
      thumbnail_tag(@member.avatar, '50x50+10')
        .should == "<img src='/images/cache/50x50+10/default_avatar.png?#{@stamp}'  alt='default_avatar' />"
    end

    it "should have generate a thumb in proper directory" do
      File.exists?("#{Rails.root}/public/images/cache/50x50+10/default_avatar.png").should == true
      FileUtils.rm_rf("#{Rails.root}/public/images/cache")
    end

    it "should return an image tag with a custom path" do
      thumbnail_tag(@member.avatar, '10x10', :path => '/images/cache/products')
        .should == "<img src='/images/cache/products/10x10/default_avatar.png?#{@stamp}' width='10px' height='10px' alt='default_avatar' />"
    end

    it "should have generate a thumb in proper directory" do
      File.exists?("#{Rails.root}/public/images/cache/products/10x10/default_avatar.png").should == true
      FileUtils.rm_rf("#{Rails.root}/public/images/cache")
    end

  end
end