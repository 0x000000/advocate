lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'advocate/version'

Gem::Specification.new do |gem|
  gem.name          = "advocate"
  gem.version       = Advocate::VERSION
  gem.authors       = ["Alexander Rudenko"]
  gem.email         = %w(mur.mailbox@gmail.com)
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = %w(lib)

  gem.add_development_dependency "rspec", "~> 2.14"
end
