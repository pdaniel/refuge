require 'spec_helper'
include Warden::Test::Helpers

describe 'Ads', :js => true do

  before(:all) do
    FactoryGirl.create :conf

    @user = FactoryGirl.create :user, :role => 'user'
    Member.find(@user.id).update_attributes(:location_id => 1)
    @user.reload

    FactoryGirl.create :member, :is_active => false

    (1..2).each do |i|
      FactoryGirl.create :location

      user = FactoryGirl.create :user, :role => 'user'
      Member.find(user.member.id).update_attributes(:first_name => "located at #{i}", :location_id => i)
    end

    (1..3).each do |i|
      FactoryGirl.create :category    
    end

    (1..3).each do |i|
      FactoryGirl.create :ad    
    end    

    FactoryGirl.create :ad, :member_id => 2, :subject => "removed user ad"
    FactoryGirl.create :ad, :member_id => 4, :location_id => 2, :subject => "ad for location 2"
    
  end

  before (:each) do
    login_as @user, :scope => :user    
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  it "visit ads home page" do
    visit ads_path

    page.should have_content I18n.t('create_ad')
    page.should have_content "ad number 2"
    page.should have_content "ad number 3"
  end

  it "do not diplay obsolete ads" do
    visit ads_path

    page.should_not have_content "ad number 1"
  end

  it "do not diplay removed users' ads" do
    visit ads_path

    page.should_not have_content "removed user ad"
  end

  it "only show location related ads" do
    visit ads_path

    page.should_not have_content "ad for location 2"
  end

end

