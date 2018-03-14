# WhatsApp

An ruby interface to WhatsApp Enterprise API.

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
