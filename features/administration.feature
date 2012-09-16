Feature: Access the system as an administrator
  Scenario: Access with valid data
    Given that there is an administrator with the email "admin@domain.com" and password "123456"
    When I try to access the admin dashboard with the email "admin@domain.com" and senha "123456"
    Then I should be at admin dashboard page

  Scenario: Access with invalid data
    Given that there is an administrator with the email "admin@domain.com" and password "123456"
    When I try to access the admin dashbaord with the email "admin@domain.com" and senha "654321"
    Then I should see "Invalid username/password"