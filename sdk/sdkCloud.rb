require 'rubygems'
require 'selenium-webdriver'
require "lambdatest/selenium/driver"
# Input capabilities

USERNAME = ENV["LT_USERNAME"] || "USERNAME"
ACCESS_KEY = ENV["LT_ACCESS_KEY"] || "ACCESS_KEY"

options = Selenium::WebDriver::Options.chrome
options.browser_version = "119.0"
options.platform_name = "Windows 10"
lt_options = {};
lt_options[:username] = "#{USERNAME}";
lt_options[:accessKey] = "#{ACCESS_KEY}";
lt_options[:project] = "Ruby SDK";
lt_options[:sessionName] = "Ruby Test";
lt_options[:build] = "Ruby Job";
lt_options[:w3c] = true;
lt_options[:plugin] = "ruby-ruby";
options.add_option('LT:Options', lt_options);

driver = Selenium::WebDriver.for(:remote,
:url => "https://hub.lambdatest.com/wd/hub",
:capabilities => options)
begin

driver.navigate.to "https://www.lambdatest.com"
# Take a snapshot
Lambdatest::Selenium::Driver.smartui_snapshot(driver, "screenshot")

end
print("Execution Successful\n")
driver.quit
