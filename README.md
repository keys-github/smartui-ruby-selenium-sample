# SmartUI SDK Sample for Selenium Ruby

Welcome to the SmartUI SDK sample for Selenium Ruby. This repository demonstrates how to integrate SmartUI visual regression testing with Selenium Ruby.

## Repository Structure

```
smartui-ruby-selenium-sample/
├── sdk/
│   ├── sdkCloud.rb          # Cloud test
│   ├── sdkLocal.rb          # Local test
│   ├── ignore_select.rb     # Example with ignore options
│   ├── package.json         # SmartUI CLI dependency
│   └── smartui-web.json     # SmartUI config (create with npx smartui config:create)
└── hooks/                    # Hooks integration examples
    └── smartui_hooks.rb
```

## 1. Prerequisites and Environment Setup

### Prerequisites

- Ruby 2.7 or higher
- Node.js (for SmartUI CLI)
- LambdaTest account credentials (for Cloud tests)
- Chrome browser (for Local tests)

### Environment Setup

**For Cloud:**
```bash
export LT_USERNAME='your_username'
export LT_ACCESS_KEY='your_access_key'
export PROJECT_TOKEN='your_project_token'
```

**For Local:**
```bash
export PROJECT_TOKEN='your_project_token'
```

## 2. Initial Setup and Dependencies

### Clone the Repository

```bash
git clone https://github.com/LambdaTest/smartui-ruby-selenium-sample
cd smartui-ruby-selenium-sample/sdk
```

### Install Dependencies

Install the required dependencies:

```bash
npm install @lambdatest/smartui-cli
gem install lambdatest-selenium-driver selenium-webdriver
```

**Dependencies included:**
- `@lambdatest/smartui-cli` - SmartUI CLI (via npm)
- `lambdatest-selenium-driver` - SmartUI SDK for Selenium Ruby (via gem)
- `selenium-webdriver` - Selenium WebDriver for Ruby (via gem)

**Note**: ChromeDriver is automatically managed by Selenium WebDriver.

### Create SmartUI Configuration

```bash
npx smartui config:create smartui-web.json
```

## 3. Steps to Integrate Screenshot Commands into Codebase

The SmartUI screenshot function is already implemented in the repository.

**Cloud Test** (`sdk/sdkCloud.rb`):
```ruby
driver.navigate.to "https://www.lambdatest.com"
Lambdatest::Selenium::Driver.smartui_snapshot(driver, "screenshot")
```

**Local Test** (`sdk/sdkLocal.rb`):
```ruby
driver.navigate.to "https://www.lambdatest.com"
Lambdatest::Selenium::Driver.smartui_snapshot(driver, "screenshot")
```

**Note**: The code is already configured and ready to use. You can modify the URL and screenshot name if needed.

## 4. Execution and Commands

### Local Execution

```bash
npx smartui exec ruby sdkLocal.rb
```

### Cloud Execution

```bash
npx smartui exec ruby sdkCloud.rb
```

## Test Files

### Cloud Test (`sdk/sdkCloud.rb`)

- Connects to LambdaTest Cloud using Selenium Remote WebDriver
- Reads credentials from environment variables (`LT_USERNAME`, `LT_ACCESS_KEY`)
- Takes screenshot with name: `screenshot`

### Local Test (`sdk/sdkLocal.rb`)

- Runs Selenium locally using Chrome
- Requires Chrome browser installed
- Takes screenshot with name: `screenshot`

### Ignore Example (`sdk/ignore_select.rb`)

- Demonstrates how to use ignore options in SmartUI snapshots
- Shows how to exclude specific DOM elements from visual comparison

## Testing with LambdaTest Hooks

This repository also includes examples for using SmartUI with LambdaTest Hooks integration. Hooks-based integration allows you to use SmartUI directly within your existing LambdaTest Cloud automation tests without requiring the SmartUI CLI.

### SDK vs Hooks: Which Approach to Use?

**SDK Approach (Recommended for Local Testing):**
- ✅ Works with both local and cloud execution
- ✅ Uses SmartUI CLI for configuration and execution
- ✅ Supports multiple browsers and viewports via `smartui-web.json`
- ✅ Better for CI/CD integration
- ✅ Requires `PROJECT_TOKEN` environment variable

**Hooks Approach (Recommended for Cloud-Only Testing):**
- ✅ Works only with LambdaTest Cloud Grid
- ✅ No CLI required - direct integration with LambdaTest
- ✅ Uses LambdaTest capabilities for configuration
- ✅ Better for existing LambdaTest automation suites
- ✅ Requires `LT_USERNAME` and `LT_ACCESS_KEY` environment variables

### Hooks Integration Setup

**Location:** See the `hooks` folder for hooks integration examples.

**Purpose:** Enhance visual regression capabilities in your LambdaTest web automation tests running on LambdaTest Cloud Grid.

**Documentation:** [LambdaTest Selenium Visual Regression Documentation](https://www.lambdatest.com/support/docs/selenium-visual-regression-testing/).

### Hooks Setup Steps

#### 1. Install Dependencies

Install the required Ruby gems:

```bash
gem install selenium-webdriver
```

#### 2. Configure Environment Variables

Set your LambdaTest credentials:

```bash
export LT_USERNAME='your_username'
export LT_ACCESS_KEY='your_access_key'
```

#### 3. Configure Capabilities

In your test file (e.g., `hooks/smartui_hooks.rb`), configure the capabilities with SmartUI options:

```ruby
require 'selenium-webdriver'

USERNAME = ENV["LT_USERNAME"]
ACCESS_KEY = ENV["LT_ACCESS_KEY"]

options = Selenium::WebDriver::Options.chrome
options.browser_version = "119.0"
options.platform_name = "Windows 10"

lt_options = {
  username: USERNAME,
  accessKey: ACCESS_KEY,
  project: "Ruby Hooks Test",
  sessionName: "Ruby Test",
  build: "Ruby Job",
  w3c: true,
  plugin: "ruby-ruby",
  'smartUI.project': "Ruby-Project"  # Your SmartUI project name
}
options.add_option('LT:Options', lt_options)
```

#### 4. Connect to LambdaTest Grid

Create a WebDriver instance connected to LambdaTest Cloud:

```ruby
driver = Selenium::WebDriver.for(:remote,
  url: "https://hub.lambdatest.com/wd/hub",
  capabilities: options)
```

#### 5. Add Screenshot Hooks

Use `driver.execute_script()` to capture screenshots at any point in your test:

```ruby
# Navigate to your page
driver.navigate.to "https://www.lambdatest.com/visual-regression-testing"

# Take a screenshot with basic configuration
config = {
  'screenshotName' => 'SmartUI-Home',
  'fullPage' => true
}
driver.execute_script("smartui.takeScreenshot", config)

# Take a viewport screenshot (visible area only)
viewport_config = {
  'screenshotName' => 'SmartUI-Home-Viewport',
  'fullPage' => false
}
driver.execute_script("smartui.takeScreenshot", viewport_config)
```

#### 6. Run the Test

Execute your test script:

```bash
cd hooks
ruby smartui_hooks.rb
```

### Advanced Hooks Examples

#### Multiple Screenshots in One Test

```ruby
driver.navigate.to "https://www.lambdatest.com"

# Screenshot 1: Homepage
config1 = {
  'screenshotName' => 'homepage',
  'fullPage' => true
}
driver.execute_script("smartui.takeScreenshot", config1)

# Navigate and take another screenshot
driver.navigate.to "https://www.lambdatest.com/pricing"
config2 = {
  'screenshotName' => 'pricing-page',
  'fullPage' => true
}
driver.execute_script("smartui.takeScreenshot", config2)
```

#### Screenshot with Custom Options

```ruby
config = {
  'screenshotName' => 'homepage-custom',
  'fullPage' => true,
  'ignore' => ['antialiasing', 'colors']
}
driver.execute_script("smartui.takeScreenshot", config)
```

### Hooks Configuration Options

The SmartUI hooks support various configuration options:

- **screenshotName**: Name for the screenshot (required)
- **fullPage**: Set to `true` for full-page screenshot, `false` for viewport only
- **ignore**: Array of visual artifacts to ignore (`"antialiasing"`, `"colors"`, etc.)

### View Hooks Results

After running your hooks-based tests, visit the [LambdaTest Automation Dashboard](https://automation.lambdatest.com/) to view:
- Test execution status
- Screenshots captured
- Visual comparison results
- Build and session details

Navigate to your SmartUI project in the [SmartUI Dashboard](https://smartui.lambdatest.com/) to see detailed visual regression results.

## Best Practices

### Screenshot Naming

- Use descriptive, unique names for each screenshot
- Follow Ruby naming conventions (snake_case)
- Include page/component name and state
- Avoid special characters

### When to Take Screenshots

- After critical user interactions
- Before and after form submissions
- At different stages of multi-step processes
- After page state changes

### Ruby-Specific Tips

- Use explicit waits before taking screenshots
- Handle exceptions properly with begin/rescue/ensure
- Use descriptive variable names
- Follow Ruby style guidelines

### Example: Screenshot with Waits

```ruby
require 'selenium-webdriver'

wait = Selenium::WebDriver::Wait.new(timeout: 10)
wait.until { driver.find_element(id: 'main-content') }
Lambdatest::Selenium::Driver.smartui_snapshot(driver, "homepage")
```

## Common Use Cases

### Multi-Step Flow Testing

```ruby
driver.navigate.to "https://example.com/checkout"
Lambdatest::Selenium::Driver.smartui_snapshot(driver, "checkout-step-1")

driver.find_element(id: "next-step").click
wait.until { driver.find_element(id: "step-2").displayed? }
Lambdatest::Selenium::Driver.smartui_snapshot(driver, "checkout-step-2")
```

### Error Handling

```ruby
begin
  driver.navigate.to "https://www.lambdatest.com"
  Lambdatest::Selenium::Driver.smartui_snapshot(driver, "homepage")
rescue => e
  puts "Screenshot failed: #{e.message}"
  raise
ensure
  driver.quit
end
```

## CI/CD Integration

### GitHub Actions Example

```yaml
name: Ruby SmartUI Tests

on: [push, pull_request]

jobs:
  visual-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.0'
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
      
      - name: Install dependencies
        run: |
          cd sdk
          gem install lambdatest-selenium-driver selenium-webdriver
          npm install @lambdatest/smartui-cli
      
      - name: Run SmartUI tests
        env:
          PROJECT_TOKEN: ${{ secrets.SMARTUI_PROJECT_TOKEN }}
          LT_USERNAME: ${{ secrets.LT_USERNAME }}
          LT_ACCESS_KEY: ${{ secrets.LT_ACCESS_KEY }}
        run: |
          cd sdk
          npx smartui exec ruby sdkCloud.rb
```

## Troubleshooting

### Issue: `uninitialized constant Lambdatest::Selenium::Driver`

**Solution**: Install the gem:
```bash
gem install lambdatest-selenium-driver
```

### Issue: `PROJECT_TOKEN is required`

**Solution**: Set the environment variable:
```bash
export PROJECT_TOKEN='your_project_token'
```

### Issue: `ChromeDriver version mismatch` (Local)

**Solution**: 
1. Update ChromeDriver
2. Use WebDriver Manager for automatic driver management
3. Ensure Chrome browser is up to date

### Issue: `Unauthorized` error (Cloud)

**Solution**:
1. Verify `LT_USERNAME` and `LT_ACCESS_KEY` are set correctly
2. Check credentials in [LambdaTest Profile Settings](https://accounts.lambdatest.com/profile)

## Configuration Tips

### Optimizing `smartui-web.json`

```json
{
  "web": {
    "browsers": ["chrome", "firefox"],
    "viewports": [
      [1920, 1080],
      [1366, 768],
      [375, 667]
    ],
    "waitForPageRender": 30000,
    "waitForTimeout": 2000
  }
}
```

## View Results

After running the tests, visit your SmartUI project dashboard to view the captured screenshots and compare them with baseline builds.

## Additional Resources

- [SmartUI Selenium Ruby Onboarding Guide](https://www.lambdatest.com/support/docs/smartui-onboarding-selenium-ruby/)
- [LambdaTest Selenium Ruby Documentation](https://www.lambdatest.com/support/docs/selenium-ruby/)
- [Ruby Documentation](https://www.ruby-lang.org/en/documentation/)
- [Selenium Ruby Documentation](https://www.selenium.dev/selenium/docs/api/rb/)
- [SmartUI Dashboard](https://smartui.lambdatest.com/)
- [LambdaTest Community](https://community.lambdatest.com/)
