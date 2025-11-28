require "selenium-webdriver"
require "lambdatest/selenium/driver"

driver = Selenium::WebDriver.for :chrome
driver.navigate.to "https://www.lambdatest.com"

# Take a snapshot
Lambdatest::Selenium::Driver.smartui_snapshot(driver, "screenshot")

driver.quit
