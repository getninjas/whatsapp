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

For the gem to be useful you need a WhatsApp Business account from facebook. You can get it here: https://developers.facebook.com/docs/whatsapp/getting-started

That link also has the documentation for the whatsapp api, which this gem aims to encapsulate

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

Which results in:

```
+ ------ STUB ------
+ Request:  POST http://test.local/v1/contacts with body "{\"blocking\":\"wait\",\"contacts\":[\"+5511944442222\"]}" with headers {'Content-Type'=>'application/json'}
+ Response: {"contacts":[{"input":"+5511944442222","status":"valid","wa_id":"5511944442222"}]}
+ ------------------
.+ ------ STUB ------
+ Request:  POST http://test.local/v1/contacts with body "{\"blocking\":\"wait\",\"contacts\":[\"+5511944442222\",\"+55119000888\"]}" with headers {'Content-Type'=>'application/json'}
+ Response: {"contacts":[{"input":"+5511944442222","status":"valid","wa_id":"5511944442222"},{"input":"+55119000888","status":"valid","wa_id":"55119000888"}]}
+ ------------------
.+ ------ STUB ------
+ Request:  POST http://test.local/v1/contacts with body "{\"blocking\":\"wait\",\"contacts\":[\"+123\"]}" with headers {'Content-Type'=>'application/json'}
+ Response: {"contacts":[{"input":"+123","status":"invalid"}]}
+ ------------------
.+ ------ STUB ------
+ Request:  POST http://test.local/v1/users/login with body "" with headers {'Authorization'=>'Basic dXNlcm5hbWU6c2VjcmV0X3Bhc3N3b3Jk'}
+ Response: {"users":[{"token":"toooo.kkkkk.eeeen","expires_after":"2099-03-01 15:29:26+00:00"}]}
+ ------------------
.+ ------ STUB ------
+ Request:  POST http://test.local/v1/messages with body "{\"hsm\":{\"element_name\":\"two_factor\",\"language\":{\"code\":\"pt_BR\",\"policy\":\"deterministic\"},\"localizable_params\":{\"default\":\"1234\"},\"namespace\":\"whatsapp:hsm:banks:enterprisebank\"},\"recipient_type\":\"individual\",\"to\":\"55119000111\",\"type\":\"hsm\"}" with headers {'Content-Type'=>'application/json'}
+ Response: {"messages":{"id":"ID"}}
+ ------------------
.+ ------ STUB ------
+ Request:  POST http://test.local/v1/messages with body "{\"hsm\":{\"element_name\":\"two_factor\",\"language\":{\"code\":\"pt_BR\",\"policy\":\"deterministic\"},\"localizable_params\":{\"default\":\"1234\"},\"namespace\":\"whatsapp:hsm:banks:enterprisebank\"},\"recipient_type\":\"individual\",\"to\":\"123\",\"type\":\"hsm\"}" with headers {'Content-Type'=>'application/json'}
+ Response: {"errors":[{"code":1006,"details":"unknown contact","title":"Resource not found"}]}
+ ------------------
.+ ------ STUB ------
+ Request:  POST http://test.local/v1/messages with body "{\"hsm\":{\"element_name\":\"two_factor\",\"language\":{\"code\":\"pt_BR\",\"policy\":\"deterministic\"},\"localizable_params\":{\"default\":\"1234\"},\"namespace\":\"whatsapp:hsm:banks:enterprisebank\"},\"recipient_type\":\"individual\",\"to\":\"123\",\"type\":\"hsm\"}" with headers {'Content-Type'=>'application/json'}
+ Response: {"errors":[{"code":1006,"details":"unknown contact","title":"Resource not found"}]}
+ ------------------
.+ ------ STUB ------
+ Request:  POST http://test.local/v1/messages with body "{\"recipient_type\":\"individual\",\"to\":\"5511944442222\",\"type\":\"text\",\"text\":{\"body\":\"Message!\"}}" with headers {'Content-Type'=>'application/json'}
+ Response: {"messages":{"id":"ID"}}
+ ------------------
.+ ------ STUB ------
+ Request:  POST http://test.local/v1/messages with body "{\"recipient_type\":\"individual\",\"to\":\"123\",\"type\":\"text\",\"text\":{\"body\":\"Message!\"}}" with headers {'Content-Type'=>'application/json'}
+ Response: {"errors":[{"code":1006,"details":"unknown contact","title":"Resource not found"}]}
+ ------------------
.+ ------ STUB ------
+ Request:  POST http://test.local/v1/messages with body "{\"recipient_type\":\"individual\",\"to\":\"123\",\"type\":\"text\",\"text\":{\"body\":\"Message!\"}}" with headers {'Content-Type'=>'application/json'}
+ Response: {"errors":[{"code":1006,"details":"unknown contact","title":"Resource not found"}]}
+ ------------------
.+ ------ STUB ------
+ Request:  POST http://test.local/v1/messages with body "{\"recipient_type\":\"individual\",\"to\":\"\",\"type\":\"text\",\"text\":{\"body\":\"Message!\"}}" with headers {'Content-Type'=>'application/json'}
+ Response: {"error":{"errorcode":400,"errortext":"missing params payload|to"}}
+ ------------------
.+ ------ STUB ------
+ Request:  POST http://test.local/v1/messages with body "{\"recipient_type\":\"individual\",\"to\":\"\",\"type\":\"text\",\"text\":{\"body\":\"Message!\"}}" with headers {'Content-Type'=>'application/json'}
+ Response: {"error":{"errorcode":400,"errortext":"missing params payload|to"}}
+ ------------------
.+ ------ STUB ------
+ Request:  POST http://test.local/v1/messages with body "{\"recipient_type\":\"individual\",\"to\":\"5511944442222\",\"type\":\"text\",\"text\":{\"body\":\"\"}}" with headers {'Content-Type'=>'application/json'}
+ Response: {"error":{"errorcode":400,"errortext":"missing required message body definition"}}
+ ------------------
.+ ------ STUB ------
+ Request:  POST http://test.local/v1/messages with body "{\"recipient_type\":\"individual\",\"to\":\"5511944442222\",\"type\":\"text\",\"text\":{\"body\":\"\"}}" with headers {'Content-Type'=>'application/json'}
+ Response: {"error":{"errorcode":400,"errortext":"missing required message body definition"}}
+ ------------------
...............

Finished in 0.11157 seconds (files took 0.86592 seconds to load)
28 examples, 0 failures


COVERAGE: 100.00% -- 185/185 lines in 7 files

```
