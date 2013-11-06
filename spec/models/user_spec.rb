require 'spec_helper'

describe User do
  before do 
    @user = User.new(name: "Example User", email: "example@example.com", password: "foobar", password_confirmation: "foobar")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation)}

  it { should be_valid }

  describe "When name is not present" do
  	before { @user.name = " " }
  	it { should_not be_valid }
  end

  describe "When e-mail is not present" do
  	before { @user.email = " " }
  	it { should_not be_valid }
  end

  describe "When name is too long" do
  	before { @user.name = ("a" * 51) }
  	it { should_not be_valid }
  end

  describe "When e-mail format is invalid" do
  	it "Should be invalid" do
  		addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
  		addresses.each do |iv|
  			@user.email = iv
  			@user.should_not be_valid
  		end
  	end
  end

  describe "When e-mail format is valid" do
  	it "Should be valid" do
  		addresses = %w[user@foo.com A_USER@f.b.org example.user@foo.org]
  		addresses.each do |v|
  			@user.email = v
  			@user.should be_valid
  		end
  	end
  end

  describe "When eails exists" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "When password is not present" do
    before { @user.password = @user.password_confirmation = " "}
    it { should_not be_valid }
  end

  describe "When password does not = password_confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "When password_confirmation = nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "password length is to short" do
    before { @user.password = "a" * 5 }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }
      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false } 
    end
          
  end
end
