# README

This is the back-end API integration for the fakepay (https://www.fakepay.io/challenge) gateway. When passed customer information and credit card data, a purchase will be attempted for them that, once successful, will create a subscription and stored payment profile for them. The payment profile will reference back to the card stored at the gateway using a token.

When you send a subscription request to the API, it will return a response for that new subscription. It won't contain the payment profile information. If the subscription or payment fail, an error will be returned instead.

## Getting Started

Run the Rails server:
`rails server`

Then run the following commands from the main Fakepay directory:
```touch .env
echo FAKEPAY_KEY = put-your-key-here >> .env
```

To run the test suite:
`bundle exec rspec spec`

Interactions with the Fakepay gateway have been pre-run and stored as VCRs.

## Attributes

These are required:
- first_name
- last_name
- amount
- card_number (won't be stored)
- cvv
- expiration_month
- expiration_year
- zip_code

These are optional, to be stored with the subscriber:
- address
- city
- state
- country

## Test Cards & Values

- 4242424242424242 is successful
- 4242424242424241 is invalid
- 4242424242420089 is lacking funds
- CVV must be 123

## Example CURLs

Once the server is running, you can send some CURL calls locally to create subscriptions and payment profiles.

### Successful Subscription & Payment Profile

```
curl "localhost:3000/subscriptions.json" \
  -X POST \
  -H "Content-Type: application/json" \
  -d \
  '{
    "subscription":
    {
      "first_name": "Penny",
      "last_name": "Duck",
      "address": "123 St",
      "city": "San Antonio",
      "state": "TX",
      "country": "US",
      "zip_code": "10045",
      "amount": "1000",
      "card_number": "4242424242424242",
      "cvv": "123",
      "expiration_month": "01",
      "expiration_year": "2024"
    }
  }'
```

### Calls That Will Fail

This example is missing a first and last name.
```
curl "localhost:3000/subscriptions.json" \
  -X POST \
  -H "Content-Type: application/json" \
  -d \
  '{
    "subscription":
    {
      "address": "123 St",
      "city": "San Antonio",
      "state": "TX",
      "country": "US",
      "zip_code": "10045",
      "amount": "1000",
      "card_number": "4242424242424242",
      "cvv": "123",
      "expiration_month": "01",
      "expiration_year": "2024"
    }
  }'
```

This example will decline due to insufficient funds.
```
curl "localhost:3000/subscriptions.json" \
  -X POST \
  -H "Content-Type: application/json" \
  -d \
  '{
    "subscription":
    {
      "first_name": "Penny",
      "last_name": "Duck",
      "address": "123 St",
      "city": "San Antonio",
      "state": "TX",
      "country": "US",
      "zip_code": "10045",
      "amount": "1000",
      "card_number": "4242424242420089",
      "cvv": "123",
      "expiration_month": "01",
      "expiration_year": "2024"
    }
  }'
```

