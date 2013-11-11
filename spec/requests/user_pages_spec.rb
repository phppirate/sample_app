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
        it { should have_content('Invalid') }
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
        it { should have_link("Sign out") }
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_selector('h1', text: "Update your profile") }
      it { should have_selector('title', text: "Edit user") }
      it { should have_link('Change', text: "http://gravatar.com/emails") }
    end

    describe "with invalad information" do
      before { click_button "Save changes"}

      it { should have_selector('div.alert.alert-danger', text: "Invalid") }
    end

    describe "with valad information" do
      let(:new_name) { "new name" }
      let(:new_email) { "new@example.com" }
      before  do
        fill_in "Name",         with: new_name
        fill_in "Email",        with: new_email
        fill_in "Password",     with: user.password
        fill_in "Confirmation", with: user.password
        click_button "Save changes"
      end

      it { should have_selector('title', text: new_name) }
      it { should have_link('Sign out', href: signout_path) }
      it { should have_selector('div.alert.alert-success') }
      specify { user.reload.name.should == new_name }
      specify { user.reload.email.should == new_email }
    end

  end
end