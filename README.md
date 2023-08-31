# WhatsApp

[![Build Status](https://travis-ci.org/getninjas/whatsapp.svg?branch=master)](https://travis-ci.org/getninjas/whatsapp)
[![Gem Version](https://badge.fury.io/rb/whatsapp.svg)](https://badge.fury.io/rb/whatsapp)

A ruby interface to WhatsApp Enterprise API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "whatsapp"
```

Or manualy install
```bash
gem install whatsapp
```
then require it when there's a need to use it
```ruby
require "whatsapp"
```

## Usage

### Setting up a WhatsApp Business API Client

For the gem to be useful you need:
- A Facebook Business Manager account
- A verified business
- A WhatsApp business account
  
Check out: https://developers.facebook.com/docs/whatsapp/on-premises/get-started

### Configuration

```ruby
Whats.configure do |config|
  config.base_path = "https://example.test"
  config.phone_id = "your phone id"
  config.token = "your token"
end
```

Create an instance of the API client, which is going to be used from now on to interact with whatsapp

```ruby
whats = Whats::Api.new
```

### Check Contacts

Take a look [here](https://developers.facebook.com/docs/whatsapp/api/contacts) (WhatsApp Check Contacts doc) for more information.

```ruby
whats.check_contacts(["+5511942424242"])

# output:
{
  "contacts" => [
    {
      "input" => "+5511942424242",
      "status" => "valid",
      "wa_id" => "5511942424242"
    }
  ]
}
```

### Send Message

Take a look [here](https://developers.facebook.com/docs/whatsapp/api/messages/text) (WhatsApp Send Message doc) and [here](https://developers.facebook.com/docs/messenger-platform/send-messages/templates) (Whatsapp Message Templates) for more information.

```ruby
# To send a text message
whats.send_message("5511942424242", "text", "Message goes here.")

# To send a template message
body = {
 "messaging_product": "whatsapp",
 "recipient_type": "individual",
 "to": "9999999999999",
 "type": "interactive",
 "interactive": {
  "type": "list",
  "header": {
   "type": "text",
   "text": "books"
  },
  "body": {
   "text": "Select genre"
  },
  "action": {
   "button": "genres",
   "sections": [
    {
     "title": "genres",
     "rows": [
      {
       "id": "123",
       "title": "Terror"
      },
      {
       "id": "456",
       "title": "fantasy"
      },
      ...
     ]
    }
   ]
  }
 }
}

whats.send_message("5511942424242", "interactive", body)

# output:
{
  "messages" => [{
    "id" => "BAEC4D1D7549842627"
  }]
}
```

### Mark Messages as Read
Take a look [here](https://developers.facebook.com/docs/whatsapp/cloud-api/guides/mark-message-as-read) for more information.
```ruby
whats.mark_read("message_id")

# output:
{
  "success": true
}
```

### Receive a Message
To receive a message you should configure a webhook as explained [here](https://developers.facebook.com/docs/whatsapp/sample-app-endpoints#cloud-api-sample-app-endpoint). Take a look a simple Ruby on Rails example [here](https://github.com/saleszera/whatsapp_echo_bot/blob/main/app/controllers/webhooks_controller.rb)

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
