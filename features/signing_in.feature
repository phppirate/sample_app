Feature: Signing in

Scenario: Unsuccessful signin
  Given a user visits the signin page
  When he submits invalad information
  Then he should see en error message

Scenario: Successful signin
  Given a user visits the signin page
    And the user has an account
    And the user submits valid signin information
   Then he should see the profile page
    And he should see a signout link