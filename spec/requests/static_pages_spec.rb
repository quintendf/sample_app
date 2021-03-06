require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

  	it "should have the h1 'Sample App'" do
  		visit root_path
  		page.should have_selector('h1', :text => 'Sample App')
    end

  	it "should have the base title" do
  		visit root_path
  		page.should have_selector('title',
  			:text => "Ruby on Rails Tutorial Sample App")
  	end

  	it "should not havae a custom title" do
  		visit root_path
  		page.should_not have_selector('title', :text => '| Home')
  	end
  end

  describe 'Help page' do

  	it "Should have the h1 'Help'" do
  		visit help_path
  		page.should have_selector('h1', :text => 'Help')
  	end 

  	it "should have the right title" do
  		visit help_path
  		page.should have_selector('title',
  			:text => "Ruby on Rails Tutorial Sample App | Help")
  	end
  end

  describe 'About page' do

  	it "Should have the h1 'About'" do
  		visit about_path
  		page.should have_selector('h1', :text => 'About')
  	end

  	it "should have the right title" do
  		visit about_path
  		page.should have_selector('title',
  			:text => "Ruby on Rails Tutorial Sample App | About")
  	end
  end

    describe 'Contact Page' do

    it "Should have the h1 'Contact'" do
      visit contact_path
      page.should have_selector('h1', :text => 'Contact')
    end

    it "should have the right title" do
      visit contact_path
      page.should have_selector('title',
        :text => "Ruby on Rails Tutorial Sample App | Contact")
    end
  end

  describe "for signed-in users" do
    let(:user) {FactoryGirl.create(:user) }
    before do
      FactoryGirl.create(:micropost, user: user, content: "Lorem Ipsum")
      FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
      sign_in user
      visit root_path
    end

    it "should render the user's feed" do
      user.feed.each do |item|
        page.should have_selector("li", text: item.content)
      end
    end

    describe "follower/following counts" do
      let(:other_user) { FactoryGirl.create(:user) }
      before do
        other_user.follow!(user)
        visit root_path
      end
    end
  end
end
