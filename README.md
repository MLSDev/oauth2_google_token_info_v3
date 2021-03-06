[![CircleCI](https://circleci.com/gh/MLSDev/oauth2_google_token_info_v3/tree/master.svg?style=svg)](https://circleci.com/gh/MLSDev/oauth2_google_token_info_v3/tree/master)


# Oauth2GoogleTokenInfoV3

Regarding to [this issue](https://github.com/googleapis/google-api-ruby-client/issues/596) `OAuth2_v3 ` is not implemented yet in [google-api-ruby-client](https://github.com/googleapis/google-api-ruby-client) gem.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'oauth2_google_token_info_v3', tag: 'vX.X.X', github: 'MLSDev/oauth2_google_token_info_v3'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install oauth2_google_token_info_v3

## Usage

To use this tool, you will need to generate [`id_token`](https://developers.google.com/identity/sign-in/web/backend-auth#send-the-id-token-to-your-server).

Then U can perform request to www.googleapis.com:

```ruby
r = Oauth2GoogleTokenInfoV3::HttpsRequest.new(id_token)

r.response
r.subject
r.email
r.hosted_domain
r.given_name
r.first_name
r.last_name
r.family_name
r.locale
r.expire_at
r.not_expired?
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then push all commits and create release via tag.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MLSDev/oauth2_google_token_info_v3. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Oauth2GoogleTokenInfoV3 project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/MLSDev/oauth2_google_token_info_v3/blob/master/CODE_OF_CONDUCT.md).

## About MLSDev

![MLSdev][logo]

The repo is maintained by MLSDev, Inc. We specialize in providing all-in-one solution in mobile and web development. Our team follows Lean principles and works according to agile methodologies to deliver the best results reducing the budget for development and its timeline.

Find out more [here][mlsdev] and don't hesitate to [contact us][contact]!

[mlsdev]:  https://mlsdev.com
[contact]: https://mlsdev.com/contact_us
[logo]:    https://raw.githubusercontent.com/MLSDev/development-standards/master/mlsdev-logo.png "Mlsdev"

