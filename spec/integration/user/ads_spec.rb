require 'spec_helper'
include Warden::Test::Helpers

describe 'Ads', :js => true do

  before(:all) do
    @conf = FactoryGirl.create :conf
    @user = FactoryGirl.create :user, :role => 'user'
  end

  before (:each) do
    login_as @user, :scope => :user    
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  it "visit ads home page" do
    visit '/ads'

    page.should have_content I18n.t('create_ad')
  end

end

