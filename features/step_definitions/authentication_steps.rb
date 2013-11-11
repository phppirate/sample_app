Given (/^a user visits the signin page$/) do
  visit signin_path
end

When(/^he submits invalad information$/) do
  click_button "Sign in"
end

Then(/^he should see en error message$/) do
  page.should have_selector('div.alert.alert-danger')
end

Given(/^the user has an account$/) do
  @user = User.create(name: "Tester", 
                      email: "tester@example.com",
                      password: "testing", 
                      password_confirmation: "testing")
end

Given(/^the user submits valid signin information$/) do
  fill_in "Email", with: @user.email
  fill_in "Password", with: @user.password
  click_button "Sign in"
end

Then(/^he should see the profile page$/) do
  page.should have_selector("title", text: @user.name)
end

Then(/^he should see a signout link$/) do
  page.should have_link("Sign out", href: signout_path)
end