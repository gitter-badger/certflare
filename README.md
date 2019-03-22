# Certflare

[![Join the chat at https://gitter.im/Certflare/community](https://badges.gitter.im/Certflare/community.svg)](https://gitter.im/Certflare/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Certflare is an easier and quicker way to your certs from certbot/letsencrypt/ietf.
Why make your own script when something does it better and easier, especially if you don't know ruby.

Just install this, run xxxxx and you'll be on your way,  
and certbot and certflare will work together to keep  
your certificates valid.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'certflare'
```

And then execute:

    bundle

Or install it yourself as:

    gem install certflare

## Usage

### As a Hook

#### Authenticating:

    certflare_hook auth [options]
    
    certbot --auth-hook="certflare_hook auth [options]"

#### Cleaning Up

    certflare_hook clean [options]

### As a client itself

    certflare

## Contributing

Bug reports and pull requests are welcome on GitHub  
 at [IotaSpencer/certflare](https://github.com/IotaSpencer/certflare).  
 
 This project is intended to be a safe, welcoming space for collaboration.  
 Contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Certflare project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/IotaSpencer/certflare/blob/master/CODE_OF_CONDUCT.md).
