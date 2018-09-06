# WhatsApp

[![Build Status](https://travis-ci.org/getninjas/whatsapp.svg?branch=master)](https://travis-ci.org/getninjas/whatsapp)
[![Maintainability](https://api.codeclimate.com/v1/badges/0365e33bf574d4a94b3e/maintainability)](https://codeclimate.com/github/getninjas/whatsapp/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/0365e33bf574d4a94b3e/test_coverage)](https://codeclimate.com/github/getninjas/whatsapp/test_coverage)
[![Gem Version](https://badge.fury.io/rb/whatsapp.svg)](https://badge.fury.io/rb/whatsapp)

A ruby interface to WhatsApp Enterprise API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "whatsapp"
```

## Usage

### Setting up a WhatsApp Business API Client

For the gem to be useful you need a WhatsApp Business account from Facebook. You can get it here: https://developers.facebook.com/docs/whatsapp/getting-started

That link also has the documentation for the Whatsapp api, which this gem aims to encapsulate

### Instantiation

Configure the gem with a base path for the WhatsApp endpoint

```ruby
Whats.config do |config|
  config.base_path = "https://example.test"
end
```

Create an instance of the API client:

```ruby
whats = Whats::Api.new
```

### Check Contacts

Take a look [here](https://developers.facebook.com/docs/whatsapp/api/contacts) (WhatsApp Check Contacts doc) for more information.

```ruby
whats.check_contacts(["+5511942424242"])

# output:
{
  "results" => [
    {
      "input" => "+5511942424242",
      "status" => "valid",
      "wa_id" => "5511942424242"
    }
  ]
}
```

### Send Message

Take a look [here](https://developers.facebook.com/docs/whatsapp/api/messages/text) (WhatsApp Send Message doc) for more information.

*The first parameter is the WhatsApp **username**!*

```ruby
whats.send_message("5511942424242", "Message goes here.")

# output:
{
  "messages" => [{
    "id" => "BAEC4D1D7549842627"
  }]
}
```

## Tests

### Running tests

```shell
rspec
```

### Debugging specs

You can print all stubs using the environment variable `PRINT_STUBS=true` like this:

```shell
PRINT_STUBS=true rspec
```

All stubs can be seen in the debugging session from the wiki: https://github.com/getninjas/whatsapp/wiki/Debugging
