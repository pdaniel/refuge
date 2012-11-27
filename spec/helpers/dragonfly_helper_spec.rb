require 'spec_helper'
require 'RMagick'

describe DragonflyHelper do

  before :all do
    @member = FactoryGirl.create :member  

    @stamp = File.new(File.join(Rails.root, 'public', 'system', 'dragonfly', 'test', 'default_avatar.png')).mtime.to_i
  end

  after :all do
    DatabaseCleaner.clean
  end

  describe "image tag generator" do

    it "should return an image tag with a default alt, width and height attributes" do
      thumbnail_tag( @member, :avatar, '10x10')
        .should == "<img src='/thumbnails/member/1/avatar/10x10/default_avatar.png?#{@stamp}' width='10' height='10' alt='default_avatar' />"
    end

    it "should return an image tag with named alt" do
      thumbnail_tag(@member, :avatar, '10x10', :alt => 'image title')
        .should == "<img src='/thumbnails/member/1/avatar/10x10/default_avatar.png?#{@stamp}' width='10' height='10' alt='image title'  />"
    end

    it "should return an image tag with a style attribute" do
      thumbnail_tag(@member, :avatar, '10x10', :alt => 'image title', :style => 'height:10px;')
        .should == "<img src='/thumbnails/member/1/avatar/10x10/default_avatar.png?#{@stamp}' width='10' height='10' alt='image title' style='height:10px;'  />"
    end

    it "should return an image tag with data attributes" do
      thumbnail_tag(@member, :avatar, '10x10', :data => {:do => 'some_action', :handle =>'a_thing'})
        .should == "<img src='/thumbnails/member/1/avatar/10x10/default_avatar.png?#{@stamp}' width='10' height='10' data-do='some_action' data-handle='a_thing' alt='default_avatar' />"
    end

    it "should return an image tag without width and height params" do
      thumbnail_tag(@member, :avatar, '10x')
        .should == "<img src='/thumbnails/member/1/avatar/10x/default_avatar.png?#{@stamp}'  alt='default_avatar' />"
    end

    it "should return an image tag without width and height params" do
      thumbnail_tag(@member, :avatar, '50x50+10')
        .should == "<img src='/thumbnails/member/1/avatar/50x50+10/default_avatar.png?#{@stamp}'  alt='default_avatar' />"
    end

  end
end