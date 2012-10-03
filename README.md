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

### CucumberMonitor API (WIP)

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

(Not finished yet)

## Bug reports

If you find a bug, please, feel free to report that. It will be helpful if you add as much information as
possible to help me fixing the bug. You can also fork and send me a pull request.

https://github.com/davidwilliam/cucumber_monitor/issues

## Maintainer

* David William (https://github.com/davidwilliam)

## License

MIT License. Copyright 2012 David William.



