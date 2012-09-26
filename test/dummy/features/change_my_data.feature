Feature: Change personal data

  Background:
    Given my name is Peter and I have an account in the system

  Scenario: Changing personal data flow
    When I access the system
    And I press "My account"
    Then I should see my personal information
    When I press "Change my data"
    And I fill in "Name" with "Peter Summers"
    And I press "Save"
    Then I should see "Personal data successfully changed"
    And I should see "Petter Summers"

  Scenario: Listing my roles
    When I access the system
    And I press "My roles"
    I should see the following table:
      | # | Role name |
      | 1 | Admin     |
      | 2 | Member    |
      | 3 | Publisher |
