# Cucumber Monitor - Visualization and manipulation of cucumber features..

"**Cucumber** lets software development teams describe how software should behave in plain text. The text is written in a business-readable domain-specific language and serves as documentation, automated tests and development-aid - all rolled into one format". (From Cucumber's page: http://cukes.info/)

Cucumber is an extraordinary tool that allows developers and customers (and any other non-technical team member) work on the same feature description.

**Cucumber Monitor** aims to give a better view of the functionality described in Cucumber and enable better customer interaction.

With **Cucumber Monitor**, you have a dynamic documentation in real time. The client (and any other team member) can: 

* Browse through the features
* Search for keywords and track features, scenarios and steps that are added to Cucumber as developers move forward in their work
* Performs the features directly from the browser and displays the test results (*new*)

## Installation

Add it to your Gemfile:

`gem 'cucumber_monitor'`

Run the following command to install it:

`bundle install`

## Usage

Assuming you have a Rails application with Cucumber features, you need to access: /cucumber_monitor/features. Let's say you are running your application on localhost using port 3000:

`http://localhost:3000/cucumber_monitor`

You will see a list with all cucumber features you have. You can view the contents of each one and you can search by keywords.

## Bug reports

If you find a bug, please, feel free to report that. It will be helpful if you add as much information as
possible to help me fixing the bug. You can also fork and send me a pull request.

https://github.com/davidwilliam/cucumber_monitor/issues

## Maintainer

* David William (https://github.com/davidwilliam)

## License

MIT License. Copyright 2012 David William.



