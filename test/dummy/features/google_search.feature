@mechanize
Feature: Searching on Google
  Scenario: Search for New York Times
    Given I am at the google page
    When I search for "New York Times"
    Then I should see "The New York Times - Breaking News, World News & Multimedia"