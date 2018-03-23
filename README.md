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

### Instantiation

Create an instance of the API client passing the base path of your endpoint:

```ruby
whats = Whats::Api.new("https://my-whatsapp-endpoint.com")
```

### Check Contacts

Take a look [here](https://developers.facebook.com/docs/whatsapp/check-contacts) (WhatsApp Check Contacts doc) for more information.

```ruby
whats.check_contacts(["+5511942424242"])

# output:
{
  "meta" => {
    "waent version" => "2.18.4"
  },
  "payload" => {
    "results" => [
      {
        "input_number" => "+5511942424242",
        "wa_exists" => true,
        "wa_username" => "5511942424242"
      }
    ],
    "total" => 1
  },
  "error" => false
}
```

### Send Message

Take a look [here](https://developers.facebook.com/docs/whatsapp/send-api) (WhatsApp Send Message doc) for more information.

*The first parameter is the WhatsApp **username**!*

```ruby
whats.send_message("5511942424242", "Message goes here.")

# output:
{
  "meta" => {
    "waent version" => "2.18.4"
  },
  "payload" => {
    "message_id" => "BAEC4D1D7549842627"
  },
  "error" => false
}
```

## Tests

### Running tests

```shell
rspec .
```

### Debugging specs

You can print all stubs using the environment variable `PRINT_STUBS=true` like this:

```shell
PRINT_STUBS=true rspec .
```

Which results in:

```
Whats::Actions::SendMessage
  #call
    with valid params
+ ------ STUB ------
+ Request:  POST http://test.local/api/rest_send.php with body "{\"payload\":{\"to\":\"5511944442222\",\"body\":\"Message!\"}}" with headers {'Content-Type'=>'application/json'}
+ Response: {"payload":{"message_id":"ID"},"error":false}
+ ------------------
      returns message_in in the payload
    with unknown contact
+ ------ STUB ------
+ Request:  POST http://test.local/api/rest_send.php with body "{\"payload\":{\"to\":\"123\",\"body\":\"Message!\"}}" with headers {'Content-Type'=>'application/json'}
+ Response: {"payload":null,"error":{"errorcode":404,"errortext":"unknown contact"}}
+ ------------------
      returns error unknown contact

Finished in 0.0077 seconds (files took 0.59843 seconds to load)
2 examples, 0 failures
```
