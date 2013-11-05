require 'spec_helper'

describe User do
  before { @user = User.new(name: "Example User", email: "example@example.com") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }

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


end
