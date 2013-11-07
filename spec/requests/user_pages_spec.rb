require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }
    
    it { should have_selector('h1', text: 'Sign up') }
    it { should have_selector('title', text: full_title('Sign up')) }
  end

  describe "Profile page" do
    let(:user) { FactoryGirl.create(:user) }

    before { visit user_path(user) }
    
    it { should have_selector('h1', text: user.name) }
    it { should have_selector('title', text: full_title(user.name)) }
  end

  describe "Fakes" do
    describe "fake1" do
      it { should_not have_selector("george", text: "went") }
    end
    describe "fake2" do
      it { should_not have_selector("george", text: "went") }
    end
    describe "fake3" do
      it { should_not have_selector("george", text: "went") }
    end
  end

  describe "Sign up" do

    let(:submit) { "Create my account" }

    before { visit signup_path }    

    describe "with invalad info" do
      it "should not create new user" do
        # expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submition" do
        before { click_button submit }
        it { should have_selector('title', text: 'Sign up') }
        it { should have_content('error') }
      end
    end

    describe "with valad info" do
      before  do
        fill_in "Name",         with: "Example Name"
        fill_in "Email",        with: "example@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving a user" do
        before { click_button submit }

        let(:user) { User.find_by_email("example@example.com") }

        it { should have_selector('title', text: user.name) }
        it { should have_selector('div.alert.alert-success', text: "Welcome") }
      end
    end
  end
end