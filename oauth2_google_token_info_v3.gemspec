
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "oauth2_google_token_info_v3/version"

Gem::Specification.new do |spec|
  spec.name          = "oauth2_google_token_info_v3"
  spec.version       = Oauth2GoogleTokenInfoV3::VERSION
  spec.authors       = ["Dmytro Stepaniuk"]
  spec.email         = ["stepaniuk@mlsdev.com"]

  spec.summary       = %q{OAuth tokeninfo}
  spec.description   = %q{google-api-ruby-client still dont have support for oauth_v3 - that's why this gem appeared}
  spec.homepage      = "https://mlsdev.com"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["homepage_uri"] = spec.homepage
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "rspec-its"
  spec.add_development_dependency "rexml"
end
