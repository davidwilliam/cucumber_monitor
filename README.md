# Cucumber Monitor - Visualization and manipulation of cucumber features..

"**Cucumber** lets software development teams describe how software should behave in plain text. The text is written in a business-readable domain-specific language and serves as documentation, automated tests and development-aid - all rolled into one format". (From Cucumber's page: http://cukes.info/)

Cucumber is an extraordinary tool that allows developers and customers (and any other non-technical team member) work on the same feature description.

**Cucumber Monitor** aims to give a better view of the functionality described in Cucumber and enable better customer interaction.

With **Cucumber Monitor**, you have a dynamic documentation in real time. The client (and any other team member) can: 

* Browse through the features
* Search for keywords and track features, scenarios and steps that are added to Cucumber as developers move forward in their work
* Performs the features directly from the browser and displays the test results

## Motivation

I use Cucumber in almost every web app I develop. Since I'm always in direct contact with the customer, Cucumber is always an excellent choice for writing integration tests in which I describe and test the behavior of the web application.

At first, writing features may seem costly and even boring, but it completely changes after experiencing the flexibility and power of Cucumber.

I tried to show the Cucumber's features to my clients but none was excited to look on the outputs of the terminals or even at the descriptions in plain text in my text editor. I know I could generate a report using one of the friendliest Cucumber's formatters or even writing a custom formatter but it would still be a static and historical view of the app features described in Cucumber.

So I decided to display the features in browser, inside the rails app, so that customers can track the application features as they are added.

## Installation

Add it to your Gemfile:

`gem 'cucumber_monitor'`

Run the following command to install it:

`bundle install`

## Usage

Assuming you have a Rails application with Cucumber features, you need to access: /cucumber_monitor. Let's say you are running your application on localhost using port 3000:

`http://localhost:3000/cucumber_monitor`

You will see a list with all cucumber features you have. You can view the contents of each one, you can search by keywords and you can run the features and see the test results right from your browser.

### CucumberMonitor API

You can also use the CucumberMonitor API in order to manage your features the way you like.

CucumberMonitor needs cucumber-rails in order to work properly. So, to check if cucumber-rails is ready:

```ruby
CucumberMonitor.cucumber_rails_ready?
```

To start with CucumberMonitor:

```ruby
cucumber_monitor = CucumberMonitor.new
```

To get a list of all features:

```ruby
cucumber_monitor.features
```

The feature object returns (some examples):

```ruby
feature = cucumber_monitor.features.first
feature.file # "managing_users.feature"
feature.name # "managing_user"
feature.description # "Managing user's information"
feature.lines.size # line numbers
feature.contexts # list of background objects
feature.scenarios # list of scenarios objects
```

You can also find a feature by name. It returns an array of feature objects when there is more then one feature that matches the search. It returns the feature object if there is only one feature that matches the search.

```ruby
feature = cucumber_monitor.features.where(name: 'managing_users')
```

The context (background) object returns (when present):

```ruby
context = feature.contexts.first
context.name # when present, shows the name
context.keyword # "Background"
context.feature # The feature object
context.steps # list of all the step objects of the given context/background
```

The scenario object returns:

```ruby
scenario = feature.scenarios.first
scenario.name # "Adding a new user"
scenario.keyword # "Scenario"
scenario.feature # The feature object
scenario.steps # list of all step objects of the given scenario
```

As you do with features, you can find scenarios by name:

```ruby
scenario = feature.scenarios.where(name: 'Adding a new user')
```

The step object returns:

```ruby
step = scenario.steps.first
step.description # "Given I want to create an user with email \"david@webhall.com.br\" and password \"secret\""
step.description_without_keyword # "I want to create an user with email \"david@webhall.com.br\" and password \"secret\""
step.code # gives an string as an unique indentifier
step.parent # context or scenario object
step.id # number identifier
step.siblings_and_self # list of all the siblings step objects including the given step
step.previous # the previous step (when present)
step.next # the next step (when present)
step.table? # returns true if the step is part of a table
step.table_first_line? # returns true if the step is the first line of the table
step.table_last_line? # returns true if the step is the last line of the table
step.table_row? # returns true if the step is part of a table but is not the table header
step.table.content # returns an array of the content of the given line of the table
step.not_a_table? # returns true if the step is not a table
step.implemented? # returns true if the step has a step definition
step.definition # returns the definition object
step.params # if implemented, returns a hash with the step params. i.e.: {:email=>"david@webhall.com.br", :password=>"secret"}
step.named_params # if implemented, returns an array of the params names. i.e.: ["email", "password"]
```

As you do with features and contexts/scenarios, you can also find steps by name. It returns an array of step objects when there is more then one step that matches the search. It returns the step object if there is only one feature that matches the search.

```ruby
cucumber_monitor.features.where(name: 'managing_users').scenarios.where(name: 'Adding a new user').steps.where(description: 'create an user')
```

If you want to search through all steps:

```ruby
cucumber_monitor.search('create') # it will return all steps that have the word 'create'
```

The definition object returns:

```ruby
definition = step.definition
definition.description # "Given /^I want to create an user with email \"(.*)\" and password \"(.*)\"$/ do |email, password|" 
definition.file # the step definition file object
definition.file.file # "managing_users_step.rb"
definition.file.path # the full path of the file
definition.file.name # "managin_users"
definition.file.definitions # list of the all definitions object of the given definition file
definition.line # line number of the definition
definition.matcher # the regex of the definition
definition.content # returns an array with all the lines of the definition, including the definition regex and the end block
definition.core_content # returns only the implementation of the definition
definition.location # "managin_user_step.rb:2"
definition.location_path # "/path/to/app/features/step_definitions/managing_users_step.rb:2"
```

### I18n

You can change the language of CucumberMonitor's views by adding your own locale file:

```yaml
"en":
  results:
    passed: passed
    failed: failed
    skipped: skipped
  buttons: 
    search: Search
  links:
    back_to_features_link: Back to features list
  cucumber_monitor:
    features:
      title: Cucumber Features
      total_features_note: "You have %{total} features"
      table:
        th:
          name: name
          description: Description
          file: File
    show_feature:
      feature: Feature
      background: Background
      scenario: Scenario
    search: 
      title: Search
      search_results: Search results
      features_search_results: Features search results
      steps_search_results: Steps search results
      scope: Scope
      file: File
      results_not_found_for: "Results not found for '<strong>%{criteria}</strong>'"
```

## TODO

* Create and implement features in browser
* Add a step definition builder
* Run sets of features and get the result
* Manage tags
* Manage profiles
* Manage hooks

... and so much more.

## Bug reports

If you find a bug, please, feel free to report that. It will be helpful if you add as much information as
possible to help me fixing the bug. You can also fork and send me a pull request.

https://github.com/davidwilliam/cucumber_monitor/issues

## Maintainer

* David William (https://github.com/davidwilliam)

## License

MIT License. Copyright 2012 David William.



