require 'spec_helper'
include Warden::Test::Helpers

describe 'Blog', :js => true do

  before(:all) do
    @conf = FactoryGirl.create :conf
    @user = FactoryGirl.create :user, role: 'admin'
  end

  before (:each) do
    login_as @user, :scope => :user    
  end
 
  after(:all) do
    DatabaseCleaner.clean
  end

  it "Create a new category" do
    visit '/admin/blog_categories'

    click_link I18n.t('create_blog_category')

    fill_in('category_1_name', :with => 'first_category')
    click_button I18n.t('save')

    visit '/blog'
    page.should have_content('first_category')
  end

  it "Save a new post" do
    visit '/blog'
    click_link I18n.t('blog.create_post')

    fill_in('post_title', :with => 'new_post_title')
    page.execute_script('tinyMCE.get("post[content]").setContent("new_post_body")')
    
    click_button I18n.t('blog.save_post')

    page.should have_content('New_post_title')
  end

  it "Edit an existing blog post" do
    visit '/blog/1'

    click_link I18n.t('blog.edit_this_post')
    sleep 1
    fill_in('post_title', :with => 'Edited_post_title')
    page.execute_script('tinyMCE.get("post[content]").setContent("edited_post_body")')
    
    click_button I18n.t('blog.save_post')

    page.should have_content('Edited_post_title')
  end

  it "Add a new comment" do
    visit '/blog/1'

    fill_in('comment', :with => 'new comment by test member')
    click_button I18n.t('save')

    page.should have_content('new comment by test member')
  end

  it "Delete the comment" do
    visit '/blog/1'

    page.find('.comment').find('.label-important').click
    page.driver.browser.switch_to.alert.accept

    page.should_not have_content('new comment by marie')
  end

  it "Delete the blog post" do
    visit '/blog/1'

    click_link I18n.t('blog.edit_this_post')
    sleep 1
    click_link I18n.t('blog.delete_post')
    page.driver.browser.switch_to.alert.accept

    visit '/blog'

    page.should_not have_content I18n.t('Edited_post_title')
  end

end

