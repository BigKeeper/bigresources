# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "bigToolBox/version"

Gem::Specification.new do |spec|
  spec.name          = "bigToolBox"
  spec.version       = BigToolBox::VERSION
  spec.authors       = ["Serena_R"]
  spec.email         = ["lirui050716@163.com"]

  spec.summary       = %q{A tools collection of iOS projects.}
  spec.description   = %q{A tools collection of iOS projects for iOS developer.}
  spec.homepage      = "https://github.com/Serena1993/bigToolBox"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "gli", "~> 2.16"
  spec.add_development_dependency "big_stash", "~> 0.1"
  spec.add_development_dependency "cocoapods"
  spec.add_development_dependency "plist"
  spec.add_development_dependency "colorize"
  spec.add_development_dependency "rubocop", "~> 0.50.0"
end
