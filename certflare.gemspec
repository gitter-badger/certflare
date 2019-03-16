
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "certflare/version"

Gem::Specification.new do |spec|
  spec.name          = "certflare"
  spec.version       = Certflare::VERSION
  spec.authors       = ["Ken Spencer"]
  spec.email         = ["me@iotaspencer.me"]

  spec.summary       = %q{This summary is a summary of a summary}
  spec.homepage      = "https://iotaspencer.me/projects/certflare/"
  spec.license       = "MIT"

<<<<<<< HEAD
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.

=======
>>>>>>> master
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency 'highline'
  spec.add_dependency 'thor'


  spec.add_dependency 'cloudflare_client_rb'
  spec.add_dependency 'configparser'
  spec.add_dependency 'public_suffix'
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
