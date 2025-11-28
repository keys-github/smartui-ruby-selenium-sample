# SmartUI SDK - Selenium Ruby

This folder contains the SmartUI SDK integration examples for Selenium Ruby.

## Files

- `sdkCloud.rb` - Cloud test example
- `sdkLocal.rb` - Local test example
- `ignore_select.rb` - Example demonstrating ignore options

## Quick Start

1. Install dependencies:
   ```bash
   npm install @lambdatest/smartui-cli
   gem install lambdatest-selenium-driver selenium-webdriver
   ```

2. Set your PROJECT_TOKEN:
   ```bash
   export PROJECT_TOKEN='your_project_token'
   ```

3. Create SmartUI config:
   ```bash
   npx smartui config:create smartui-web.json
   ```

4. Run tests:
   - Local: `npx smartui exec ruby sdkLocal.rb`
   - Cloud: `npx smartui exec ruby sdkCloud.rb`

For detailed instructions, see the main [README.md](../README.md) or the [SmartUI Selenium Ruby Onboarding Guide](https://www.lambdatest.com/support/docs/smartui-onboarding-selenium-ruby/).
